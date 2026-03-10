#!/usr/bin/env bash
set -euo pipefail

history_timestamp_utc() {
    date -u +"%Y-%m-%dT%H:%M:%SZ"
}

generate_snapshot_history_id() {
    date -u +"snapshot_%Y%m%d_%H%M%S"
}

init_snapshot_storage() {
    mkdir -p "$(snapshot_history_root_dir)"

    if [[ ! -f "$(snapshot_history_index_file)" ]]; then
        printf "TIMESTAMP\tSNAPSHOT_ID\tSNAPSHOT_PATH\n" > "$(snapshot_history_index_file)"
    fi
}

history_entry_exists() {
    local snapshot_id="$1"

    awk -F'\t' -v snapshot_id="$snapshot_id" '
        NR == 1 { next }
        $2 == snapshot_id { found = 1 }
        END { exit(found ? 0 : 1) }
    ' "$(snapshot_history_index_file)"
}

update_history_index() {
    local snapshot_id="$1"
    local snapshot_path="$2"
    local timestamp="$3"

    init_snapshot_storage

    if history_entry_exists "$snapshot_id"; then
        return 0
    fi

    printf "%s\t%s\t%s\n" "$timestamp" "$snapshot_id" "$snapshot_path" >> "$(snapshot_history_index_file)"
}

archive_snapshot() {
    local snapshot_dir="$1"
    local snapshot_id="$2"
    local archive_dir

    [[ -d "$snapshot_dir" ]] || {
        echo "[ERROR] Snapshot directory not found: $snapshot_dir" >&2
        return 1
    }

    init_snapshot_storage

    archive_dir="$(snapshot_history_root_dir)/$snapshot_id"
    rm -rf "$archive_dir"
    mkdir -p "$archive_dir"

    cp -R "$snapshot_dir"/. "$archive_dir"/

    printf "%s\n" "$archive_dir"
}

list_snapshots() {
    init_snapshot_storage
    cat "$(snapshot_history_index_file)"
}

get_last_snapshot() {
    init_snapshot_storage

    awk -F'\t' '
        NR == 1 { next }
        { last = $3 }
        END {
            if (last == "") {
                exit 1
            }
            print last
        }
    ' "$(snapshot_history_index_file)"
}

get_previous_snapshot() {
    init_snapshot_storage

    awk -F'\t' '
        NR == 1 { next }
        {
            previous = last
            last = $3
        }
        END {
            if (previous == "") {
                exit 1
            }
            print previous
        }
    ' "$(snapshot_history_index_file)"
}
