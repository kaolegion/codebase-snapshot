#!/usr/bin/env bash
set -euo pipefail

SNAPSHOT_ROOT_DIR_DEFAULT="snapshots"
SNAPSHOT_HISTORY_ROOT_DIR_DEFAULT=".snapshots"
SNAPSHOT_HISTORY_INDEX_FILE_DEFAULT="SNAPSHOT_HISTORY.tsv"

snapshot_root_dir() {
    printf "%s/%s\n" "$ROOT_DIR" "$SNAPSHOT_ROOT_DIR_DEFAULT"
}

snapshot_history_root_dir() {
    printf "%s/%s\n" "$ROOT_DIR" "$SNAPSHOT_HISTORY_ROOT_DIR_DEFAULT"
}

snapshot_history_index_file() {
    printf "%s/%s\n" "$ROOT_DIR" "$SNAPSHOT_HISTORY_INDEX_FILE_DEFAULT"
}

load_config() {
    local config_file="$1"

    [[ -f "$config_file" ]] || {
        echo "[ERROR] Config file not found: $config_file" >&2
        return 1
    }

    while IFS='=' read -r key value; do
        [[ -z "$key" ]] && continue
        [[ "$key" =~ ^# ]] && continue

        value="${value%\"}"
        value="${value#\"}"

        export "$key=$value"

    done < "$config_file"
}
