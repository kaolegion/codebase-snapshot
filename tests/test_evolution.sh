#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TEST_TMP_DIR="$ROOT_DIR/tests/.tmp/test_evolution"

echo "[TEST] evolution module"

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

cat > "$TEST_TMP_DIR/history/snapshot_A/SNAPSHOT_META.json" <<'EOF_META'
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
EOF_META

cat > "$TEST_TMP_DIR/history/snapshot_B/SNAPSHOT_META.json" <<'EOF_META'
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
EOF_META

cat > "$TEST_TMP_DIR/history/snapshot_C/SNAPSHOT_META.json" <<'EOF_META'
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
EOF_META

source "$ROOT_DIR/core/config.sh"
source "$ROOT_DIR/core/history.sh"
source "$ROOT_DIR/core/evolution.sh"

snapshot_history_index_file() {
    printf "%s/history_index.tsv\n" "$TEST_TMP_DIR"
}

snapshot_history_root_dir() {
    printf "%s/history\n" "$TEST_TMP_DIR"
}

ROOT_DIR="$TEST_TMP_DIR"

output_file="$(write_evolution_signals)"

test -f "$output_file"
echo "[PASS] evolution signals file generated"

grep -Fx 'SIGNAL FILE_COUNT_INCREASED snapshot_A snapshot_B 3' "$output_file" >/dev/null
echo "[PASS] file count increase detected"

grep -Fx 'SIGNAL LABEL_CHANGED snapshot_A snapshot_B alpha->beta' "$output_file" >/dev/null
echo "[PASS] label change detected"

grep -Fx 'SIGNAL FILE_COUNT_STABLE snapshot_B snapshot_C 0' "$output_file" >/dev/null
echo "[PASS] file count stable detected"

grep -Fx 'SIGNAL TOOL_VERSION_CHANGED snapshot_B snapshot_C v1.1.0->v1.2.0' "$output_file" >/dev/null
echo "[PASS] tool version change detected"

expected_file="$TEST_TMP_DIR/expected.tsv"
cat > "$expected_file" <<'EOF_EXPECTED'
SIGNAL FILE_COUNT_INCREASED snapshot_A snapshot_B 3
SIGNAL LABEL_CHANGED snapshot_A snapshot_B alpha->beta
SIGNAL FILE_COUNT_STABLE snapshot_B snapshot_C 0
SIGNAL TOOL_VERSION_CHANGED snapshot_B snapshot_C v1.1.0->v1.2.0
EOF_EXPECTED

diff -u "$expected_file" "$output_file" >/dev/null
echo "[PASS] deterministic signal ordering verified"

rm -rf "$TEST_TMP_DIR"

echo "[SUCCESS] evolution tests completed"
