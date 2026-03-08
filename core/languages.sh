#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT_DIR/core/scanner.sh"

file_type_label() {
    local file="$1"

    case "$file" in
        *.sh)   printf 'Shell\n' ;;
        *.md)   printf 'Markdown\n' ;;
        *.json) printf 'JSON\n' ;;
        *.yml|*.yaml) printf 'YAML\n' ;;
        *.txt)  printf 'Text\n' ;;
        *.py)   printf 'Python\n' ;;
        *.js)   printf 'JavaScript\n' ;;
        *.ts)   printf 'TypeScript\n' ;;
        *.go)   printf 'Go\n' ;;
        *.rs)   printf 'Rust\n' ;;
        *.c)    printf 'C\n' ;;
        *.cpp|*.cc|*.cxx) printf 'C++\n' ;;
        *.java) printf 'Java\n' ;;
        *.php)  printf 'PHP\n' ;;
        *.rb)   printf 'Ruby\n' ;;
        *.env)  printf 'Config\n' ;;
        *)      printf 'Other\n' ;;
    esac
}

render_languages() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || {
        echo "[ERROR] Directory not found: $target_dir" >&2
        return 1
    }

    cat <<'LANG'
# Language Summary

This file was generated automatically by **codebase-snapshot**.

## Detected File Types

LANG

    scan_files "$target_dir" | while read -r file; do
        file_type_label "$file"
    done | sort | uniq -c | while read -r count label; do
        printf -- "- %s: %s files\n" "$label" "$count"
    done
}
