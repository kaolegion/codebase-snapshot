#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLI="$ROOT_DIR/bin/snapshot"

echo "[TEST] CLI availability"

if [[ ! -f "$CLI" ]]; then
    echo "[FAIL] snapshot CLI not found"
    exit 1
fi

if [[ ! -x "$CLI" ]]; then
    echo "[FAIL] snapshot CLI not executable"
    exit 1
fi

echo "[PASS] CLI exists and is executable"

SNAPSHOT_DATE="$(date +%Y-%m-%d)"
SNAPSHOT_DIR="$ROOT_DIR/snapshots/$SNAPSHOT_DATE/v0.1.0/01_test_cli"

rm -rf "$SNAPSHOT_DIR"

"$CLI" --target "$ROOT_DIR" --label "test cli" >/dev/null

if [[ ! -d "$SNAPSHOT_DIR" ]]; then
    echo "[FAIL] snapshot directory not generated"
    exit 1
fi

echo "[PASS] snapshot directory created"

for file in \
PROJECT_TREE.txt \
INDEX.tsv \
LOG.txt \
SNAPSHOT_META.json \
MANIFEST.md \
AI_INGESTION_GUIDE.md \
ARCHITECTURE.md \
DOCUMENTATION.md \
LANGUAGES.md
do
    if [[ ! -f "$SNAPSHOT_DIR/$file" ]]; then
        echo "[FAIL] missing snapshot file: $file"
        exit 1
    fi
done

echo "[PASS] core snapshot files present"

CODEBASE_DIR="$SNAPSHOT_DIR/CODEBASE"

if [[ ! -d "$CODEBASE_DIR" ]]; then
    echo "[FAIL] CODEBASE directory missing"
    exit 1
fi

for file in \
01_cli.md \
02_core.md \
03_tests.md \
04_docs.md
do
    if [[ ! -f "$CODEBASE_DIR/$file" ]]; then
        echo "[FAIL] missing CODEBASE file: $file"
        exit 1
    fi
done

echo "[PASS] CODEBASE export present"

if grep -q "snapshots/" "$SNAPSHOT_DIR/INDEX.tsv"; then
    echo "[FAIL] exclusion rules not applied (snapshots found in index)"
    exit 1
fi

echo "[PASS] exclusion rules applied"

rm -rf "$SNAPSHOT_DIR"

echo "[SUCCESS] CLI tests completed"
