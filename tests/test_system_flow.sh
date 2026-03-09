#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLI="$ROOT_DIR/bin/snapshot"
VERSION="$(cat "$ROOT_DIR/VERSION")"

echo "[TEST] System flow rendering"

SNAPSHOT_DATE="$(date +%Y-%m-%d)"
SNAPSHOT_DIR="$ROOT_DIR/snapshots/$SNAPSHOT_DATE/$VERSION/01_test_system_flow"

rm -rf "$SNAPSHOT_DIR"

"$CLI" --target "$ROOT_DIR" --label "test system flow" >/dev/null

if [[ ! -f "$SNAPSHOT_DIR/SYSTEM_FLOW.md" ]]; then
    echo "[FAIL] SYSTEM_FLOW.md not generated"
    exit 1
fi

echo "[PASS] SYSTEM_FLOW.md generated"

if ! grep -q "System Flow Overview" "$SNAPSHOT_DIR/SYSTEM_FLOW.md"; then
    echo "[FAIL] system flow header missing"
    exit 1
fi

echo "[PASS] system flow header present"

if ! grep -q 'bin/snapshot' "$SNAPSHOT_DIR/SYSTEM_FLOW.md"; then
    echo "[FAIL] execution entrypoint missing"
    exit 1
fi

echo "[PASS] execution entrypoint detected"

if ! grep -q "Main Internal Pipeline" "$SNAPSHOT_DIR/SYSTEM_FLOW.md"; then
    echo "[FAIL] internal pipeline section missing"
    exit 1
fi

echo "[PASS] internal pipeline section present"

if ! grep -q "Generated Artifacts" "$SNAPSHOT_DIR/SYSTEM_FLOW.md"; then
    echo "[FAIL] generated artifacts section missing"
    exit 1
fi

echo "[PASS] generated artifacts section present"

if ! grep -q "System flow summary generated" "$SNAPSHOT_DIR/LOG.txt"; then
    echo "[FAIL] system flow generation not logged"
    exit 1
fi

echo "[PASS] system flow generation logged"

rm -rf "$SNAPSHOT_DIR"

echo "[SUCCESS] system flow tests completed"
