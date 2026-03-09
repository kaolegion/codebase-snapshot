#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLI="$ROOT_DIR/bin/snapshot"
VERSION="$(cat "$ROOT_DIR/VERSION")"

echo "[TEST] Repository explain rendering"

SNAPSHOT_DATE="$(date +%Y-%m-%d)"
SNAPSHOT_DIR="$ROOT_DIR/snapshots/$SNAPSHOT_DATE/$VERSION/01_test_repository_explain"

rm -rf "$SNAPSHOT_DIR"

"$CLI" --target "$ROOT_DIR" --label "test repository explain" >/dev/null

if [[ ! -f "$SNAPSHOT_DIR/REPOSITORY_EXPLAIN.md" ]]; then
    echo "[FAIL] REPOSITORY_EXPLAIN.md not generated"
    exit 1
fi

echo "[PASS] REPOSITORY_EXPLAIN.md generated"

if ! grep -q "Repository Explanation" "$SNAPSHOT_DIR/REPOSITORY_EXPLAIN.md"; then
    echo "[FAIL] repository explanation header missing"
    exit 1
fi

echo "[PASS] repository explanation header present"

if ! grep -q "## Repository Identity" "$SNAPSHOT_DIR/REPOSITORY_EXPLAIN.md"; then
    echo "[FAIL] repository identity section missing"
    exit 1
fi

echo "[PASS] repository identity section present"

if ! grep -q "## Purpose" "$SNAPSHOT_DIR/REPOSITORY_EXPLAIN.md"; then
    echo "[FAIL] purpose section missing"
    exit 1
fi

echo "[PASS] purpose section present"

if ! grep -q "## Execution Entrypoints" "$SNAPSHOT_DIR/REPOSITORY_EXPLAIN.md"; then
    echo "[FAIL] execution entrypoints section missing"
    exit 1
fi

echo "[PASS] execution entrypoints section present"

if ! grep -q 'bin/snapshot' "$SNAPSHOT_DIR/REPOSITORY_EXPLAIN.md"; then
    echo "[FAIL] main CLI entrypoint missing"
    exit 1
fi

echo "[PASS] main CLI entrypoint present"

if ! grep -q "## Internal Operation" "$SNAPSHOT_DIR/REPOSITORY_EXPLAIN.md"; then
    echo "[FAIL] internal operation section missing"
    exit 1
fi

echo "[PASS] internal operation section present"

if ! grep -q "## Architecture Overview" "$SNAPSHOT_DIR/REPOSITORY_EXPLAIN.md"; then
    echo "[FAIL] architecture overview section missing"
    exit 1
fi

echo "[PASS] architecture overview section present"

if ! grep -q "## Semantic Components" "$SNAPSHOT_DIR/REPOSITORY_EXPLAIN.md"; then
    echo "[FAIL] semantic components section missing"
    exit 1
fi

echo "[PASS] semantic components section present"

if ! grep -q "## Generated Snapshot Artifacts" "$SNAPSHOT_DIR/REPOSITORY_EXPLAIN.md"; then
    echo "[FAIL] generated snapshot artifacts section missing"
    exit 1
fi

echo "[PASS] generated snapshot artifacts section present"

if ! grep -q "## Interpretation Notes" "$SNAPSHOT_DIR/REPOSITORY_EXPLAIN.md"; then
    echo "[FAIL] interpretation notes section missing"
    exit 1
fi

echo "[PASS] interpretation notes section present"

if ! grep -q "Repository explain summary generated" "$SNAPSHOT_DIR/LOG.txt"; then
    echo "[FAIL] repository explain generation not logged"
    exit 1
fi

echo "[PASS] repository explain generation logged"

if ! grep -q "2. REPOSITORY_EXPLAIN.md" "$SNAPSHOT_DIR/AI_INGESTION_GUIDE.md"; then
    echo "[FAIL] AI ingestion guide missing repository explain reading order"
    exit 1
fi

echo "[PASS] AI ingestion guide includes repository explain"

rm -rf "$SNAPSHOT_DIR"

echo "[SUCCESS] repository explain tests completed"
