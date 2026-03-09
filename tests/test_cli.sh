#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLI="$ROOT_DIR/bin/snapshot"
VERSION="$(cat "$ROOT_DIR/VERSION")"

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
SNAPSHOT_DIR="$ROOT_DIR/snapshots/$SNAPSHOT_DATE/v$VERSION/01_test_cli"

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
DEPENDENCIES.tsv \
GRAPH.tsv \
SEMANTICS.tsv \
ENTRYPOINTS.tsv \
LOG.txt \
SNAPSHOT_META.json \
MANIFEST.md \
AI_INGESTION_GUIDE.md \
ARCHITECTURE.md \
DOCUMENTATION.md \
LANGUAGES.md \
COMPONENTS.md \
PURPOSE.md
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

if ! grep -Fq $'DEPENDENCY\t'"$ROOT_DIR"$'/bin/snapshot' "$SNAPSHOT_DIR/DEPENDENCIES.tsv"; then
    echo "[FAIL] dependencies snapshot content invalid"
    exit 1
fi

echo "[PASS] dependencies snapshot generated"

if ! grep -Fq $'GRAPH\tbin/snapshot\tgenerates\tGRAPH.tsv' "$SNAPSHOT_DIR/GRAPH.tsv"; then
    echo "[FAIL] graph snapshot content invalid"
    exit 1
fi

echo "[PASS] graph snapshot generated"

if ! grep -Fq $'SEMANTIC\t'"$ROOT_DIR"$'/bin/snapshot\tcli\tpath:bin' "$SNAPSHOT_DIR/SEMANTICS.tsv"; then
    echo "[FAIL] semantics snapshot content invalid for CLI"
    exit 1
fi

echo "[PASS] semantics snapshot contains CLI entry"

if ! grep -Fq $'SEMANTIC\t'"$ROOT_DIR"$'/core/semantics.sh\tcore\tpath:core' "$SNAPSHOT_DIR/SEMANTICS.tsv"; then
    echo "[FAIL] semantics snapshot content invalid for core"
    exit 1
fi

echo "[PASS] semantics snapshot contains core entry"

if grep -q "snapshots/" "$SNAPSHOT_DIR/SEMANTICS.tsv"; then
    echo "[FAIL] exclusion rules not applied (snapshots found in semantics)"
    exit 1
fi

echo "[PASS] semantics respects exclusion rules"

if ! grep -Fq $'ENTRYPOINT\t'"$ROOT_DIR"$'/bin/snapshot\tcli\tpath:bin' "$SNAPSHOT_DIR/ENTRYPOINTS.tsv"; then
    echo "[FAIL] entrypoints snapshot content invalid for CLI"
    exit 1
fi

echo "[PASS] entrypoints snapshot contains CLI entry"

if grep -Fq $'ENTRYPOINT\t'"$ROOT_DIR"$'/tests/test_entrypoints.sh' "$SNAPSHOT_DIR/ENTRYPOINTS.tsv"; then
    echo "[FAIL] non-root script incorrectly detected as root entrypoint"
    exit 1
fi

echo "[PASS] non-root scripts are not misdetected as root entrypoints"

if grep -q "snapshots/" "$SNAPSHOT_DIR/ENTRYPOINTS.tsv"; then
    echo "[FAIL] exclusion rules not applied (snapshots found in entrypoints)"
    exit 1
fi

echo "[PASS] entrypoints respect exclusion rules"

if ! grep -Fq '# Components Summary' "$SNAPSHOT_DIR/COMPONENTS.md"; then
    echo "[FAIL] components summary header missing"
    exit 1
fi

echo "[PASS] components summary header present"

if ! grep -Fq '### cli' "$SNAPSHOT_DIR/COMPONENTS.md"; then
    echo "[FAIL] components summary missing cli section"
    exit 1
fi

echo "[PASS] components summary contains cli section"

if ! grep -Fq -- "- $ROOT_DIR/bin/snapshot" "$SNAPSHOT_DIR/COMPONENTS.md"; then
    echo "[FAIL] components summary missing CLI file reference"
    exit 1
fi

echo "[PASS] components summary contains CLI file reference"

if ! grep -Fq '# Repository Purpose Summary' "$SNAPSHOT_DIR/PURPOSE.md"; then
    echo "[FAIL] purpose summary header missing"
    exit 1
fi

echo "[PASS] purpose summary header present"

if ! grep -Fq 'Primary classification:' "$SNAPSHOT_DIR/PURPOSE.md"; then
    echo "[FAIL] purpose classification missing"
    exit 1
fi

echo "[PASS] purpose classification present"

if ! grep -Fq '2. PURPOSE.md' "$SNAPSHOT_DIR/AI_INGESTION_GUIDE.md"; then
    echo "[FAIL] AI ingestion guide missing purpose reading order"
    exit 1
fi

echo "[PASS] AI ingestion guide references purpose"

if ! grep -Fq 'Purpose summary generated' "$SNAPSHOT_DIR/LOG.txt"; then
    echo "[FAIL] log missing purpose generation marker"
    exit 1
fi

echo "[PASS] log contains purpose generation marker"

rm -rf "$SNAPSHOT_DIR"

echo "[SUCCESS] CLI tests completed"
