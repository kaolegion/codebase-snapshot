#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT_DIR/core/structure.sh"

format_module_title() {
    local module="$1"

    case "$module" in
        cli) printf 'CLI\n' ;;
        modeling) printf 'Modeling\n' ;;
        rendering) printf 'Rendering\n' ;;
        infrastructure) printf 'Infrastructure\n' ;;
        tests) printf 'Tests\n' ;;
        docs) printf 'Documentation\n' ;;
        *) printf '%s\n' "$module" ;;
    esac
}

render_architecture() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || {
        echo "[ERROR] Directory not found: $target_dir" >&2
        return 1
    }

    local modules_output subsystems_output
    modules_output="$(generate_modules "$target_dir")"
    subsystems_output="$(generate_subsystems "$target_dir")"

    cat <<'HEADER'
# Architecture Overview

This file was generated automatically by **codebase-snapshot**.

The architecture view is derived deterministically from `MODULES.tsv`
and `SUBSYSTEMS.tsv`.

HEADER

    while IFS=$'\t' read -r record_type module path scope role description rule; do
        [[ "$record_type" == "MODULE" ]] || continue
        [[ -n "$module" ]] || continue

        printf '## %s\n\n' "$(format_module_title "$module")"
        printf -- '- Path: `%s`\n' "$path"
        printf -- '- Scope: `%s`\n' "$scope"
        printf -- '- Role: %s\n' "$role"
        printf -- '- Description: %s\n' "$description"
        printf -- '- Rule: `%s`\n' "$rule"
        printf '\n'

        printf 'Subsystems:\n\n'

        while IFS=$'\t' read -r sub_record_type sub_module subsystem sub_path sub_scope sub_role sub_description sub_rule; do
            [[ "$sub_record_type" == "SUBSYSTEM" ]] || continue
            [[ "$sub_module" == "$module" ]] || continue

            printf -- '- `%s`\n' "$subsystem"
            printf '  - Path: `%s`\n' "$sub_path"
            printf '  - Scope: `%s`\n' "$sub_scope"
            printf '  - Role: %s\n' "$sub_role"
            printf '  - Description: %s\n' "$sub_description"
            printf '  - Rule: `%s`\n' "$sub_rule"
        done <<< "$subsystems_output"

        printf '\n'
    done <<< "$modules_output"
}
