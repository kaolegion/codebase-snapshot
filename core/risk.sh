#!/usr/bin/env bash
set -euo pipefail

risk_output_file() {
    if [[ -n "${ROOT_DIR:-}" ]]; then
        printf "%s/REPOSITORY_RISKS.md\n" "$ROOT_DIR"
    else
        printf "%s/REPOSITORY_RISKS.md\n" "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
    fi
}

risk_dependencies_file() {
    if [[ -n "${ROOT_DIR:-}" ]]; then
        printf "%s/DEPENDENCIES.tsv\n" "$ROOT_DIR"
    else
        printf "%s/DEPENDENCIES.tsv\n" "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
    fi
}

risk_entrypoints_file() {
    if [[ -n "${ROOT_DIR:-}" ]]; then
        printf "%s/ENTRYPOINTS.tsv\n" "$ROOT_DIR"
    else
        printf "%s/ENTRYPOINTS.tsv\n" "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
    fi
}

risk_normalize_dependency_target() {
    local target="$1"

    target="${target#./}"
    target="${target#../}"
    target="${target#./}"
    target="${target#../}"

    if [[ "$target" == *'$ROOT_DIR/'* ]]; then
        target="${target#*\$ROOT_DIR/}"
    fi

    printf "%s\n" "$target"
}

risk_target_exists_in_snapshot() {
    local snapshot_dir="$1"
    local target="$2"

    [[ -n "$target" ]] || return 1

    if [[ -f "$snapshot_dir/$target" ]]; then
        return 0
    fi

    return 1
}

risk_collect_volatility_counts() {
    list_snapshots | awk -F'\t' 'NR > 1 { print $3 }' | while read -r snapshot_path; do
        [[ -n "$snapshot_path" ]] || continue
        [[ -f "$snapshot_path/INDEX.tsv" ]] || continue

        awk -F'\t' '
            $1 == "FILE" {
                print $2
            }
        ' "$snapshot_path/INDEX.tsv"
    done | awk '
        NF > 0 {
            counts[$0]++
        }
        END {
            for (file in counts) {
                printf "%s\t%d\n", file, counts[file]
            }
        }
    ' | sort
}

risk_collect_dependency_fan_in() {
    local dependencies_file
    dependencies_file="$(risk_dependencies_file)"

    [[ -f "$dependencies_file" ]] || return 0

    awk -F'\t' '
        $1 == "DEPENDENCY" {
            print $5
        }
    ' "$dependencies_file" | while read -r target; do
        [[ -n "$target" ]] || continue
        risk_normalize_dependency_target "$target"
    done | awk '
        NF > 0 {
            counts[$0]++
        }
        END {
            for (target in counts) {
                printf "%s\t%d\n", target, counts[target]
            }
        }
    ' | sort
}

risk_collect_entrypoints() {
    local entrypoints_file
    entrypoints_file="$(risk_entrypoints_file)"

    [[ -f "$entrypoints_file" ]] || return 0

    awk -F'\t' '
        $1 == "ENTRYPOINT" {
            print $2
        }
    ' "$entrypoints_file" | sort -u
}

risk_emit_signal_rows() {
    local latest_snapshot
    local volatility_file
    local fanin_file
    local entrypoints_file

    latest_snapshot="$(get_last_snapshot 2>/dev/null || true)"

    volatility_file="$(mktemp)"
    fanin_file="$(mktemp)"
    entrypoints_file="$(mktemp)"

    trap 'rm -f "$volatility_file" "$fanin_file" "$entrypoints_file"' RETURN

    risk_collect_volatility_counts > "$volatility_file"
    risk_collect_dependency_fan_in > "$fanin_file"
    risk_collect_entrypoints > "$entrypoints_file"

    awk -F'\t' '
        NF >= 2 {
            print $1 "\t" $2
        }
    ' "$volatility_file" | while IFS=$'\t' read -r file volatility_count; do
        [[ -n "$file" ]] || continue
        [[ -n "$volatility_count" ]] || volatility_count=0

        local fan_in_count=0
        local entrypoint_flag=0
        local core_flag=0
        local score=0
        local level="LOW"
        local reasons=()

        fan_in_count="$(awk -F'\t' -v file="$file" '$1 == file { print $2; found = 1 } END { if (!found) print 0 }' "$fanin_file" | tail -n 1)"

        if grep -Fxq "$file" "$entrypoints_file"; then
            entrypoint_flag=1
        fi

        if [[ "$file" == core/* ]]; then
            core_flag=1
        fi

        if (( volatility_count >= 3 )); then
            score=$((score + 2))
            reasons+=("high snapshot volatility ($volatility_count snapshots)")
        elif (( volatility_count == 2 )); then
            score=$((score + 1))
            reasons+=("moderate snapshot volatility ($volatility_count snapshots)")
        fi

        if (( fan_in_count >= 3 )); then
            score=$((score + 2))
            reasons+=("high dependency fan-in ($fan_in_count)")
        elif (( fan_in_count >= 1 )); then
            score=$((score + 1))
            reasons+=("dependency fan-in ($fan_in_count)")
        fi

        if (( entrypoint_flag == 1 )); then
            score=$((score + 1))
            reasons+=("critical entrypoint")
        fi

        if (( core_flag == 1 )); then
            score=$((score + 1))
            reasons+=("core subsystem sensitivity")
        fi

        if (( score >= 5 )); then
            level="HIGH"
        elif (( score >= 3 )); then
            level="MEDIUM"
        fi

        if [[ "${#reasons[@]}" -eq 0 ]]; then
            reasons=("limited deterministic risk evidence")
        fi

        printf "%s\t%s\t%s\t%s\t%s\t%s\n" \
            "$level" \
            "$file" \
            "$score" \
            "$volatility_count" \
            "$fan_in_count" \
            "$(IFS='; '; printf '%s' "${reasons[*]}")"
    done
}

risk_sort_rows() {
    sort -t $'\t' -k1,1 -k3,3nr -k2,2
}

render_repository_risks() {
    local total_snapshots
    local total_signals
    local high_count
    local medium_count
    local low_count
    local signal_rows

    total_snapshots="$(list_snapshots | awk 'NR > 1 { count++ } END { print count + 0 }')"
    signal_rows="$(risk_emit_signal_rows | risk_sort_rows)"

    total_signals="$(printf '%s\n' "$signal_rows" | awk 'NF > 0 { count++ } END { print count + 0 }')"
    high_count="$(printf '%s\n' "$signal_rows" | awk -F'\t' '$1 == "HIGH" { count++ } END { print count + 0 }')"
    medium_count="$(printf '%s\n' "$signal_rows" | awk -F'\t' '$1 == "MEDIUM" { count++ } END { print count + 0 }')"
    low_count="$(printf '%s\n' "$signal_rows" | awk -F'\t' '$1 == "LOW" { count++ } END { print count + 0 }')"

    cat <<EOF_MD
# Repository Risk Signals

## Deterministic Risk Summary

- Archived snapshots analyzed: $total_snapshots
- Risk signals emitted: $total_signals
- High risk files: $high_count
- Medium risk files: $medium_count
- Low risk files: $low_count

## High Risk Areas
EOF_MD

    printf '%s\n' "$signal_rows" | awk -F'\t' '
        $1 == "HIGH" {
            printf "- %s — score=%s — %s\n", $2, $3, $6
            found = 1
        }
        END {
            if (!found) {
                print "- none"
            }
        }
    '

    cat <<'EOF_MD'

## Medium Risk Areas
EOF_MD

    printf '%s\n' "$signal_rows" | awk -F'\t' '
        $1 == "MEDIUM" {
            printf "- %s — score=%s — %s\n", $2, $3, $6
            found = 1
        }
        END {
            if (!found) {
                print "- none"
            }
        }
    '

    cat <<'EOF_MD'

## Low Risk Areas
EOF_MD

    printf '%s\n' "$signal_rows" | awk -F'\t' '
        $1 == "LOW" {
            printf "- %s — score=%s — %s\n", $2, $3, $6
            found = 1
        }
        END {
            if (!found) {
                print "- none"
            }
        }
    '

    cat <<'EOF_MD'

## Risk Heuristics

- Volatility increases when a file appears across multiple archived snapshots.
- Dependency gravity increases when many dependency edges point to the same file.
- Entrypoints receive an additional criticality weight.
- Files under core/ receive an additional subsystem sensitivity weight.
- Risk levels are deterministic and evidence-based, not predictive.

## Evidence Sources

- SNAPSHOT_HISTORY.tsv
- snapshots/*/*/*/INDEX.tsv
- DEPENDENCIES.tsv
- ENTRYPOINTS.tsv
EOF_MD
}

write_repository_risks() {
    local output_file

    output_file="$(risk_output_file)"
    render_repository_risks > "$output_file"
    printf "%s\n" "$output_file"
}
