#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

snapshot_index_file() {
    local snapshot_dir="$1"
    printf "%s/INDEX.tsv\n" "$snapshot_dir"
}

require_snapshot_for_diff() {
    local snapshot_dir="$1"
    local index_file

    [[ -d "$snapshot_dir" ]] || {
        echo "[ERROR] Snapshot directory not found: $snapshot_dir" >&2
        return 1
    }

    index_file="$(snapshot_index_file "$snapshot_dir")"

    [[ -f "$index_file" ]] || {
        echo "[ERROR] Missing INDEX.tsv in snapshot: $snapshot_dir" >&2
        return 1
    }
}

snapshot_ref() {
    local snapshot_dir="$1"
    local label
    local version
    local date

    label="$(basename "$snapshot_dir")"
    version="$(basename "$(dirname "$snapshot_dir")")"
    date="$(basename "$(dirname "$(dirname "$snapshot_dir")")")"

    printf "%s/%s/%s" "$date" "$version" "$label"
}

sanitize_diff_token() {
    printf "%s" "$1" \
        | tr '/[:space:].:-' '_' \
        | tr -cd '[:alnum:]_' \
        | sed 's/__\+/_/g; s/^_//; s/_$//'
}

snapshot_diff_output_dir() {
    local snapshot_a="$1"
    local snapshot_b="$2"
    local ref_a
    local ref_b
    local token_a
    local token_b

    ref_a="$(snapshot_ref "$snapshot_a")"
    ref_b="$(snapshot_ref "$snapshot_b")"

    token_a="$(sanitize_diff_token "$ref_a")"
    token_b="$(sanitize_diff_token "$ref_b")"

    printf "%s/diffs/%s__to__%s\n" "$ROOT_DIR" "$token_a" "$token_b"
}

extract_index_records() {
    local index_file="$1"

    awk -F'\t' '
        $1 == "FILE" {
            print $2 "\t" $3 "\t" $4
        }
    ' "$index_file" | sort -t $'\t' -k1,1
}

generate_snapshot_diff() {
    local snapshot_a="$1"
    local snapshot_b="$2"
    local index_a
    local index_b
    local tmp_a
    local tmp_b

    require_snapshot_for_diff "$snapshot_a"
    require_snapshot_for_diff "$snapshot_b"

    index_a="$(snapshot_index_file "$snapshot_a")"
    index_b="$(snapshot_index_file "$snapshot_b")"

    tmp_a="$(mktemp)"
    tmp_b="$(mktemp)"

    extract_index_records "$index_a" > "$tmp_a"
    extract_index_records "$index_b" > "$tmp_b"

    awk -F'\t' '
        FNR == NR {
            left[$1] = $2 "\t" $3
            next
        }
        {
            right[$1] = $2 "\t" $3
        }
        END {
            for (path in left) {
                if (!(path in right)) {
                    print "DIFF\tREMOVED\t" path
                } else if (left[path] != right[path]) {
                    print "DIFF\tMODIFIED\t" path
                }
            }

            for (path in right) {
                if (!(path in left)) {
                    print "DIFF\tADDED\t" path
                }
            }
        }
    ' "$tmp_a" "$tmp_b" | sort -t $'\t' -k2,2 -k3,3

    rm -f "$tmp_a" "$tmp_b"
}

print_diff_section() {
    local diff_file="$1"
    local diff_type="$2"

    if awk -F'\t' -v wanted="$diff_type" '$1 == "DIFF" && $2 == wanted { found = 1 } END { exit(found ? 0 : 1) }' "$diff_file"; then
        awk -F'\t' -v wanted="$diff_type" '
            $1 == "DIFF" && $2 == wanted {
                printf "- %s\n", $3
            }
        ' "$diff_file"
    else
        echo "(none)"
    fi
}

has_diff_match() {
    local diff_file="$1"
    local pattern="$2"

    awk -F'\t' -v pattern="$pattern" '
        $1 == "DIFF" && $3 ~ pattern {
            found = 1
        }
        END {
            exit(found ? 0 : 1)
        }
    ' "$diff_file"
}

render_snapshot_diff() {
    local snapshot_a="$1"
    local snapshot_b="$2"
    local diff_file="${3:-}"
    local tmp_diff=""
    local added_count
    local removed_count
    local modified_count
    local total_count

    require_snapshot_for_diff "$snapshot_a"
    require_snapshot_for_diff "$snapshot_b"

    if [[ -z "$diff_file" ]]; then
        tmp_diff="$(mktemp)"
        generate_snapshot_diff "$snapshot_a" "$snapshot_b" > "$tmp_diff"
        diff_file="$tmp_diff"
    fi

    [[ -f "$diff_file" ]] || {
        echo "[ERROR] Diff file not found: $diff_file" >&2
        return 1
    }

    added_count="$(awk -F'\t' '$1 == "DIFF" && $2 == "ADDED" { count++ } END { print count + 0 }' "$diff_file")"
    removed_count="$(awk -F'\t' '$1 == "DIFF" && $2 == "REMOVED" { count++ } END { print count + 0 }' "$diff_file")"
    modified_count="$(awk -F'\t' '$1 == "DIFF" && $2 == "MODIFIED" { count++ } END { print count + 0 }' "$diff_file")"
    total_count=$((added_count + removed_count + modified_count))

    cat <<EOF_MD
# Snapshot Diff

Snapshot A:
$(snapshot_ref "$snapshot_a")

Snapshot B:
$(snapshot_ref "$snapshot_b")

Compared artifact:
INDEX.tsv

## Added Files

EOF_MD
    print_diff_section "$diff_file" "ADDED"
    cat <<'EOF_MD'

## Removed Files

EOF_MD
    print_diff_section "$diff_file" "REMOVED"
    cat <<'EOF_MD'

## Modified Files

EOF_MD
    print_diff_section "$diff_file" "MODIFIED"
    cat <<EOF_MD

## High-Level Interpretation

EOF_MD

    if [[ "$total_count" -eq 0 ]]; then
        echo "- No repository evolution detected between the two snapshots."
    else
        if has_diff_match "$diff_file" '(^|/)core/'; then
            echo "- Core engine evolution detected."
        fi
        if has_diff_match "$diff_file" '(^|/)bin/'; then
            echo "- CLI surface evolution detected."
        fi
        if has_diff_match "$diff_file" '(^|/)tests/'; then
            echo "- Test suite evolution detected."
        fi
        if has_diff_match "$diff_file" '(^|/)doc/|(^|/)(README[.]md|CHANGELOG[.]md|CODEBASE_ROOT[.]md)$'; then
            echo "- Documentation evolution detected."
        fi
        if ! has_diff_match "$diff_file" '(^|/)core/|(^|/)bin/|(^|/)tests/|(^|/)doc/|(^|/)(README[.]md|CHANGELOG[.]md|CODEBASE_ROOT[.]md)$'; then
            echo "- Repository evolution detected outside the standard core/documentation/test surfaces."
        fi
    fi

    cat <<EOF_MD

## Summary

Repository evolution summary:
- Added files: $added_count
- Removed files: $removed_count
- Modified files: $modified_count
- Total changed files: $total_count
EOF_MD

    if [[ -n "$tmp_diff" ]]; then
        rm -f "$tmp_diff"
    fi
}
