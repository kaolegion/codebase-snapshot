#!/usr/bin/env bash
set -euo pipefail

health_output_file() {
    if [[ -n "${ROOT_DIR:-}" ]]; then
        printf "%s/REPOSITORY_HEALTH.md\n" "$ROOT_DIR"
    else
        printf "%s/REPOSITORY_HEALTH.md\n" "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
    fi
}

health_evolution_file() {
    if [[ -n "${ROOT_DIR:-}" ]]; then
        printf "%s/EVOLUTION_SIGNALS.tsv\n" "$ROOT_DIR"
    else
        printf "%s/EVOLUTION_SIGNALS.tsv\n" "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
    fi
}

health_signal_count() {
    local signal_name="$1"
    local evolution_file

    evolution_file="$(health_evolution_file)"

    [[ -f "$evolution_file" ]] || {
        printf "0\n"
        return 0
    }

    awk -v signal_name="$signal_name" '
        $1 == "SIGNAL" && $2 == signal_name { count++ }
        END { print count + 0 }
    ' "$evolution_file"
}

health_distinct_meta_values() {
    local key="$1"

    list_snapshots | awk -F'\t' 'NR > 1 { print $3 }' | while read -r snapshot_path; do
        [[ -n "$snapshot_path" ]] || continue
        timeline_meta_value "$snapshot_path" "$key"
    done | awk 'NF > 0 && $0 != "unknown" { seen[$0] = 1 } END { for (value in seen) print value }' | sort
}

health_distinct_meta_count() {
    local key="$1"

    health_distinct_meta_values "$key" | awk 'NF > 0 { count++ } END { print count + 0 }'
}

health_yes_no() {
    local value="$1"

    if [[ "$value" == "1" ]]; then
        printf "yes\n"
    else
        printf "no\n"
    fi
}

render_repository_health() {
    local total_snapshots
    local total_transitions
    local file_increased_count
    local file_decreased_count
    local file_stable_count
    local tool_version_count
    local label_count

    local repository_growing=0
    local repository_stable=0
    local change_activity_low=0
    local change_activity_moderate=0
    local tool_version_progressing=0
    local snapshot_labels_evolving=0

    local tool_versions_observed
    local labels_observed

    total_snapshots="$(list_snapshots | awk 'NR > 1 { count++ } END { print count + 0 }')"
    total_transitions=0
    if (( total_snapshots > 0 )); then
        total_transitions=$((total_snapshots - 1))
    fi

    file_increased_count="$(health_signal_count "FILE_COUNT_INCREASED")"
    file_decreased_count="$(health_signal_count "FILE_COUNT_DECREASED")"
    file_stable_count="$(health_signal_count "FILE_COUNT_STABLE")"

    tool_version_count="$(health_distinct_meta_count "tool_version")"
    label_count="$(health_distinct_meta_count "normalized_label")"

    tool_versions_observed="$(health_distinct_meta_values "tool_version" | paste -sd ', ' -)"
    labels_observed="$(health_distinct_meta_values "normalized_label" | paste -sd ', ' -)"

    [[ -n "$tool_versions_observed" ]] || tool_versions_observed="none"
    [[ -n "$labels_observed" ]] || labels_observed="none"

    if (( file_increased_count > file_decreased_count )) && (( file_increased_count > 0 )); then
        repository_growing=1
    fi

    if (( file_increased_count == 0 )) && (( file_decreased_count == 0 )) && (( file_stable_count > 0 )); then
        repository_stable=1
    fi

    if (( total_transitions <= 1 )); then
        change_activity_low=1
    fi

    if (( total_transitions >= 2 )); then
        change_activity_moderate=1
    fi

    if (( tool_version_count >= 2 )); then
        tool_version_progressing=1
    fi

    if (( label_count >= 2 )); then
        snapshot_labels_evolving=1
    fi

    cat <<EOF_MD
# Repository Health

## Repository Health Signals

- REPOSITORY_GROWING: $(health_yes_no "$repository_growing")
- REPOSITORY_STABLE: $(health_yes_no "$repository_stable")
- CHANGE_ACTIVITY_LOW: $(health_yes_no "$change_activity_low")
- CHANGE_ACTIVITY_MODERATE: $(health_yes_no "$change_activity_moderate")
- TOOL_VERSION_PROGRESSING: $(health_yes_no "$tool_version_progressing")
- SNAPSHOT_LABELS_EVOLVING: $(health_yes_no "$snapshot_labels_evolving")

## Signal Evidence

- Archived snapshots: $total_snapshots
- Snapshot transitions: $total_transitions
- FILE_COUNT_INCREASED events: $file_increased_count
- FILE_COUNT_DECREASED events: $file_decreased_count
- FILE_COUNT_STABLE events: $file_stable_count
- Tool versions observed: $tool_versions_observed
- Normalized labels observed: $labels_observed

## Deterministic Interpretation

- Repository growth signal: $( [[ "$repository_growing" == "1" ]] && printf "growth detected" || printf "no growth detected" )
- Repository stability signal: $( [[ "$repository_stable" == "1" ]] && printf "stable file count trend detected" || printf "stable file count trend not detected" )
- Change activity level: $( [[ "$change_activity_moderate" == "1" ]] && printf "moderate" || printf "low" )
- Tool version progression: $( [[ "$tool_version_progressing" == "1" ]] && printf "multiple tool versions observed" || printf "no tool version progression observed" )
- Snapshot label evolution: $( [[ "$snapshot_labels_evolving" == "1" ]] && printf "multiple normalized labels observed" || printf "no snapshot label evolution observed" )
EOF_MD
}

write_repository_health() {
    local output_file

    output_file="$(health_output_file)"
    render_repository_health > "$output_file"
    printf "%s\n" "$output_file"
}
