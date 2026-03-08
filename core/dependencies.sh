#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT_DIR/core/scanner.sh"

sanitize_dependency_field() {
    local value="${1:-}"

    value="$(printf '%s' "$value" | tr '\t' ' ')"
    value="$(printf '%s' "$value" | sed 's/[[:space:]]\+/ /g')"
    value="$(printf '%s' "$value" | sed 's/^ //; s/ $//')"

    printf '%s\n' "$value"
}

emit_dependency() {
    local file="$1"
    local line_no="$2"
    local dep_type="$3"
    local target="$4"

    file="$(sanitize_dependency_field "$file")"
    dep_type="$(sanitize_dependency_field "$dep_type")"
    target="$(sanitize_dependency_field "$target")"

    [[ -n "$target" ]] || return 0

    printf 'DEPENDENCY\t%s\t%s\t%s\t%s\n' "$file" "$line_no" "$dep_type" "$target"
}

extract_dependencies_from_line() {
    local file="$1"
    local line_no="$2"
    local line="$3"

    if [[ "$line" =~ ^[[:space:]]*source[[:space:]]+\"([^\"]+)\" ]]; then
        emit_dependency "$file" "$line_no" "source" "${BASH_REMATCH[1]}"
    elif [[ "$line" =~ ^[[:space:]]*source[[:space:]]+\'([^\']+)\' ]]; then
        emit_dependency "$file" "$line_no" "source" "${BASH_REMATCH[1]}"
    elif [[ "$line" =~ ^[[:space:]]*\.[[:space:]]+\"([^\"]+)\" ]]; then
        emit_dependency "$file" "$line_no" "source" "${BASH_REMATCH[1]}"
    elif [[ "$line" =~ ^[[:space:]]*\.[[:space:]]+\'([^\']+)\' ]]; then
        emit_dependency "$file" "$line_no" "source" "${BASH_REMATCH[1]}"
    elif [[ "$line" =~ import[[:space:]].*[[:space:]]from[[:space:]]+[\"\']([^\"\']+)[\"\'] ]]; then
        emit_dependency "$file" "$line_no" "import" "${BASH_REMATCH[1]}"
    elif [[ "$line" =~ require[[:space:]]*\([[:space:]]*[\"\']([^\"\']+)[\"\'][[:space:]]*\) ]]; then
        emit_dependency "$file" "$line_no" "require" "${BASH_REMATCH[1]}"
    elif [[ "$line" =~ ^[[:space:]]*import[[:space:]]+([a-zA-Z0-9_./-]+) ]]; then
        emit_dependency "$file" "$line_no" "import" "${BASH_REMATCH[1]}"
    elif [[ "$line" =~ ^[[:space:]]*from[[:space:]]+([a-zA-Z0-9_./-]+)[[:space:]]+import[[:space:]]+ ]]; then
        emit_dependency "$file" "$line_no" "from_import" "${BASH_REMATCH[1]}"
    elif [[ "$line" =~ ^[[:space:]]*(require|require_once|include|include_once)[[:space:]]*[\(]?[[:space:]]*[\"\']([^\"\']+)[\"\'] ]]; then
        emit_dependency "$file" "$line_no" "${BASH_REMATCH[1]}" "${BASH_REMATCH[2]}"
    fi
}

generate_dependencies() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || {
        echo "[ERROR] Directory not found: $target_dir" >&2
        return 1
    }

    scan_files "$target_dir" | while read -r file; do
        local line_no=0

        while IFS= read -r line || [[ -n "$line" ]]; do
            line_no=$((line_no + 1))
            extract_dependencies_from_line "$file" "$line_no" "$line"
        done < "$file"
    done
}
