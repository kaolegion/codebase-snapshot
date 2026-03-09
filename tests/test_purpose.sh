#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLI="$ROOT_DIR/bin/snapshot"
VERSION="$(cat "$ROOT_DIR/VERSION")"

echo "[TEST] Purpose detection"

SNAPSHOT_DATE="$(date +%Y-%m-%d)"
SNAPSHOT_DIR="$ROOT_DIR/snapshots/$SNAPSHOT_DATE/$VERSION/01_test_purpose"

rm -rf "$SNAPSHOT_DIR"

"$CLI" --target "$ROOT_DIR" --label "test purpose" >/dev/null

if [[ ! -f "$SNAPSHOT_DIR/PURPOSE.md" ]]; then
    echo "[FAIL] PURPOSE.md not generated"
    exit 1
fi

echo "[PASS] PURPOSE.md generated"

if ! grep -q "Repository Purpose Summary" "$SNAPSHOT_DIR/PURPOSE.md"; then
    echo "[FAIL] purpose summary header missing"
    exit 1
fi

echo "[PASS] purpose header present"

if ! grep -q "Primary classification:" "$SNAPSHOT_DIR/PURPOSE.md"; then
    echo "[FAIL] classification section missing"
    exit 1
fi

echo "[PASS] classification detected"

if ! grep -q "Purpose summary generated" "$SNAPSHOT_DIR/LOG.txt"; then
    echo "[FAIL] purpose generation not logged"
    exit 1
fi

echo "[PASS] purpose generation logged"

rm -rf "$SNAPSHOT_DIR"

echo "[SUCCESS] purpose tests completed"
