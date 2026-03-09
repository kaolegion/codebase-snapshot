#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT_DIR/core/diff.sh"

TMP_ROOT="$(mktemp -d)"
SNAPSHOT_A="$TMP_ROOT/snapshots/2026-03-09/v0.8.0/01_before"
SNAPSHOT_B="$TMP_ROOT/snapshots/2026-03-09/v0.9.0/01_after"

cleanup() {
    rm -rf "$TMP_ROOT"
    rm -rf "$(snapshot_diff_output_dir "$SNAPSHOT_A" "$SNAPSHOT_B")"
}

trap cleanup EXIT

mkdir -p "$SNAPSHOT_A" "$SNAPSHOT_B"

cat > "$SNAPSHOT_A/INDEX.tsv" <<'EOF_A'
FILE	/tmp/example/README.md	100	10
FILE	/tmp/example/bin/snapshot	200	20
FILE	/tmp/example/core/engine.sh	300	30
FILE	/tmp/example/tests/legacy.sh	400	40
EOF_A

cat > "$SNAPSHOT_B/INDEX.tsv" <<'EOF_B'
FILE	/tmp/example/README.md	100	10
FILE	/tmp/example/bin/snapshot	200	20
FILE	/tmp/example/core/diff.sh	150	15
FILE	/tmp/example/core/engine.sh	333	31
EOF_B

echo "[TEST] diff engine"

generate_snapshot_diff "$SNAPSHOT_A" "$SNAPSHOT_B" > "$TMP_ROOT/diff_1.tsv"
generate_snapshot_diff "$SNAPSHOT_A" "$SNAPSHOT_B" > "$TMP_ROOT/diff_2.tsv"

cmp -s "$TMP_ROOT/diff_1.tsv" "$TMP_ROOT/diff_2.tsv"
echo "[PASS] deterministic diff detection"

grep -Fx $'DIFF\tADDED\t/tmp/example/core/diff.sh' "$TMP_ROOT/diff_1.tsv" >/dev/null
echo "[PASS] added file detected"

grep -Fx $'DIFF\tREMOVED\t/tmp/example/tests/legacy.sh' "$TMP_ROOT/diff_1.tsv" >/dev/null
echo "[PASS] removed file detected"

grep -Fx $'DIFF\tMODIFIED\t/tmp/example/core/engine.sh' "$TMP_ROOT/diff_1.tsv" >/dev/null
echo "[PASS] modified file detected"

render_snapshot_diff "$SNAPSHOT_A" "$SNAPSHOT_B" "$TMP_ROOT/diff_1.tsv" > "$TMP_ROOT/SNAPSHOT_DIFF.md"

grep -F "# Snapshot Diff" "$TMP_ROOT/SNAPSHOT_DIFF.md" >/dev/null
grep -F "## Added Files" "$TMP_ROOT/SNAPSHOT_DIFF.md" >/dev/null
grep -F "## Removed Files" "$TMP_ROOT/SNAPSHOT_DIFF.md" >/dev/null
grep -F "## Modified Files" "$TMP_ROOT/SNAPSHOT_DIFF.md" >/dev/null
grep -F "Core engine evolution detected." "$TMP_ROOT/SNAPSHOT_DIFF.md" >/dev/null
echo "[PASS] snapshot diff markdown generated"

echo "[TEST] diff cli"

DIFF_DIR="$(snapshot_diff_output_dir "$SNAPSHOT_A" "$SNAPSHOT_B")"
bash "$ROOT_DIR/bin/snapshot" diff "$SNAPSHOT_A" "$SNAPSHOT_B" > "$TMP_ROOT/cli_output.txt"

[[ -f "$DIFF_DIR/DIFF.tsv" ]]
[[ -f "$DIFF_DIR/SNAPSHOT_DIFF.md" ]]
grep -F "[INFO] Snapshot diff generated:" "$TMP_ROOT/cli_output.txt" >/dev/null
grep -Fx $'DIFF\tADDED\t/tmp/example/core/diff.sh' "$DIFF_DIR/DIFF.tsv" >/dev/null
echo "[PASS] diff cli output generated"

echo "[SUCCESS] diff tests completed"
