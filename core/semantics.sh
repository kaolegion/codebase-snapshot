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

detect_component_group() {
    local file="$1"

    case "$file" in
        */bin/snapshot|bin/snapshot)
            printf 'snapshot_pipeline\n'
            ;;
        */core/architecture.sh|core/architecture.sh|\
*/core/classifier.sh|core/classifier.sh|\
*/core/config.sh|core/config.sh|\
*/core/indexer.sh|core/indexer.sh|\
*/core/naming.sh|core/naming.sh|\
*/core/scanner.sh|core/scanner.sh|\
*/core/utils.sh|core/utils.sh)
            printf 'repository_structure\n'
            ;;
        */core/dependencies.sh|core/dependencies.sh|\
*/core/graph.sh|core/graph.sh)
            printf 'repository_intelligence\n'
            ;;
        */core/semantics.sh|core/semantics.sh)
            printf 'repository_semantics\n'
            ;;
        */core/entrypoints.sh|core/entrypoints.sh)
            printf 'execution_discovery\n'
            ;;
        */core/purpose.sh|core/purpose.sh)
            printf 'purpose_inference\n'
            ;;
        */core/documentation.sh|core/documentation.sh)
            printf 'documentation_indexing\n'
            ;;
        */core/languages.sh|core/languages.sh)
            printf 'language_analysis\n'
            ;;
        */tests/test_cli.sh|tests/test_cli.sh)
            printf 'snapshot_pipeline\n'
            ;;
        */tests/test_indexer.sh|tests/test_indexer.sh|\
*/tests/test_naming.sh|tests/test_naming.sh)
            printf 'repository_structure\n'
            ;;
        */tests/test_dependencies.sh|tests/test_dependencies.sh|\
*/tests/test_graph.sh|tests/test_graph.sh)
            printf 'repository_intelligence\n'
            ;;
        */tests/test_semantics.sh|tests/test_semantics.sh)
            printf 'repository_semantics\n'
            ;;
        */tests/test_entrypoints.sh|tests/test_entrypoints.sh)
            printf 'execution_discovery\n'
            ;;
        */tests/test_purpose.sh|tests/test_purpose.sh)
            printf 'purpose_inference\n'
            ;;
        */tests/run_all.sh|tests/run_all.sh)
            printf 'test_contracts\n'
            ;;
        */doc/ARCHITECTURE.md|doc/ARCHITECTURE.md)
            printf 'repository_structure\n'
            ;;
        */doc/CLI.md|doc/CLI.md|\
*/doc/GET_STARTED.md|doc/GET_STARTED.md|\
*/doc/SNAPSHOT_FORMAT.md|doc/SNAPSHOT_FORMAT.md)
            printf 'snapshot_pipeline\n'
            ;;
        */doc/ROADMAP.md|doc/ROADMAP.md|\
*/doc/TODO.md|doc/TODO.md|\
*/doc/VISION.md|doc/VISION.md|\
*/README.md|README.md|\
*/CHANGELOG.md|CHANGELOG.md)
            printf 'project_docs\n'
            ;;
        */examples/*|examples/*)
            printf 'examples_usage\n'
            ;;
        */tools/*|tools/*)
            printf 'tooling\n'
            ;;
        */LICENSE|LICENSE|*/VERSION|VERSION|*/CODEBASE_ROOT.md|CODEBASE_ROOT.md|*/.gitignore|.gitignore)
            printf 'project_root\n'
            ;;
        *)
            printf 'unknown\n'
            ;;
    esac
}

detect_component_role() {
    local file="$1"

    case "$file" in
        */bin/*|bin/*)
            printf 'entrypoint\n'
            ;;
        */core/*|core/*)
            printf 'engine\n'
            ;;
        */tests/*|tests/*)
            printf 'test\n'
            ;;
        */doc/*|doc/*)
            printf 'guide\n'
            ;;
        */examples/*|examples/*)
            printf 'example\n'
            ;;
        */tools/*|tools/*)
            printf 'tool\n'
            ;;
        */LICENSE|LICENSE|*/VERSION|VERSION|*/CODEBASE_ROOT.md|CODEBASE_ROOT.md|*/.gitignore|.gitignore)
            printf 'root_artifact\n'
            ;;
        *.md)
            printf 'spec\n'
            ;;
        *)
            printf 'unknown\n'
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
        local group
        local role
        local rule

        component="$(detect_component "$file")"
        group="$(detect_component_group "$file")"
        role="$(detect_component_role "$file")"
        rule="$(detect_component_rule "$file")"

        printf 'SEMANTIC\t%s\t%s\t%s\t%s\t%s\n' "$file" "$component" "$group" "$role" "$rule"
    done < <(list_semantic_files "$target_dir")
}

render_components_summary() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || {
        echo "[ERROR] Directory not found: $target_dir" >&2
        return 1
    }

    local semantics_output
    local components
    local groups

    semantics_output="$(generate_semantics "$target_dir")"
    components="$(
        printf '%s\n' "$semantics_output" \
        | cut -f3 \
        | sort -u
    )"

    printf '# Components Summary\n\n'
    printf 'This document summarizes the semantic repository components detected by **codebase-snapshot**.\n\n'
    printf '## Detected components\n\n'

    while IFS= read -r component; do
        [[ -n "$component" ]] || continue

        printf '### %s\n\n' "$component"

        groups="$(
            printf '%s\n' "$semantics_output" \
            | awk -F'\t' -v component="$component" '$3 == component { print $4 }' \
            | sort -u
        )"

        while IFS= read -r group; do
            [[ -n "$group" ]] || continue

            printf '#### group: %s\n\n' "$group"

            printf '%s\n' "$semantics_output" \
                | awk -F'\t' -v component="$component" -v group="$group" '$3 == component && $4 == group { print "- " $2 }'

            printf '\n'
        done <<< "$groups"
    done <<< "$components"
}
