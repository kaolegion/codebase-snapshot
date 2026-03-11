#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TMP_DIR="$(mktemp -d)"
WORKSPACE="$TMP_DIR/workspace"
REPORT_FILE="$TMP_DIR/REPOSITORY_LINT.md"

cleanup() {
    rm -rf "$TMP_DIR"
}
trap cleanup EXIT

mkdir -p "$WORKSPACE"

source "$ROOT_DIR/core/lint.sh"

cat > "$WORKSPACE/INDEX.tsv" <<'INDEX'
FILE	bin/snapshot	100	10
FILE	bin/admin.sh	50	5
FILE	core/used.sh	40	4
FILE	core/orphan.sh	40	4
FILE	tests/test_used.sh	20	2
INDEX

cat > "$WORKSPACE/DEPENDENCIES.tsv" <<'DEPENDENCIES'
DEPENDENCY	bin/snapshot	1	source	core/used.sh
DEPENDENCY	core/used.sh	1	source	core/missing.sh
DEPENDENCIES

cat > "$WORKSPACE/SEMANTICS.tsv" <<'SEMANTICS'
SEMANTIC	bin/snapshot	cli	snapshot_pipeline	entrypoint	path:bin
SEMANTIC	core/ghost.sh	core	engine	engine	path:core
SEMANTICS

cat > "$WORKSPACE/ENTRYPOINTS.tsv" <<'ENTRYPOINTS'
ENTRYPOINT	bin/snapshot	cli	path:bin
ENTRYPOINT	bin/admin.sh	cli	path:bin
ENTRYPOINT	bin/missing.sh	cli	path:bin
ENTRYPOINTS

cat > "$WORKSPACE/MODULES.tsv" <<'MODULES'
MODULE	CLI	bin	repository	entrypoint	command layer	path:bin
MODULE	Core	core	repository	engine	core engines	path:core
MODULE	Docs	doc	repository	documentation	docs layer	path:doc
MODULES

cat > "$WORKSPACE/SUBSYSTEMS.tsv" <<'SUBSYSTEMS'
SUBSYSTEM	CLI	snapshot-command	bin	repository	entrypoint	command dispatch	path:bin
SUBSYSTEM	Core	engine	core/engine	repository	engine	engine zone	path:core/engine
SUBSYSTEMS

cat > "$WORKSPACE/DOCUMENTATION.md" <<'DOCS'
# Documentation Index
DOCS

echo "[TEST] lint module"

render_repository_lint_from_workspace "$WORKSPACE" "" > "$REPORT_FILE"

if [[ ! -f "$REPORT_FILE" ]]; then
    echo "[FAIL] lint report not generated"
    exit 1
fi

echo "[PASS] lint report generated"

if ! grep -Fq '# Repository Lint Signals' "$REPORT_FILE"; then
    echo "[FAIL] lint report header missing"
    exit 1
fi

echo "[PASS] lint report header present"

if ! grep -Fq 'DOC_MISSING: 1' "$REPORT_FILE"; then
    echo "[FAIL] DOC_MISSING count incorrect"
    exit 1
fi

echo "[PASS] DOC_MISSING detected"

if ! grep -Fq 'ORPHAN_MODULE: 1' "$REPORT_FILE"; then
    echo "[FAIL] ORPHAN_MODULE count incorrect"
    exit 1
fi

echo "[PASS] ORPHAN_MODULE detected"

if ! grep -Fq 'ENTRYPOINT_WITHOUT_COMPONENT: 2' "$REPORT_FILE"; then
    echo "[FAIL] ENTRYPOINT_WITHOUT_COMPONENT count incorrect"
    exit 1
fi

echo "[PASS] ENTRYPOINT_WITHOUT_COMPONENT detected"

if ! grep -Fq 'MODULE_WITHOUT_SUBSYSTEM: 1' "$REPORT_FILE"; then
    echo "[FAIL] MODULE_WITHOUT_SUBSYSTEM count incorrect"
    exit 1
fi

echo "[PASS] MODULE_WITHOUT_SUBSYSTEM detected"

if ! grep -Fq 'EMPTY_SUBSYSTEM: 1' "$REPORT_FILE"; then
    echo "[FAIL] EMPTY_SUBSYSTEM count incorrect"
    exit 1
fi

echo "[PASS] EMPTY_SUBSYSTEM detected"

if ! grep -Fq 'DEPENDENCY_UNKNOWN: 1' "$REPORT_FILE"; then
    echo "[FAIL] DEPENDENCY_UNKNOWN count incorrect"
    exit 1
fi

echo "[PASS] DEPENDENCY_UNKNOWN detected"

if ! grep -Fq 'STRUCTURE_INCONSISTENT: 3' "$REPORT_FILE"; then
    echo "[FAIL] STRUCTURE_INCONSISTENT count incorrect"
    exit 1
fi

echo "[PASS] STRUCTURE_INCONSISTENT detected"

echo "[SUCCESS] lint tests completed"
