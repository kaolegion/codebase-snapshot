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

list_repository_subsystems() {
    printf 'cli\tsnapshot-command\tbin/snapshot\tfile\tcommand orchestration\torchestrates snapshot generation\tpath:bin/snapshot\n'
    printf 'modeling\trepository-indexing\tcore/indexer.sh\tfile\trepository indexing\tbuilds deterministic repository file index\tpath:core/indexer.sh\n'
    printf 'modeling\tdependency-analysis\tcore/dependencies.sh\tfile\tdependency extraction\textracts deterministic dependency signals\tpath:core/dependencies.sh\n'
    printf 'modeling\tgraph-modeling\tcore/graph.sh\tfile\tstructural graph generation\tbuilds deterministic repository graph\tpath:core/graph.sh\n'
    printf 'modeling\tsemantic-mapping\tcore/semantics.sh\tfile\tsemantic repository mapping\tmaps files to components and groups\tpath:core/semantics.sh\n'
    printf 'modeling\tentrypoint-detection\tcore/entrypoints.sh\tfile\texecution entrypoint detection\tidentifies repository execution entrypoints\tpath:core/entrypoints.sh\n'
    printf 'modeling\tpurpose-inference\tcore/purpose.sh\tfile\trepository purpose inference\tinfers deterministic repository purpose\tpath:core/purpose.sh\n'
    printf 'modeling\tmodule-modeling\tcore/structure.sh\tfile\trepository structure modeling\tdefines deterministic repository modules and subsystems\tpath:core/structure.sh\n'
    printf 'rendering\tartifact-rendering\tcore/renderer.sh\tfile\tsnapshot artifact rendering\tproduces human-readable and export artifacts\tpath:core/renderer.sh\n'
    printf 'rendering\tdocumentation-rendering\tcore/documentation.sh\tfile\tdocumentation reporting\tbuilds repository documentation summary\tpath:core/documentation.sh\n'
    printf 'rendering\tlanguage-reporting\tcore/languages.sh\tfile\tlanguage reporting\tsummarizes repository languages and file types\tpath:core/languages.sh\n'
    printf 'rendering\tarchitecture-reporting\tcore/architecture.sh\tfile\tarchitecture reporting\tbuilds repository architecture summary\tpath:core/architecture.sh\n'
    printf 'infrastructure\trepository-scanning\tcore/scanner.sh\tfile\trepository scanning\tperforms deterministic repository discovery\tpath:core/scanner.sh\n'
    printf 'infrastructure\truntime-configuration\tcore/config.sh\tfile\truntime configuration\tprovides snapshot configuration handling\tpath:core/config.sh\n'
    printf 'infrastructure\tlogging\tcore/logger.sh\tfile\tstructured logging\tprovides execution logging\tpath:core/logger.sh\n'
    printf 'infrastructure\tnaming-normalization\tcore/naming.sh\tfile\tnaming normalization\tnormalizes deterministic snapshot names\tpath:core/naming.sh\n'
    printf 'infrastructure\tshared-utilities\tcore/utils.sh\tfile\tshared utilities\tprovides reusable shell helpers\tpath:core/utils.sh\n'
    printf 'infrastructure\tfile-classification\tcore/classifier.sh\tfile\tfile classification\tclassifies repository files for downstream analysis\tpath:core/classifier.sh\n'
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

generate_subsystems() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || {
        echo "[ERROR] Directory not found: $target_dir" >&2
        return 1
    }

    while IFS=$'\t' read -r module subsystem path scope role description rule; do
        [[ -n "$module" ]] || continue
        printf 'SUBSYSTEM\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
            "$module" "$subsystem" "$path" "$scope" "$role" "$description" "$rule"
    done < <(list_repository_subsystems)
}
