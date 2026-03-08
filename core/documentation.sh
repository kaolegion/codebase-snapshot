#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT_DIR/core/scanner.sh"

extract_doc_title() {
    local file="$1"

    title="$(grep -m 1 '^#' "$file" 2>/dev/null || true)"

    if [[ -n "${title:-}" ]]; then
        title="${title#\#}"
        title="${title#\#}"
        title="${title#\#}"
        title="$(printf '%s' "$title" | sed 's/^ *//')"
        printf '%s\n' "$title"
    else
        printf 'Untitled\n'
    fi
}

render_documentation_index() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || {
        echo "[ERROR] Directory not found: $target_dir" >&2
        return 1
    }

    cat <<DOC
# Documentation Index

This file was generated automatically by **codebase-snapshot**.

## Included Markdown Files

DOC

    scan_files "$target_dir" | while read -r file; do
        case "$file" in
            *.md)
                title="$(extract_doc_title "$file")"
                printf -- "- %s :: %s\n" "$file" "$title"
                ;;
        esac
    done
}
