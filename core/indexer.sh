#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT_DIR/core/scanner.sh"

generate_index() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || {
        echo "[ERROR] Directory not found: $target_dir" >&2
        return 1
    }

    scan_files "$target_dir" | while read -r file; do
        size="$(wc -c < "$file" | tr -d ' ')"
        lines="$(wc -l < "$file" | tr -d ' ')"

        printf "FILE\t%s\t%s\t%s\n" "$file" "$size" "$lines"
    done
}
