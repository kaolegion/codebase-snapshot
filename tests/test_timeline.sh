#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLI="$ROOT_DIR/bin/snapshot"
TIMELINE_FILE="$ROOT_DIR/REPOSITORY_TIMELINE.md"
HISTORY_ROOT="$ROOT_DIR/.snapshots"
HISTORY_INDEX="$ROOT_DIR/SNAPSHOT_HISTORY.tsv"
TMP_OUTPUT="$(mktemp -d)"

cleanup() {
    rm -rf "$TMP_OUTPUT"
    rm -rf "$HISTORY_ROOT"
    rm -f "$HISTORY_INDEX"
    rm -f "$TIMELINE_FILE"
}

trap cleanup EXIT

mkdir -p "$HISTORY_ROOT"

cat > "$HISTORY_INDEX" <<'EOF_HISTORY'
TIMESTAMP	SNAPSHOT_ID	SNAPSHOT_PATH
2026-03-09T18:45:01Z	snapshot_20260309_184501	ROOT_PLACEHOLDER/.snapshots/snapshot_20260309_184501
2026-03-10T09:12:12Z	snapshot_20260310_091212	ROOT_PLACEHOLDER/.snapshots/snapshot_20260310_091212
EOF_HISTORY

sed -i "s|ROOT_PLACEHOLDER|$ROOT_DIR|g" "$HISTORY_INDEX"

mkdir -p "$HISTORY_ROOT/snapshot_20260309_184501"
mkdir -p "$HISTORY_ROOT/snapshot_20260310_091212"

cat > "$HISTORY_ROOT/snapshot_20260309_184501/SNAPSHOT_META.json" <<'EOF_META_A'
{
  "snapshot_version": "1",
  "tool_version": "v0.9.0",
  "generated_at": "2026-03-09",
  "target_root": "/tmp/example",
  "label": "baseline",
  "normalized_label": "baseline",
  "sequence": "01",
  "file_count": 42
}
EOF_META_A

cat > "$HISTORY_ROOT/snapshot_20260310_091212/SNAPSHOT_META.json" <<'EOF_META_B'
{
  "snapshot_version": "1",
  "tool_version": "v1.0.0",
  "generated_at": "2026-03-10",
  "target_root": "/tmp/example",
  "label": "phase 5 test",
  "normalized_label": "phase_5_test",
  "sequence": "01",
  "file_count": 57
}
EOF_META_B

echo "[TEST] timeline engine"

bash "$CLI" timeline > "$TMP_OUTPUT/cli_output.txt"

if [[ ! -f "$TIMELINE_FILE" ]]; then
    echo "[FAIL] repository timeline not generated"
    exit 1
fi

echo "[PASS] repository timeline generated"

grep -F "# Repository Timeline" "$TIMELINE_FILE" >/dev/null
echo "[PASS] timeline header present"

grep -F "Total archived snapshots: 2" "$TIMELINE_FILE" >/dev/null
echo "[PASS] timeline snapshot count present"

grep -F "## 1. snapshot_20260309_184501" "$TIMELINE_FILE" >/dev/null
echo "[PASS] first snapshot section present"

grep -F "## 2. snapshot_20260310_091212" "$TIMELINE_FILE" >/dev/null
echo "[PASS] second snapshot section present"

grep -F -- "- Label: baseline" "$TIMELINE_FILE" >/dev/null
echo "[PASS] first snapshot label present"

grep -F -- "- Normalized label: phase_5_test" "$TIMELINE_FILE" >/dev/null
echo "[PASS] normalized label present"

grep -F -- "- File count: 42" "$TIMELINE_FILE" >/dev/null
echo "[PASS] first snapshot file count present"

grep -F -- "- File count: 57" "$TIMELINE_FILE" >/dev/null
echo "[PASS] second snapshot file count present"

grep -F "$ROOT_DIR/.snapshots/snapshot_20260309_184501" "$TIMELINE_FILE" >/dev/null
echo "[PASS] archive path present"

grep -F "[INFO] Repository timeline generated: $TIMELINE_FILE" "$TMP_OUTPUT/cli_output.txt" >/dev/null
echo "[PASS] timeline cli output generated"

echo "[SUCCESS] timeline tests completed"
