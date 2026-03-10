#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEST_TMP_DIR="$ROOT_DIR/tests/.tmp/test_health"

echo "[TEST] health module"

rm -rf "$TEST_TMP_DIR"
mkdir -p "$TEST_TMP_DIR/history/snapshot_A"
mkdir -p "$TEST_TMP_DIR/history/snapshot_B"
mkdir -p "$TEST_TMP_DIR/history/snapshot_C"

cat > "$TEST_TMP_DIR/history_index.tsv" <<'INDEX'
TIMESTAMP	SNAPSHOT_ID	SNAPSHOT_PATH
2026-03-10T10:00:00Z	snapshot_A	TEST_PATH_A
2026-03-10T10:10:00Z	snapshot_B	TEST_PATH_B
2026-03-10T10:20:00Z	snapshot_C	TEST_PATH_C
INDEX

sed -i "s|TEST_PATH_A|$TEST_TMP_DIR/history/snapshot_A|g" "$TEST_TMP_DIR/history_index.tsv"
sed -i "s|TEST_PATH_B|$TEST_TMP_DIR/history/snapshot_B|g" "$TEST_TMP_DIR/history_index.tsv"
sed -i "s|TEST_PATH_C|$TEST_TMP_DIR/history/snapshot_C|g" "$TEST_TMP_DIR/history_index.tsv"

cat > "$TEST_TMP_DIR/history/snapshot_A/SNAPSHOT_META.json" <<'EOF_META_A'
{
  "snapshot_version": "1",
  "tool_version": "v1.1.0",
  "generated_at": "2026-03-10",
  "target_root": "/tmp/repo",
  "label": "Alpha",
  "normalized_label": "alpha",
  "sequence": "01",
  "file_count": 10
}
EOF_META_A

cat > "$TEST_TMP_DIR/history/snapshot_B/SNAPSHOT_META.json" <<'EOF_META_B'
{
  "snapshot_version": "1",
  "tool_version": "v1.1.0",
  "generated_at": "2026-03-10",
  "target_root": "/tmp/repo",
  "label": "Beta",
  "normalized_label": "beta",
  "sequence": "01",
  "file_count": 13
}
EOF_META_B

cat > "$TEST_TMP_DIR/history/snapshot_C/SNAPSHOT_META.json" <<'EOF_META_C'
{
  "snapshot_version": "1",
  "tool_version": "v1.2.0",
  "generated_at": "2026-03-10",
  "target_root": "/tmp/repo",
  "label": "Beta",
  "normalized_label": "beta",
  "sequence": "01",
  "file_count": 13
}
EOF_META_C

cat > "$TEST_TMP_DIR/EVOLUTION_SIGNALS.tsv" <<'EOF_SIGNALS'
SIGNAL FILE_COUNT_INCREASED snapshot_A snapshot_B 3
SIGNAL LABEL_CHANGED snapshot_A snapshot_B alpha->beta
SIGNAL FILE_COUNT_STABLE snapshot_B snapshot_C 0
SIGNAL TOOL_VERSION_CHANGED snapshot_B snapshot_C v1.1.0->v1.2.0
EOF_SIGNALS

source "$ROOT_DIR/core/config.sh"
source "$ROOT_DIR/core/history.sh"
source "$ROOT_DIR/core/timeline.sh"
source "$ROOT_DIR/core/health.sh"

snapshot_history_index_file() {
    printf "%s/history_index.tsv\n" "$TEST_TMP_DIR"
}

snapshot_history_root_dir() {
    printf "%s/history\n" "$TEST_TMP_DIR"
}

ROOT_DIR="$TEST_TMP_DIR"

output_file="$(write_repository_health)"

test -f "$output_file"
echo "[PASS] repository health file generated"

grep -F "# Repository Health" "$output_file" >/dev/null
echo "[PASS] health header present"

grep -F "## Repository Health Signals" "$output_file" >/dev/null
echo "[PASS] health signals section present"

grep -F "## Signal Evidence" "$output_file" >/dev/null
echo "[PASS] signal evidence section present"

grep -F "## Deterministic Interpretation" "$output_file" >/dev/null
echo "[PASS] deterministic interpretation section present"

grep -F -- "- REPOSITORY_GROWING: yes" "$output_file" >/dev/null
echo "[PASS] repository growing signal detected"

grep -F -- "- REPOSITORY_STABLE: no" "$output_file" >/dev/null
echo "[PASS] repository stable signal detected"

grep -F -- "- CHANGE_ACTIVITY_LOW: no" "$output_file" >/dev/null
echo "[PASS] low activity signal detected"

grep -F -- "- CHANGE_ACTIVITY_MODERATE: yes" "$output_file" >/dev/null
echo "[PASS] moderate activity signal detected"

grep -F -- "- TOOL_VERSION_PROGRESSING: yes" "$output_file" >/dev/null
echo "[PASS] tool version progression detected"

grep -F -- "- SNAPSHOT_LABELS_EVOLVING: yes" "$output_file" >/dev/null
echo "[PASS] snapshot labels evolving detected"

grep -F -- "- Archived snapshots: 3" "$output_file" >/dev/null
echo "[PASS] archived snapshots evidence present"

grep -F -- "- Snapshot transitions: 2" "$output_file" >/dev/null
echo "[PASS] transition evidence present"

grep -F -- "- FILE_COUNT_INCREASED events: 1" "$output_file" >/dev/null
echo "[PASS] file increase evidence present"

grep -F -- "- FILE_COUNT_STABLE events: 1" "$output_file" >/dev/null
echo "[PASS] file stable evidence present"

grep -F -- "- Tool versions observed: v1.1.0,v1.2.0" "$output_file" >/dev/null
echo "[PASS] tool versions evidence present"

grep -F -- "- Normalized labels observed: alpha,beta" "$output_file" >/dev/null
echo "[PASS] normalized labels evidence present"

rm -rf "$TEST_TMP_DIR"

echo "[SUCCESS] health tests completed"
