#!/usr/bin/env bash
set -euo pipefail

render_project_tree() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || {
        echo "[ERROR] Directory not found: $target_dir" >&2
        return 1
    }

    find "$target_dir" | sort
}
