#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT_DIR/core/scanner.sh"
source "$ROOT_DIR/core/entrypoints.sh"

list_repository_files() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || {
        echo "[ERROR] Directory not found: $target_dir" >&2
        return 1
    }

    scan_files "$target_dir"
}

count_matching_files() {
    local target_dir="$1"
    local pattern="$2"
    local count=0
    local file
    local rel

    while IFS= read -r file; do
        [[ -n "$file" ]] || continue
        rel="${file#$target_dir/}"

        case "$rel" in
            $pattern)
                count=$((count + 1))
                ;;
        esac
    done < <(list_repository_files "$target_dir")

    printf '%s\n' "$count"
}

count_total_files() {
    local target_dir="$1"
    local count=0
    local file

    while IFS= read -r file; do
        [[ -n "$file" ]] || continue
        count=$((count + 1))
    done < <(list_repository_files "$target_dir")

    printf '%s\n' "$count"
}

detect_repository_languages() {
    local target_dir="$1"
    local file
    local rel
    local languages=""

    while IFS= read -r file; do
        [[ -n "$file" ]] || continue
        rel="${file#$target_dir/}"

        case "$rel" in
            *.sh) languages="${languages}Shell"$'\n' ;;
            *.py) languages="${languages}Python"$'\n' ;;
            *.js) languages="${languages}JavaScript"$'\n' ;;
            *.ts) languages="${languages}TypeScript"$'\n' ;;
            *.go) languages="${languages}Go"$'\n' ;;
            *.rs) languages="${languages}Rust"$'\n' ;;
            *.java) languages="${languages}Java"$'\n' ;;
            *.c) languages="${languages}C"$'\n' ;;
            *.h) languages="${languages}C Header"$'\n' ;;
            *.cpp) languages="${languages}C++"$'\n' ;;
            *.hpp) languages="${languages}C++ Header"$'\n' ;;
            *.rb) languages="${languages}Ruby"$'\n' ;;
            *.php) languages="${languages}PHP"$'\n' ;;
            *.md) languages="${languages}Markdown"$'\n' ;;
            *.json) languages="${languages}JSON"$'\n' ;;
            *.yml|*.yaml) languages="${languages}YAML"$'\n' ;;
            *.toml) languages="${languages}TOML"$'\n' ;;
            *.ini) languages="${languages}INI"$'\n' ;;
            Makefile|*/Makefile) languages="${languages}Make"$'\n' ;;
        esac
    done < <(list_repository_files "$target_dir")

    if [[ -z "$languages" ]]; then
        printf 'Unknown\n'
        return 0
    fi

    printf '%s' "$languages" | sed '/^$/d' | sort -u | paste -sd ', ' -
    printf '\n'
}

count_entrypoints_by_kind() {
    local target_dir="$1"
    local expected_kind="$2"
    local count=0
    local file
    local kind

    while IFS= read -r file; do
        [[ -n "$file" ]] || continue

        if ! kind="$(detect_entrypoint_kind "$target_dir" "$file" 2>/dev/null)"; then
            continue
        fi

        if [[ "$kind" == "$expected_kind" ]]; then
            count=$((count + 1))
        fi
    done < <(list_repository_files "$target_dir")

    printf '%s\n' "$count"
}

detect_repository_project_type() {
    local target_dir="$1"

    local has_bin=0
    local has_cmd=0
    local has_core=0
    local has_src=0
    local has_lib=0
    local has_tests=0
    local has_test=0

    [[ -d "$target_dir/bin" ]] && has_bin=1
    [[ -d "$target_dir/cmd" ]] && has_cmd=1
    [[ -d "$target_dir/core" ]] && has_core=1
    [[ -d "$target_dir/src" ]] && has_src=1
    [[ -d "$target_dir/lib" ]] && has_lib=1
    [[ -d "$target_dir/tests" ]] && has_tests=1
    [[ -d "$target_dir/test" ]] && has_test=1

    local cli_entrypoints
    local app_entrypoints
    local service_entrypoints
    local total_files
    local docs_files
    local tests_files
    local config_files

    cli_entrypoints="$(count_entrypoints_by_kind "$target_dir" "cli")"
    app_entrypoints="$(count_entrypoints_by_kind "$target_dir" "application")"
    service_entrypoints="$(count_entrypoints_by_kind "$target_dir" "service")"
    total_files="$(count_total_files "$target_dir")"
    docs_files="$(
        {
            count_matching_files "$target_dir" '*.md'
            count_matching_files "$target_dir" 'doc/*'
            count_matching_files "$target_dir" 'docs/*'
        } | awk '{sum += $1} END {print sum + 0}'
    )"
    tests_files="$(
        {
            count_matching_files "$target_dir" 'tests/*'
            count_matching_files "$target_dir" 'test/*'
        } | awk '{sum += $1} END {print sum + 0}'
    )"
    config_files="$(
        {
            count_matching_files "$target_dir" '*.json'
            count_matching_files "$target_dir" '*.yml'
            count_matching_files "$target_dir" '*.yaml'
            count_matching_files "$target_dir" '*.toml'
            count_matching_files "$target_dir" '*.ini'
            count_matching_files "$target_dir" '.env'
            count_matching_files "$target_dir" '*.env'
        } | awk '{sum += $1} END {print sum + 0}'
    )"

    if (( (has_bin == 1 || has_cmd == 1) && (has_core == 1 || has_src == 1 || has_lib == 1) )); then
        if (( cli_entrypoints > 0 )); then
            printf 'CLI Tool\n'
            return 0
        fi
    fi

    if (( (has_src == 1 || has_lib == 1) && app_entrypoints > 0 )); then
        printf 'Application\n'
        return 0
    fi

    if (( service_entrypoints > 0 )); then
        printf 'Service\n'
        return 0
    fi

    if (( total_files > 0 && docs_files >= total_files )); then
        printf 'Documentation Repository\n'
        return 0
    fi

    if (( tests_files > 0 && tests_files >= config_files && (has_tests == 1 || has_test == 1) )); then
        printf 'Test Repository\n'
        return 0
    fi

    if (( config_files > 0 && config_files >= tests_files && has_core == 0 && has_src == 0 && has_lib == 0 )); then
        printf 'Configuration Repository\n'
        return 0
    fi

    if (( has_core == 1 || has_src == 1 || has_lib == 1 )); then
        printf 'Software System\n'
        return 0
    fi

    printf 'Unknown\n'
}

detect_repository_architecture_style() {
    local target_dir="$1"

    if [[ -d "$target_dir/bin" && -d "$target_dir/core" ]]; then
        printf 'Modular Shell System\n'
        return 0
    fi

    if [[ -d "$target_dir/cmd" && -d "$target_dir/internal" ]]; then
        printf 'Layered Command System\n'
        return 0
    fi

    if [[ -d "$target_dir/src" && -d "$target_dir/tests" ]]; then
        printf 'Layered Source System\n'
        return 0
    fi

    if [[ -d "$target_dir/lib" && -d "$target_dir/tests" ]]; then
        printf 'Library-Centric System\n'
        return 0
    fi

    if [[ -d "$target_dir/doc" || -d "$target_dir/docs" ]]; then
        printf 'Documentation-Oriented Layout\n'
        return 0
    fi

    printf 'Flat Repository Layout\n'
}

render_core_components_list() {
    local target_dir="$1"
    local components=""

    [[ -d "$target_dir/bin" ]] && components="${components}cli"$'\n'
    [[ -d "$target_dir/core" ]] && components="${components}core"$'\n'
    [[ -d "$target_dir/src" ]] && components="${components}src"$'\n'
    [[ -d "$target_dir/lib" ]] && components="${components}lib"$'\n'
    [[ -d "$target_dir/tests" ]] && components="${components}tests"$'\n'
    [[ -d "$target_dir/test" ]] && components="${components}test"$'\n'
    [[ -d "$target_dir/doc" ]] && components="${components}doc"$'\n'
    [[ -d "$target_dir/docs" ]] && components="${components}docs"$'\n'
    [[ -d "$target_dir/examples" ]] && components="${components}examples"$'\n'
    [[ -d "$target_dir/tools" ]] && components="${components}tools"$'\n'

    if [[ -z "$components" ]]; then
        printf -- '- unknown\n'
        return 0
    fi

    printf '%s' "$components" | sed '/^$/d' | sort -u | while IFS= read -r component; do
        printf -- '- %s\n' "$component"
    done
}

render_entrypoints_list() {
    local target_dir="$1"
    local found=0
    local file
    local kind
    local rel

    while IFS= read -r file; do
        [[ -n "$file" ]] || continue

        if ! kind="$(detect_entrypoint_kind "$target_dir" "$file" 2>/dev/null)"; then
            continue
        fi

        rel="${file#$target_dir/}"
        printf -- '- %s (%s)\n' "$rel" "$kind"
        found=1
    done < <(list_repository_files "$target_dir")

    if (( found == 0 )); then
        printf -- '- none detected\n'
    fi
}

detect_dependency_model() {
    local target_dir="$1"

    if [[ -d "$target_dir/core" ]]; then
        printf 'Explicit local shell modules\n'
        return 0
    fi

    if [[ -d "$target_dir/src" || -d "$target_dir/lib" ]]; then
        printf 'Source-based internal modules\n'
        return 0
    fi

    printf 'Undetermined\n'
}

detect_documentation_presence() {
    local target_dir="$1"

    if [[ -d "$target_dir/doc" || -d "$target_dir/docs" ]]; then
        printf 'present\n'
        return 0
    fi

    if compgen -G "$target_dir/*.md" >/dev/null; then
        printf 'present\n'
        return 0
    fi

    printf 'absent\n'
}

detect_test_coverage_presence() {
    local target_dir="$1"

    if [[ -d "$target_dir/tests" || -d "$target_dir/test" ]]; then
        printf 'present\n'
        return 0
    fi

    printf 'absent\n'
}

describe_repository_size() {
    local target_dir="$1"
    local total_files

    total_files="$(count_total_files "$target_dir")"

    if (( total_files <= 25 )); then
        printf 'small (%s files)\n' "$total_files"
        return 0
    fi

    if (( total_files <= 150 )); then
        printf 'medium (%s files)\n' "$total_files"
        return 0
    fi

    printf 'large (%s files)\n' "$total_files"
}

render_repository_dna() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || {
        echo "[ERROR] Directory not found: $target_dir" >&2
        return 1
    }

    cat <<EOF_DNA
# Repository DNA

This file was generated automatically by **codebase-snapshot**.

It provides a deterministic identity summary of the repository.

## Identity Profile

Project Type: $(detect_repository_project_type "$target_dir")
Architecture Style: $(detect_repository_architecture_style "$target_dir")
Languages: $(detect_repository_languages "$target_dir")
Dependency Model: $(detect_dependency_model "$target_dir")
Documentation Presence: $(detect_documentation_presence "$target_dir")
Test Coverage: $(detect_test_coverage_presence "$target_dir")
Repository Size: $(describe_repository_size "$target_dir")

## Core Components

$(render_core_components_list "$target_dir")

## Entrypoints

$(render_entrypoints_list "$target_dir")

## Interpretation Notes

- The DNA profile is deterministic.
- Project type uses structural signals first and entrypoint signals as support.
- The output is intended as a compact repository identity layer.
- This artifact complements PURPOSE.md and REPOSITORY_EXPLAIN.md.
EOF_DNA
}
