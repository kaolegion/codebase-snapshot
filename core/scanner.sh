#!/usr/bin/env bash
set -euo pipefail

is_excluded_path() {
    local path="$1"

    case "$path" in
        */.git/*|.git/*)
            return 0
            ;;
        */node_modules/*|node_modules/*)
            return 0
            ;;
        */dist/*|dist/*)
            return 0
            ;;
        */build/*|build/*)
            return 0
            ;;
        */__pycache__/*|__pycache__/*)
            return 0
            ;;
        */logs/*|logs/*)
            return 0
            ;;
        */snapshots/*|snapshots/*)
            return 0
            ;;
        */.snapshots/*|.snapshots/*)
            return 0
            ;;
        */SNAPSHOT_HISTORY.tsv|SNAPSHOT_HISTORY.tsv)
            return 0
            ;;
        */REPOSITORY_TIMELINE.md|REPOSITORY_TIMELINE.md)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

scan_files() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || {
        echo "[ERROR] Directory not found: $target_dir" >&2
        return 1
    }

    find "$target_dir" -type f | sort | while read -r file; do
        if ! is_excluded_path "$file"; then
            printf '%s\n' "$file"
        fi
    done
}
