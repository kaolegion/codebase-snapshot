#!/usr/bin/env bash
set -euo pipefail

scan_files() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || {
        echo "[ERROR] Directory not found: $target_dir" >&2
        return 1
    }

    find "$target_dir" -type f | sort
}
