#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$ROOT_DIR/core/structure.sh"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

mkdir -p "$TMP_DIR"

echo "[TEST] structure generation"

MODULES_OUTPUT="$(generate_modules "$TMP_DIR")"

grep -Fq $'MODULE\tcli\tbin/\tdirectory\tcommand entrypoint\tcommand-line snapshot orchestration\tpath:bin' <<< "$MODULES_OUTPUT" || {
    echo "[FAIL] modules output missing cli entry"
    exit 1
}
echo "[PASS] modules output contains cli entry"

grep -Fq $'MODULE\tmodeling\tcore/\tdirectory\tstructured repository modeling\tproduces machine-readable repository modeling artifacts\tstructural-core:modeling' <<< "$MODULES_OUTPUT" || {
    echo "[FAIL] modules output missing modeling entry"
    exit 1
}
echo "[PASS] modules output contains modeling entry"

grep -Fq $'MODULE\trendering\tcore/\tdirectory\thuman-readable artifact rendering\tproduces human-readable repository artifacts\tstructural-core:rendering' <<< "$MODULES_OUTPUT" || {
    echo "[FAIL] modules output missing rendering entry"
    exit 1
}
echo "[PASS] modules output contains rendering entry"

grep -Fq $'MODULE\tinfrastructure\tcore/\tdirectory\tshared runtime support\tprovides shared config, logging, scanning, naming, and utility services\tstructural-core:infrastructure' <<< "$MODULES_OUTPUT" || {
    echo "[FAIL] modules output missing infrastructure entry"
    exit 1
}
echo "[PASS] modules output contains infrastructure entry"

grep -Fq $'MODULE\ttests\ttests/\tdirectory\trepository validation\tprovides deterministic repository validation\tpath:tests' <<< "$MODULES_OUTPUT" || {
    echo "[FAIL] modules output missing tests entry"
    exit 1
}
echo "[PASS] modules output contains tests entry"

grep -Fq $'MODULE\tdocs\tdoc/\tdirectory\tproject documentation\tprovides human-readable project documentation\tpath:doc-and-root-docs' <<< "$MODULES_OUTPUT" || {
    echo "[FAIL] modules output missing docs entry"
    exit 1
}
echo "[PASS] modules output contains docs entry"

MODULE_LINE_COUNT="$(printf '%s\n' "$MODULES_OUTPUT" | wc -l | tr -d ' ')"
[[ "$MODULE_LINE_COUNT" == "6" ]] || {
    echo "[FAIL] expected 6 module lines, got $MODULE_LINE_COUNT"
    exit 1
}
echo "[PASS] modules output line count is deterministic"

SUBSYSTEMS_OUTPUT="$(generate_subsystems "$TMP_DIR")"

grep -Fq $'SUBSYSTEM\tcli\tsnapshot-command\tbin/snapshot\tfile\tcommand orchestration\torchestrates snapshot generation\tpath:bin/snapshot' <<< "$SUBSYSTEMS_OUTPUT" || {
    echo "[FAIL] subsystems output missing cli snapshot-command entry"
    exit 1
}
echo "[PASS] subsystems output contains cli snapshot-command entry"

grep -Fq $'SUBSYSTEM\tmodeling\trepository-indexing\tcore/indexer.sh\tfile\trepository indexing\tbuilds deterministic repository file index\tpath:core/indexer.sh' <<< "$SUBSYSTEMS_OUTPUT" || {
    echo "[FAIL] subsystems output missing repository-indexing entry"
    exit 1
}
echo "[PASS] subsystems output contains repository-indexing entry"

grep -Fq $'SUBSYSTEM\tmodeling\tdependency-analysis\tcore/dependencies.sh\tfile\tdependency extraction\textracts deterministic dependency signals\tpath:core/dependencies.sh' <<< "$SUBSYSTEMS_OUTPUT" || {
    echo "[FAIL] subsystems output missing dependency-analysis entry"
    exit 1
}
echo "[PASS] subsystems output contains dependency-analysis entry"

grep -Fq $'SUBSYSTEM\tmodeling\tgraph-modeling\tcore/graph.sh\tfile\tstructural graph generation\tbuilds deterministic repository graph\tpath:core/graph.sh' <<< "$SUBSYSTEMS_OUTPUT" || {
    echo "[FAIL] subsystems output missing graph-modeling entry"
    exit 1
}
echo "[PASS] subsystems output contains graph-modeling entry"

grep -Fq $'SUBSYSTEM\tmodeling\tsemantic-mapping\tcore/semantics.sh\tfile\tsemantic repository mapping\tmaps files to components and groups\tpath:core/semantics.sh' <<< "$SUBSYSTEMS_OUTPUT" || {
    echo "[FAIL] subsystems output missing semantic-mapping entry"
    exit 1
}
echo "[PASS] subsystems output contains semantic-mapping entry"

grep -Fq $'SUBSYSTEM\tmodeling\tentrypoint-detection\tcore/entrypoints.sh\tfile\texecution entrypoint detection\tidentifies repository execution entrypoints\tpath:core/entrypoints.sh' <<< "$SUBSYSTEMS_OUTPUT" || {
    echo "[FAIL] subsystems output missing entrypoint-detection entry"
    exit 1
}
echo "[PASS] subsystems output contains entrypoint-detection entry"

grep -Fq $'SUBSYSTEM\tmodeling\tpurpose-inference\tcore/purpose.sh\tfile\trepository purpose inference\tinfers deterministic repository purpose\tpath:core/purpose.sh' <<< "$SUBSYSTEMS_OUTPUT" || {
    echo "[FAIL] subsystems output missing purpose-inference entry"
    exit 1
}
echo "[PASS] subsystems output contains purpose-inference entry"

grep -Fq $'SUBSYSTEM\tmodeling\tmodule-modeling\tcore/structure.sh\tfile\trepository structure modeling\tdefines deterministic repository modules and subsystems\tpath:core/structure.sh' <<< "$SUBSYSTEMS_OUTPUT" || {
    echo "[FAIL] subsystems output missing module-modeling entry"
    exit 1
}
echo "[PASS] subsystems output contains module-modeling entry"

grep -Fq $'SUBSYSTEM\trendering\tartifact-rendering\tcore/renderer.sh\tfile\tsnapshot artifact rendering\tproduces human-readable and export artifacts\tpath:core/renderer.sh' <<< "$SUBSYSTEMS_OUTPUT" || {
    echo "[FAIL] subsystems output missing artifact-rendering entry"
    exit 1
}
echo "[PASS] subsystems output contains artifact-rendering entry"

grep -Fq $'SUBSYSTEM\trendering\tdocumentation-rendering\tcore/documentation.sh\tfile\tdocumentation reporting\tbuilds repository documentation summary\tpath:core/documentation.sh' <<< "$SUBSYSTEMS_OUTPUT" || {
    echo "[FAIL] subsystems output missing documentation-rendering entry"
    exit 1
}
echo "[PASS] subsystems output contains documentation-rendering entry"

grep -Fq $'SUBSYSTEM\trendering\tlanguage-reporting\tcore/languages.sh\tfile\tlanguage reporting\tsummarizes repository languages and file types\tpath:core/languages.sh' <<< "$SUBSYSTEMS_OUTPUT" || {
    echo "[FAIL] subsystems output missing language-reporting entry"
    exit 1
}
echo "[PASS] subsystems output contains language-reporting entry"

grep -Fq $'SUBSYSTEM\trendering\tarchitecture-reporting\tcore/architecture.sh\tfile\tarchitecture reporting\tbuilds repository architecture summary\tpath:core/architecture.sh' <<< "$SUBSYSTEMS_OUTPUT" || {
    echo "[FAIL] subsystems output missing architecture-reporting entry"
    exit 1
}
echo "[PASS] subsystems output contains architecture-reporting entry"

grep -Fq $'SUBSYSTEM\tinfrastructure\trepository-scanning\tcore/scanner.sh\tfile\trepository scanning\tperforms deterministic repository discovery\tpath:core/scanner.sh' <<< "$SUBSYSTEMS_OUTPUT" || {
    echo "[FAIL] subsystems output missing repository-scanning entry"
    exit 1
}
echo "[PASS] subsystems output contains repository-scanning entry"

grep -Fq $'SUBSYSTEM\tinfrastructure\truntime-configuration\tcore/config.sh\tfile\truntime configuration\tprovides snapshot configuration handling\tpath:core/config.sh' <<< "$SUBSYSTEMS_OUTPUT" || {
    echo "[FAIL] subsystems output missing runtime-configuration entry"
    exit 1
}
echo "[PASS] subsystems output contains runtime-configuration entry"

grep -Fq $'SUBSYSTEM\tinfrastructure\tlogging\tcore/logger.sh\tfile\tstructured logging\tprovides execution logging\tpath:core/logger.sh' <<< "$SUBSYSTEMS_OUTPUT" || {
    echo "[FAIL] subsystems output missing logging entry"
    exit 1
}
echo "[PASS] subsystems output contains logging entry"

grep -Fq $'SUBSYSTEM\tinfrastructure\tnaming-normalization\tcore/naming.sh\tfile\tnaming normalization\tnormalizes deterministic snapshot names\tpath:core/naming.sh' <<< "$SUBSYSTEMS_OUTPUT" || {
    echo "[FAIL] subsystems output missing naming-normalization entry"
    exit 1
}
echo "[PASS] subsystems output contains naming-normalization entry"

grep -Fq $'SUBSYSTEM\tinfrastructure\tshared-utilities\tcore/utils.sh\tfile\tshared utilities\tprovides reusable shell helpers\tpath:core/utils.sh' <<< "$SUBSYSTEMS_OUTPUT" || {
    echo "[FAIL] subsystems output missing shared-utilities entry"
    exit 1
}
echo "[PASS] subsystems output contains shared-utilities entry"

grep -Fq $'SUBSYSTEM\tinfrastructure\tfile-classification\tcore/classifier.sh\tfile\tfile classification\tclassifies repository files for downstream analysis\tpath:core/classifier.sh' <<< "$SUBSYSTEMS_OUTPUT" || {
    echo "[FAIL] subsystems output missing file-classification entry"
    exit 1
}
echo "[PASS] subsystems output contains file-classification entry"

SUBSYSTEM_LINE_COUNT="$(printf '%s\n' "$SUBSYSTEMS_OUTPUT" | wc -l | tr -d ' ')"
[[ "$SUBSYSTEM_LINE_COUNT" == "18" ]] || {
    echo "[FAIL] expected 18 subsystem lines, got $SUBSYSTEM_LINE_COUNT"
    exit 1
}
echo "[PASS] subsystems output line count is deterministic"

echo "[SUCCESS] structure tests completed"
