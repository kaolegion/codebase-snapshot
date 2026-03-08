#!/usr/bin/env bash
set -euo pipefail

require_dir() {
    local dir="$1"

    [[ -d "$dir" ]] || {
        echo "[ERROR] Directory not found: $dir" >&2
        exit 1
    }
}

require_file() {
    local file="$1"

    [[ -f "$file" ]] || {
        echo "[ERROR] File not found: $file" >&2
        exit 1
    }
}

current_date() {
    date +"%Y-%m-%d"
}
