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
touch "$TMP_DIR/bin/snapshot"
touch "$TMP_DIR/core/engine.sh"
touch "$TMP_DIR/core/semantics.sh"
touch "$TMP_DIR/core/entrypoints.sh"
touch "$TMP_DIR/core/purpose.sh"
touch "$TMP_DIR/tests/test_app.sh"
touch "$TMP_DIR/tests/test_semantics.sh"
touch "$TMP_DIR/tests/run_all.sh"
touch "$TMP_DIR/doc/guide.md"
touch "$TMP_DIR/doc/CLI.md"
touch "$TMP_DIR/examples/sample-config.env"
touch "$TMP_DIR/tools/fix.sh"
touch "$TMP_DIR/config.yml"
touch "$TMP_DIR/LICENSE"
touch "$TMP_DIR/README.md"
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

echo "[TEST] semantics grouping"

[[ "$(detect_component_group "$TMP_DIR/bin/snapshot")" == "snapshot_pipeline" ]] || {
    echo "[FAIL] snapshot pipeline group detection failed"
    exit 1
}
echo "[PASS] snapshot pipeline group detected"

[[ "$(detect_component_group "$TMP_DIR/core/semantics.sh")" == "repository_semantics" ]] || {
    echo "[FAIL] repository semantics group detection failed"
    exit 1
}
echo "[PASS] repository semantics group detected"

[[ "$(detect_component_group "$TMP_DIR/core/entrypoints.sh")" == "execution_discovery" ]] || {
    echo "[FAIL] execution discovery group detection failed"
    exit 1
}
echo "[PASS] execution discovery group detected"

[[ "$(detect_component_group "$TMP_DIR/core/purpose.sh")" == "purpose_inference" ]] || {
    echo "[FAIL] purpose inference group detection failed"
    exit 1
}
echo "[PASS] purpose inference group detected"

[[ "$(detect_component_group "$TMP_DIR/tests/run_all.sh")" == "test_contracts" ]] || {
    echo "[FAIL] test contracts group detection failed"
    exit 1
}
echo "[PASS] test contracts group detected"

[[ "$(detect_component_group "$TMP_DIR/doc/CLI.md")" == "snapshot_pipeline" ]] || {
    echo "[FAIL] doc snapshot pipeline group detection failed"
    exit 1
}
echo "[PASS] doc snapshot pipeline group detected"

[[ "$(detect_component_group "$TMP_DIR/README.md")" == "project_docs" ]] || {
    echo "[FAIL] project docs group detection failed"
    exit 1
}
echo "[PASS] project docs group detected"

[[ "$(detect_component_group "$TMP_DIR/random.txt")" == "unknown" ]] || {
    echo "[FAIL] unknown group detection failed"
    exit 1
}
echo "[PASS] unknown group detected"

echo "[TEST] semantics roles"

[[ "$(detect_component_role "$TMP_DIR/bin/app")" == "entrypoint" ]] || {
    echo "[FAIL] entrypoint role detection failed"
    exit 1
}
echo "[PASS] entrypoint role detected"

[[ "$(detect_component_role "$TMP_DIR/core/engine.sh")" == "engine" ]] || {
    echo "[FAIL] engine role detection failed"
    exit 1
}
echo "[PASS] engine role detected"

[[ "$(detect_component_role "$TMP_DIR/tests/test_app.sh")" == "test" ]] || {
    echo "[FAIL] test role detection failed"
    exit 1
}
echo "[PASS] test role detected"

[[ "$(detect_component_role "$TMP_DIR/doc/guide.md")" == "guide" ]] || {
    echo "[FAIL] guide role detection failed"
    exit 1
}
echo "[PASS] guide role detected"

[[ "$(detect_component_role "$TMP_DIR/examples/sample-config.env")" == "example" ]] || {
    echo "[FAIL] example role detection failed"
    exit 1
}
echo "[PASS] example role detected"

[[ "$(detect_component_role "$TMP_DIR/tools/fix.sh")" == "tool" ]] || {
    echo "[FAIL] tool role detection failed"
    exit 1
}
echo "[PASS] tool role detected"

[[ "$(detect_component_role "$TMP_DIR/LICENSE")" == "root_artifact" ]] || {
    echo "[FAIL] root artifact role detection failed"
    exit 1
}
echo "[PASS] root artifact role detected"

[[ "$(detect_component_role "$TMP_DIR/README.md")" == "spec" ]] || {
    echo "[FAIL] spec role detection failed"
    exit 1
}
echo "[PASS] spec role detected"

[[ "$(detect_component_role "$TMP_DIR/random.txt")" == "unknown" ]] || {
    echo "[FAIL] unknown role detection failed"
    exit 1
}
echo "[PASS] unknown role detected"

echo "[TEST] semantics generation"

SEMANTICS_OUTPUT="$(generate_semantics "$TMP_DIR")"

grep -Fq $'SEMANTIC\t'"$TMP_DIR"$'/bin/app\tcli\tunknown\tentrypoint\tpath:bin' <<< "$SEMANTICS_OUTPUT" || {
    echo "[FAIL] semantics output missing cli entry"
    exit 1
}
echo "[PASS] semantics output contains cli entry"

grep -Fq $'SEMANTIC\t'"$TMP_DIR"$'/config.yml\tconfig\tunknown\tunknown\textension:config' <<< "$SEMANTICS_OUTPUT" || {
    echo "[FAIL] semantics output missing config entry"
    exit 1
}
echo "[PASS] semantics output contains config entry"

grep -Fq $'SEMANTIC\t'"$TMP_DIR"$'/random.txt\tunknown\tunknown\tunknown\tfallback:unknown' <<< "$SEMANTICS_OUTPUT" || {
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

grep -Fq '#### group: unknown' <<< "$SUMMARY_OUTPUT" || {
    echo "[FAIL] components summary missing group subsection"
    exit 1
}
echo "[PASS] components summary contains group subsection"


grep -Fq -- "- $TMP_DIR/bin/app" <<< "$SUMMARY_OUTPUT" || {
    echo "[FAIL] components summary missing cli file"
    exit 1
}
echo "[PASS] components summary contains cli file"

echo "[SUCCESS] semantics tests completed"
