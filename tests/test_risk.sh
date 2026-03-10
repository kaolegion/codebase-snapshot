#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$ROOT_DIR/core/config.sh"
source "$ROOT_DIR/core/scanner.sh"
source "$ROOT_DIR/core/indexer.sh"
source "$ROOT_DIR/core/dependencies.sh"
source "$ROOT_DIR/core/entrypoints.sh"
source "$ROOT_DIR/core/history.sh"
source "$ROOT_DIR/core/timeline.sh"
source "$ROOT_DIR/core/risk.sh"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

TEST_REPO="$TMP_DIR/repo"
mkdir -p "$TEST_REPO/bin" "$TEST_REPO/core"

cat > "$TEST_REPO/bin/app.sh" <<'APP'
#!/usr/bin/env bash
source "core/engine.sh"
echo "app"
APP

cat > "$TEST_REPO/core/engine.sh" <<'ENGINE'
#!/usr/bin/env bash
echo "engine"
ENGINE

cat > "$TEST_REPO/core/worker.sh" <<'WORKER'
#!/usr/bin/env bash
source "core/engine.sh"
echo "worker"
WORKER

cat > "$TEST_REPO/README.md" <<'README'
# Test Repository
README

SNAPSHOT_DATE="2026-03-10"
VERSION_A="v9.9.0"
VERSION_B="v9.9.1"
SNAPSHOT_A="$ROOT_DIR/snapshots/$SNAPSHOT_DATE/$VERSION_A/01_risk_alpha"
SNAPSHOT_B="$ROOT_DIR/snapshots/$SNAPSHOT_DATE/$VERSION_B/01_risk_beta"

mkdir -p "$SNAPSHOT_A" "$SNAPSHOT_B"

generate_index "$TEST_REPO" > "$SNAPSHOT_A/INDEX.tsv"
cat > "$SNAPSHOT_A/SNAPSHOT_META.json" <<'EOF_META_A'
{
  "tool_version": "v9.9.0",
  "generated_at": "2026-03-10",
  "normalized_label": "risk_alpha",
  "file_count": 4
}
EOF_META_A

generate_index "$TEST_REPO" > "$SNAPSHOT_B/INDEX.tsv"
cat > "$SNAPSHOT_B/SNAPSHOT_META.json" <<'EOF_META_B'
{
  "tool_version": "v9.9.1",
  "generated_at": "2026-03-10",
  "normalized_label": "risk_beta",
  "file_count": 4
}
EOF_META_B

cat > "$ROOT_DIR/SNAPSHOT_HISTORY.tsv" <<EOF_HISTORY
TIMESTAMP	SNAPSHOT_ID	SNAPSHOT_PATH
2026-03-10T00:00:00Z	snapshot_20260310_000000	$SNAPSHOT_A
2026-03-10T01:00:00Z	snapshot_20260310_010000	$SNAPSHOT_B
EOF_HISTORY

generate_dependencies "$TEST_REPO" > "$ROOT_DIR/DEPENDENCIES.tsv"
generate_entrypoints "$TEST_REPO" > "$ROOT_DIR/ENTRYPOINTS.tsv"

write_repository_risks > /dev/null

if [[ ! -f "$ROOT_DIR/REPOSITORY_RISKS.md" ]]; then
    echo "[FAIL] REPOSITORY_RISKS.md was not generated"
    exit 1
fi

grep -q "^# Repository Risk Signals" "$ROOT_DIR/REPOSITORY_RISKS.md" || {
    echo "[FAIL] missing Repository Risk Signals title"
    exit 1
}

grep -q "core/engine.sh" "$ROOT_DIR/REPOSITORY_RISKS.md" || {
    echo "[FAIL] expected core/engine.sh risk evidence missing"
    exit 1
}

grep -q "bin/app.sh" "$ROOT_DIR/REPOSITORY_RISKS.md" || {
    echo "[FAIL] expected bin/app.sh risk evidence missing"
    exit 1
}

rm -f \
  "$ROOT_DIR/REPOSITORY_RISKS.md" \
  "$ROOT_DIR/DEPENDENCIES.tsv" \
  "$ROOT_DIR/ENTRYPOINTS.tsv" \
  "$ROOT_DIR/SNAPSHOT_HISTORY.tsv"

rm -rf \
  "$ROOT_DIR/snapshots/$SNAPSHOT_DATE/$VERSION_A" \
  "$ROOT_DIR/snapshots/$SNAPSHOT_DATE/$VERSION_B"

echo "[PASS] repository risk signals generated"
