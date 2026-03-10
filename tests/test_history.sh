#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLI="$ROOT_DIR/bin/snapshot"
VERSION="$(cat "$ROOT_DIR/VERSION")"
SNAPSHOT_DATE="$(date +%Y-%m-%d)"

SNAPSHOT_DIR="$ROOT_DIR/snapshots/$SNAPSHOT_DATE/$VERSION/01_test_history"
HISTORY_ROOT="$ROOT_DIR/.snapshots"
HISTORY_INDEX="$ROOT_DIR/SNAPSHOT_HISTORY.tsv"
TMP_OUTPUT="$(mktemp)"

cleanup() {
    rm -f "$TMP_OUTPUT"
    rm -rf "$SNAPSHOT_DIR"
    rm -rf "$HISTORY_ROOT"
    rm -f "$HISTORY_INDEX"
}

trap cleanup EXIT

echo "[TEST] history engine"

"$CLI" history > "$TMP_OUTPUT"

if [[ ! -f "$HISTORY_INDEX" ]]; then
    echo "[FAIL] history index not initialized"
    exit 1
fi

grep -Fx $'TIMESTAMP\tSNAPSHOT_ID\tSNAPSHOT_PATH' "$HISTORY_INDEX" >/dev/null
echo "[PASS] history index initialized"

"$CLI" --target "$ROOT_DIR" --label "test history" >/dev/null

if [[ ! -d "$SNAPSHOT_DIR" ]]; then
    echo "[FAIL] snapshot directory not generated for history test"
    exit 1
fi

echo "[PASS] snapshot generated for history test"

if [[ ! -d "$HISTORY_ROOT" ]]; then
    echo "[FAIL] history archive directory not created"
    exit 1
fi

echo "[PASS] history archive root created"

line_count="$(awk 'END { print NR }' "$HISTORY_INDEX")"
if [[ "$line_count" -lt 2 ]]; then
    echo "[FAIL] history index missing snapshot entry"
    exit 1
fi

echo "[PASS] history index contains snapshot entry"

snapshot_id="$(awk -F'\t' 'NR == 2 { print $2 }' "$HISTORY_INDEX")"
snapshot_path="$(awk -F'\t' 'NR == 2 { print $3 }' "$HISTORY_INDEX")"

if [[ -z "$snapshot_id" ]]; then
    echo "[FAIL] snapshot id missing from history index"
    exit 1
fi

echo "[PASS] snapshot id recorded"

if [[ -z "$snapshot_path" ]]; then
    echo "[FAIL] snapshot path missing from history index"
    exit 1
fi

echo "[PASS] snapshot path recorded"

if [[ ! -d "$snapshot_path" ]]; then
    echo "[FAIL] archived snapshot directory missing"
    exit 1
fi

echo "[PASS] archived snapshot directory exists"

if [[ "$snapshot_path" != "$HISTORY_ROOT"/snapshot_* ]]; then
    echo "[FAIL] archived snapshot path format invalid"
    exit 1
fi

echo "[PASS] archived snapshot path format valid"

for file in \
INDEX.tsv \
GRAPH.tsv \
SEMANTICS.tsv \
ENTRYPOINTS.tsv \
MODULES.tsv \
SUBSYSTEMS.tsv \
REPOSITORY_EXPLAIN.md \
REPOSITORY_DNA.md \
SNAPSHOT_META.json
do
    if [[ ! -f "$snapshot_path/$file" ]]; then
        echo "[FAIL] archived snapshot missing file: $file"
        exit 1
    fi
done

echo "[PASS] archived snapshot content present"

"$CLI" history > "$TMP_OUTPUT"

grep -Fx $'TIMESTAMP\tSNAPSHOT_ID\tSNAPSHOT_PATH' "$TMP_OUTPUT" >/dev/null
grep -F "$snapshot_id" "$TMP_OUTPUT" >/dev/null
grep -F "$snapshot_path" "$TMP_OUTPUT" >/dev/null
echo "[PASS] history cli lists archived snapshot"

echo "[SUCCESS] history tests completed"
