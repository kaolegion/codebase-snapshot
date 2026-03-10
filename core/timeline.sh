#!/usr/bin/env bash
set -euo pipefail

timeline_output_file() {
    if [[ -n "${ROOT_DIR:-}" ]]; then
        printf "%s/REPOSITORY_TIMELINE.md\n" "$ROOT_DIR"
    else
        printf "%s/REPOSITORY_TIMELINE.md\n" "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
    fi
}

timeline_meta_value() {
    local snapshot_dir="$1"
    local key="$2"
    local meta_file="$snapshot_dir/SNAPSHOT_META.json"

    [[ -f "$meta_file" ]] || {
        printf "unknown\n"
        return 0
    }

    sed -n 's/^[[:space:]]*"'$key'"[[:space:]]*:[[:space:]]*"\([^"]*\)".*$/\1/p' "$meta_file" | head -n 1
}

timeline_meta_number() {
    local snapshot_dir="$1"
    local key="$2"
    local meta_file="$snapshot_dir/SNAPSHOT_META.json"

    [[ -f "$meta_file" ]] || {
        printf "0\n"
        return 0
    }

    sed -n 's/^[[:space:]]*"'$key'"[[:space:]]*:[[:space:]]*\([0-9][0-9]*\).*$/\1/p' "$meta_file" | head -n 1
}

render_repository_timeline() {
    local total_snapshots
    local line_number
    local entry_index
    local timestamp
    local snapshot_id
    local snapshot_path
    local generated_at
    local label
    local normalized_label
    local tool_version
    local file_count

    total_snapshots="$(list_snapshots | awk 'NR > 1 { count++ } END { print count + 0 }')"

    cat <<EOF_MD
# Repository Timeline

This document provides a deterministic chronological view
of archived repository snapshots.

Total archived snapshots: $total_snapshots
EOF_MD

    if [[ "$total_snapshots" -eq 0 ]]; then
        cat <<'EOF_MD'

---

No archived snapshots are currently recorded.
EOF_MD
        return 0
    fi

    printf "\n---\n"

    entry_index=0

    while IFS=$'\t' read -r timestamp snapshot_id snapshot_path; do
        entry_index=$((entry_index + 1))

        generated_at="$(timeline_meta_value "$snapshot_path" "generated_at")"
        label="$(timeline_meta_value "$snapshot_path" "label")"
        normalized_label="$(timeline_meta_value "$snapshot_path" "normalized_label")"
        tool_version="$(timeline_meta_value "$snapshot_path" "tool_version")"
        file_count="$(timeline_meta_number "$snapshot_path" "file_count")"

        cat <<EOF_MD

## $entry_index. $snapshot_id

- Timestamp: $timestamp
- Generated at: $generated_at
- Tool version: $tool_version
- Label: $label
- Normalized label: $normalized_label
- File count: $file_count
- Archive path: $snapshot_path
EOF_MD
    done < <(list_snapshots | awk -F'\t' 'NR > 1 { print $1 "\t" $2 "\t" $3 }')
}

write_repository_timeline() {
    local output_file

    output_file="$(timeline_output_file)"
    render_repository_timeline > "$output_file"
    printf "%s\n" "$output_file"
}
