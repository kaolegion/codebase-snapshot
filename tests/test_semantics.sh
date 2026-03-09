#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$ROOT_DIR/core/semantics.sh"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

mkdir -p "$TMP_DIR/bin"
mkdir -p "$TMP_DIR/core"
mkdir -p "$TMP_DIR/tests"
mkdir -p "$TMP_DIR/doc"
mkdir -p "$TMP_DIR/examples"
mkdir -p "$TMP_DIR/tools"

touch "$TMP_DIR/bin/app"
touch "$TMP_DIR/core/engine.sh"
touch "$TMP_DIR/tests/test_app.sh"
touch "$TMP_DIR/doc/guide.md"
touch "$TMP_DIR/examples/sample-config.env"
touch "$TMP_DIR/tools/fix.sh"
touch "$TMP_DIR/config.yml"
touch "$TMP_DIR/LICENSE"
touch "$TMP_DIR/random.txt"

echo "[TEST] semantics classification"

[[ "$(detect_component "$TMP_DIR/bin/app")" == "cli" ]] || {
    echo "[FAIL] bin component detection failed"
    exit 1
}
echo "[PASS] cli component detected"

[[ "$(detect_component "$TMP_DIR/core/engine.sh")" == "core" ]] || {
    echo "[FAIL] core component detection failed"
    exit 1
}
echo "[PASS] core component detected"

[[ "$(detect_component "$TMP_DIR/tests/test_app.sh")" == "tests" ]] || {
    echo "[FAIL] tests component detection failed"
    exit 1
}
echo "[PASS] tests component detected"

[[ "$(detect_component "$TMP_DIR/doc/guide.md")" == "docs" ]] || {
    echo "[FAIL] docs component detection failed"
    exit 1
}
echo "[PASS] docs component detected"

[[ "$(detect_component "$TMP_DIR/examples/sample-config.env")" == "examples" ]] || {
    echo "[FAIL] examples component detection failed"
    exit 1
}
echo "[PASS] examples component detected"

[[ "$(detect_component "$TMP_DIR/tools/fix.sh")" == "tools" ]] || {
    echo "[FAIL] tools component detection failed"
    exit 1
}
echo "[PASS] tools component detected"

[[ "$(detect_component "$TMP_DIR/config.yml")" == "config" ]] || {
    echo "[FAIL] config component detection failed"
    exit 1
}
echo "[PASS] config component detected"

[[ "$(detect_component "$TMP_DIR/LICENSE")" == "root" ]] || {
    echo "[FAIL] root component detection failed"
    exit 1
}
echo "[PASS] root component detected"

[[ "$(detect_component "$TMP_DIR/random.txt")" == "unknown" ]] || {
    echo "[FAIL] unknown component detection failed"
    exit 1
}
echo "[PASS] unknown component detected"

echo "[TEST] semantics rules"

[[ "$(detect_component_rule "$TMP_DIR/bin/app")" == "path:bin" ]] || {
    echo "[FAIL] bin rule detection failed"
    exit 1
}
echo "[PASS] cli rule detected"

[[ "$(detect_component_rule "$TMP_DIR/doc/guide.md")" == "path:doc" ]] || {
    echo "[FAIL] doc rule detection failed"
    exit 1
}
echo "[PASS] docs rule detected"

[[ "$(detect_component_rule "$TMP_DIR/config.yml")" == "extension:config" ]] || {
    echo "[FAIL] config rule detection failed"
    exit 1
}
echo "[PASS] config rule detected"

[[ "$(detect_component_rule "$TMP_DIR/LICENSE")" == "root:convention" ]] || {
    echo "[FAIL] root rule detection failed"
    exit 1
}
echo "[PASS] root rule detected"

[[ "$(detect_component_rule "$TMP_DIR/random.txt")" == "fallback:unknown" ]] || {
    echo "[FAIL] unknown rule detection failed"
    exit 1
}
echo "[PASS] unknown rule detected"

echo "[TEST] semantics generation"

SEMANTICS_OUTPUT="$(generate_semantics "$TMP_DIR")"

grep -Fq $'SEMANTIC\t'"$TMP_DIR"$'/bin/app\tcli\tpath:bin' <<< "$SEMANTICS_OUTPUT" || {
    echo "[FAIL] semantics output missing cli entry"
    exit 1
}
echo "[PASS] semantics output contains cli entry"

grep -Fq $'SEMANTIC\t'"$TMP_DIR"$'/config.yml\tconfig\textension:config' <<< "$SEMANTICS_OUTPUT" || {
    echo "[FAIL] semantics output missing config entry"
    exit 1
}
echo "[PASS] semantics output contains config entry"

grep -Fq $'SEMANTIC\t'"$TMP_DIR"$'/random.txt\tunknown\tfallback:unknown' <<< "$SEMANTICS_OUTPUT" || {
    echo "[FAIL] semantics output missing unknown entry"
    exit 1
}
echo "[PASS] semantics output contains unknown entry"

echo "[TEST] components summary rendering"

SUMMARY_OUTPUT="$(render_components_summary "$TMP_DIR")"

grep -Fq '# Components Summary' <<< "$SUMMARY_OUTPUT" || {
    echo "[FAIL] components summary header missing"
    exit 1
}
echo "[PASS] components summary header present"

grep -Fq '### cli' <<< "$SUMMARY_OUTPUT" || {
    echo "[FAIL] components summary missing cli section"
    exit 1
}
echo "[PASS] components summary contains cli section"

grep -Fq -- "- $TMP_DIR/bin/app" <<< "$SUMMARY_OUTPUT" || {
    echo "[FAIL] components summary missing cli file"
    exit 1
}
echo "[PASS] components summary contains cli file"

echo "[SUCCESS] semantics tests completed"
