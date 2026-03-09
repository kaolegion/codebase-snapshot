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

LINE_COUNT="$(printf '%s\n' "$MODULES_OUTPUT" | wc -l | tr -d ' ')"
[[ "$LINE_COUNT" == "6" ]] || {
    echo "[FAIL] expected 6 module lines, got $LINE_COUNT"
    exit 1
}
echo "[PASS] modules output line count is deterministic"

echo "[SUCCESS] structure tests completed"
