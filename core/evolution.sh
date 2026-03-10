#!/usr/bin/env bash
set -euo pipefail

evolution_output_file() {
    if [[ -n "${ROOT_DIR:-}" ]]; then
        printf "%s/EVOLUTION_SIGNALS.tsv\n" "$ROOT_DIR"
    else
        printf "%s/EVOLUTION_SIGNALS.tsv\n" "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
    fi
}

evolution_snapshot_count() {
    list_snapshots | awk 'NR > 1 { count++ } END { print count + 0 }'
}

evolution_meta_value() {
    local snapshot_dir="$1"
    local key="$2"
    local meta_file="$snapshot_dir/SNAPSHOT_META.json"

    [[ -f "$meta_file" ]] || {
        printf "unknown\n"
        return 0
    }

    sed -n 's/^[[:space:]]*"'$key'"[[:space:]]*:[[:space:]]*"\([^"]*\)".*$/\1/p' "$meta_file" | head -n 1
}

evolution_meta_number() {
    local snapshot_dir="$1"
    local key="$2"
    local meta_file="$snapshot_dir/SNAPSHOT_META.json"

    [[ -f "$meta_file" ]] || {
        printf "0\n"
        return 0
    }

    sed -n 's/^[[:space:]]*"'$key'"[[:space:]]*:[[:space:]]*\([0-9][0-9]*\).*$/\1/p' "$meta_file" | head -n 1
}

render_evolution_signals() {
    local previous_timestamp=""
    local previous_snapshot_id=""
    local previous_snapshot_path=""

    local current_timestamp=""
    local current_snapshot_id=""
    local current_snapshot_path=""

    local previous_file_count
    local current_file_count
    local previous_tool_version
    local current_tool_version
    local previous_label
    local current_label
    local delta

    while IFS=$'\t' read -r current_timestamp current_snapshot_id current_snapshot_path; do
        if [[ -z "$previous_snapshot_id" ]]; then
            previous_timestamp="$current_timestamp"
            previous_snapshot_id="$current_snapshot_id"
            previous_snapshot_path="$current_snapshot_path"
            continue
        fi

        previous_file_count="$(evolution_meta_number "$previous_snapshot_path" "file_count")"
        current_file_count="$(evolution_meta_number "$current_snapshot_path" "file_count")"

        if (( current_file_count > previous_file_count )); then
            delta=$((current_file_count - previous_file_count))
            printf "SIGNAL FILE_COUNT_INCREASED %s %s %s\n" \
                "$previous_snapshot_id" \
                "$current_snapshot_id" \
                "$delta"
        elif (( current_file_count < previous_file_count )); then
            delta=$((previous_file_count - current_file_count))
            printf "SIGNAL FILE_COUNT_DECREASED %s %s %s\n" \
                "$previous_snapshot_id" \
                "$current_snapshot_id" \
                "$delta"
        else
            printf "SIGNAL FILE_COUNT_STABLE %s %s 0\n" \
                "$previous_snapshot_id" \
                "$current_snapshot_id"
        fi

        previous_tool_version="$(evolution_meta_value "$previous_snapshot_path" "tool_version")"
        current_tool_version="$(evolution_meta_value "$current_snapshot_path" "tool_version")"

        if [[ "$previous_tool_version" != "$current_tool_version" ]]; then
            printf "SIGNAL TOOL_VERSION_CHANGED %s %s %s->%s\n" \
                "$previous_snapshot_id" \
                "$current_snapshot_id" \
                "$previous_tool_version" \
                "$current_tool_version"
        fi

        previous_label="$(evolution_meta_value "$previous_snapshot_path" "normalized_label")"
        current_label="$(evolution_meta_value "$current_snapshot_path" "normalized_label")"

        if [[ "$previous_label" != "$current_label" ]]; then
            printf "SIGNAL LABEL_CHANGED %s %s %s->%s\n" \
                "$previous_snapshot_id" \
                "$current_snapshot_id" \
                "$previous_label" \
                "$current_label"
        fi

        previous_timestamp="$current_timestamp"
        previous_snapshot_id="$current_snapshot_id"
        previous_snapshot_path="$current_snapshot_path"
    done < <(list_snapshots | awk -F'\t' 'NR > 1 { print $1 "\t" $2 "\t" $3 }')
}

write_evolution_signals() {
    local output_file

    output_file="$(evolution_output_file)"
    render_evolution_signals > "$output_file"
    printf "%s\n" "$output_file"
}
