#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$ROOT_DIR/core/indexer.sh"

echo "[TEST] indexer module"

TMP_DIR="$ROOT_DIR/tests/fixtures/tmp_index_test"
mkdir -p "$TMP_DIR"

echo "hello world" > "$TMP_DIR/file1.txt"
echo "another line" > "$TMP_DIR/file2.txt"

index_file="$TMP_DIR/index.tsv"

generate_index "$TMP_DIR" > "$index_file"

if [[ ! -f "$index_file" ]]; then
    echo "[FAIL] index file not generated"
    exit 1
fi

lines="$(wc -l < "$index_file")"

if [[ "$lines" -lt 2 ]]; then
    echo "[FAIL] index file content invalid"
    exit 1
fi

echo "[PASS] index generation"

rm -rf "$TMP_DIR"

echo "[SUCCESS] indexer tests completed"
