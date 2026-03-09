#!/usr/bin/env bash
set -euo pipefail

list_repository_modules() {
    printf 'cli\tbin/\tdirectory\tcommand entrypoint\tcommand-line snapshot orchestration\tpath:bin\n'
    printf 'modeling\tcore/\tdirectory\tstructured repository modeling\tproduces machine-readable repository modeling artifacts\tstructural-core:modeling\n'
    printf 'rendering\tcore/\tdirectory\thuman-readable artifact rendering\tproduces human-readable repository artifacts\tstructural-core:rendering\n'
    printf 'infrastructure\tcore/\tdirectory\tshared runtime support\tprovides shared config, logging, scanning, naming, and utility services\tstructural-core:infrastructure\n'
    printf 'tests\ttests/\tdirectory\trepository validation\tprovides deterministic repository validation\tpath:tests\n'
    printf 'docs\tdoc/\tdirectory\tproject documentation\tprovides human-readable project documentation\tpath:doc-and-root-docs\n'
}

generate_modules() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || {
        echo "[ERROR] Directory not found: $target_dir" >&2
        return 1
    }

    while IFS=$'\t' read -r module path scope role description rule; do
        [[ -n "$module" ]] || continue
        printf 'MODULE\t%s\t%s\t%s\t%s\t%s\t%s\n' \
            "$module" "$path" "$scope" "$role" "$description" "$rule"
    done < <(list_repository_modules)
}
