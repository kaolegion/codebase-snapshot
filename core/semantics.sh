#!/usr/bin/env bash
set -euo pipefail

detect_component() {
    local file="$1"

    case "$file" in
        */bin/*|bin/*)
            printf 'cli\n'
            ;;
        */core/*|core/*)
            printf 'core\n'
            ;;
        */tests/*|tests/*)
            printf 'tests\n'
            ;;
        */doc/*|doc/*)
            printf 'docs\n'
            ;;
        *.md)
            printf 'docs\n'
            ;;
        */examples/*|examples/*)
            printf 'examples\n'
            ;;
        */tools/*|tools/*)
            printf 'tools\n'
            ;;
        *.env|*/.env|*.json|*.yml|*.yaml|Makefile|*/Makefile)
            printf 'config\n'
            ;;
        LICENSE|*/LICENSE|VERSION|*/VERSION|.gitignore|*/.gitignore|CHANGELOG.md|*/CHANGELOG.md|CODEBASE_ROOT.md|*/CODEBASE_ROOT.md)
            printf 'root\n'
            ;;
        *)
            printf 'unknown\n'
            ;;
    esac
}

detect_component_rule() {
    local file="$1"

    case "$file" in
        */bin/*|bin/*)
            printf 'path:bin\n'
            ;;
        */core/*|core/*)
            printf 'path:core\n'
            ;;
        */tests/*|tests/*)
            printf 'path:tests\n'
            ;;
        */doc/*|doc/*)
            printf 'path:doc\n'
            ;;
        *.md)
            printf 'extension:md\n'
            ;;
        */examples/*|examples/*)
            printf 'path:examples\n'
            ;;
        */tools/*|tools/*)
            printf 'path:tools\n'
            ;;
        *.env|*/.env|*.json|*.yml|*.yaml)
            printf 'extension:config\n'
            ;;
        Makefile|*/Makefile)
            printf 'name:makefile\n'
            ;;
        LICENSE|*/LICENSE|VERSION|*/VERSION|.gitignore|*/.gitignore|CHANGELOG.md|*/CHANGELOG.md|CODEBASE_ROOT.md|*/CODEBASE_ROOT.md)
            printf 'root:convention\n'
            ;;
        *)
            printf 'fallback:unknown\n'
            ;;
    esac
}

list_semantic_files() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || {
        echo "[ERROR] Directory not found: $target_dir" >&2
        return 1
    }

    if declare -F scan_files >/dev/null 2>&1; then
        scan_files "$target_dir"
    else
        find "$target_dir" -type f | sort
    fi
}

generate_semantics() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || {
        echo "[ERROR] Directory not found: $target_dir" >&2
        return 1
    }

    while IFS= read -r file; do
        local component
        local rule

        component="$(detect_component "$file")"
        rule="$(detect_component_rule "$file")"

        printf 'SEMANTIC\t%s\t%s\t%s\n' "$file" "$component" "$rule"
    done < <(list_semantic_files "$target_dir")
}

render_components_summary() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || {
        echo "[ERROR] Directory not found: $target_dir" >&2
        return 1
    }

    local components
    components="$(
        generate_semantics "$target_dir" \
        | cut -f3 \
        | sort -u
    )"

    printf '# Components Summary\n\n'
    printf 'This document summarizes the semantic repository components detected by **codebase-snapshot**.\n\n'
    printf '## Detected components\n\n'

    while IFS= read -r component; do
        [[ -n "$component" ]] || continue

        printf '### %s\n\n' "$component"
        printf 'Detected files:\n\n'

        generate_semantics "$target_dir" \
            | awk -F'\t' -v component="$component" '$3 == component { print "- " $2 }'

        printf '\n'
    done <<< "$components"
}
