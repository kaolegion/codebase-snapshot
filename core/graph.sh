#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT_DIR/core/scanner.sh"
source "$ROOT_DIR/core/dependencies.sh"

to_relative_path() {
    local target_dir="$1"
    local path="$2"

    case "$path" in
        "$target_dir")
            printf '.\n'
            ;;
        "$target_dir"/*)
            printf '%s\n' "${path#"$target_dir"/}"
            ;;
        *)
            printf '%s\n' "$path"
            ;;
    esac
}

top_level_container() {
    local relative_path="$1"

    case "$relative_path" in
        */*)
            printf '%s\n' "${relative_path%%/*}"
            ;;
        *)
            printf '.\n'
            ;;
    esac
}

file_role() {
    local relative_path="$1"

    case "$relative_path" in
        bin/snapshot)
            printf 'cli_entrypoint\n'
            ;;
        bin/*)
            printf 'cli_script\n'
            ;;
        core/*)
            printf 'core_module\n'
            ;;
        tests/*)
            printf 'test\n'
            ;;
        doc/*|*.md)
            printf 'documentation\n'
            ;;
        examples/*)
            printf 'example\n'
            ;;
        tools/*)
            printf 'tool\n'
            ;;
        *.json)
            printf 'data\n'
            ;;
        *.yml|*.yaml|*.env)
            printf 'config\n'
            ;;
        *)
            printf 'file\n'
            ;;
    esac
}

emit_graph_edge() {
    local source="$1"
    local relation="$2"
    local target="$3"

    [[ -n "$source" ]] || return 0
    [[ -n "$relation" ]] || return 0
    [[ -n "$target" ]] || return 0

    printf 'GRAPH\t%s\t%s\t%s\n' "$source" "$relation" "$target"
}

generate_graph_contains_and_roles() {
    local target_dir="$1"

    scan_files "$target_dir" | while read -r file; do
        local rel container role
        rel="$(to_relative_path "$target_dir" "$file")"
        container="$(top_level_container "$rel")"
        role="$(file_role "$rel")"

        emit_graph_edge "$container" "contains" "$rel"
        emit_graph_edge "$rel" "role" "$role"
    done
}

normalize_dependency_target() {
    local target_dir="$1"
    local current_file_rel="$2"
    local dep_target="$3"

    if [[ "$dep_target" == '$ROOT_DIR/'* ]]; then
        printf '%s\n' "${dep_target#'$ROOT_DIR/'}"
        return 0
    fi

    if [[ "$dep_target" == "$target_dir/"* ]]; then
        printf '%s\n' "${dep_target#"$target_dir"/}"
        return 0
    fi

    if [[ "$dep_target" == /* ]]; then
        printf '%s\n' "$dep_target"
        return 0
    fi

    case "$dep_target" in
        core/*|bin/*|tests/*|doc/*|examples/*|tools/*)
            printf '%s\n' "$dep_target"
            return 0
            ;;
    esac

    local current_dir=""
    if [[ "$current_file_rel" == */* ]]; then
        current_dir="${current_file_rel%/*}"
    fi

    if [[ -n "$current_dir" && "$dep_target" == ./* ]]; then
        printf '%s/%s\n' "$current_dir" "${dep_target#./}"
        return 0
    fi

    printf '%s\n' "$dep_target"
}

generate_graph_dependencies() {
    local target_dir="$1"

    generate_dependencies "$target_dir" | while IFS=$'\t' read -r kind file line_no dep_type dep_target; do
        [[ "$kind" == "DEPENDENCY" ]] || continue

        local rel_file rel_target
        rel_file="$(to_relative_path "$target_dir" "$file")"
        rel_target="$(normalize_dependency_target "$target_dir" "$rel_file" "$dep_target")"

        emit_graph_edge "$rel_file" "depends_on" "$rel_target"
    done
}

generate_graph_artifacts() {
    emit_graph_edge "bin/snapshot" "generates" "PROJECT_TREE.txt"
    emit_graph_edge "bin/snapshot" "generates" "INDEX.tsv"
    emit_graph_edge "bin/snapshot" "generates" "DEPENDENCIES.tsv"
    emit_graph_edge "bin/snapshot" "generates" "GRAPH.tsv"
    emit_graph_edge "bin/snapshot" "generates" "ARCHITECTURE.md"
    emit_graph_edge "bin/snapshot" "generates" "DOCUMENTATION.md"
    emit_graph_edge "bin/snapshot" "generates" "LANGUAGES.md"
    emit_graph_edge "bin/snapshot" "generates" "MANIFEST.md"
    emit_graph_edge "bin/snapshot" "generates" "AI_INGESTION_GUIDE.md"
    emit_graph_edge "bin/snapshot" "generates" "LOG.txt"
    emit_graph_edge "bin/snapshot" "generates" "SNAPSHOT_META.json"
    emit_graph_edge "bin/snapshot" "generates" "CODEBASE/01_cli.md"
    emit_graph_edge "bin/snapshot" "generates" "CODEBASE/02_core.md"
    emit_graph_edge "bin/snapshot" "generates" "CODEBASE/03_tests.md"
    emit_graph_edge "bin/snapshot" "generates" "CODEBASE/04_docs.md"
}

generate_graph() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || {
        echo "[ERROR] Directory not found: $target_dir" >&2
        return 1
    }

    {
        generate_graph_contains_and_roles "$target_dir"
        generate_graph_dependencies "$target_dir"
        generate_graph_artifacts
    } | sort -u
}
