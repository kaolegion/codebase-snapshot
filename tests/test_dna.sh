#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CLI="$ROOT_DIR/bin/snapshot"
VERSION="$(cat "$ROOT_DIR/VERSION")"

echo "[TEST] Repository DNA rendering"

SNAPSHOT_DATE="$(date +%Y-%m-%d)"
SNAPSHOT_DIR="$ROOT_DIR/snapshots/$SNAPSHOT_DATE/$VERSION/01_test_repository_dna"

rm -rf "$SNAPSHOT_DIR"

"$CLI" --target "$ROOT_DIR" --label "test repository dna" >/dev/null

if [[ ! -f "$SNAPSHOT_DIR/REPOSITORY_DNA.md" ]]; then
    echo "[FAIL] REPOSITORY_DNA.md not generated"
    exit 1
fi

echo "[PASS] REPOSITORY_DNA.md generated"

if ! grep -q "Repository DNA" "$SNAPSHOT_DIR/REPOSITORY_DNA.md"; then
    echo "[FAIL] repository DNA header missing"
    exit 1
fi

echo "[PASS] repository DNA header present"

if ! grep -q "Project Type:" "$SNAPSHOT_DIR/REPOSITORY_DNA.md"; then
    echo "[FAIL] project type missing"
    exit 1
fi

echo "[PASS] project type present"

if ! grep -q "Languages:" "$SNAPSHOT_DIR/REPOSITORY_DNA.md"; then
    echo "[FAIL] languages line missing"
    exit 1
fi

echo "[PASS] languages line present"

if ! grep -q "## Entrypoints" "$SNAPSHOT_DIR/REPOSITORY_DNA.md"; then
    echo "[FAIL] entrypoints section missing"
    exit 1
fi

echo "[PASS] entrypoints section present"

if ! grep -q 'bin/snapshot' "$SNAPSHOT_DIR/REPOSITORY_DNA.md"; then
    echo "[FAIL] bin/snapshot entrypoint missing"
    exit 1
fi

echo "[PASS] bin/snapshot entrypoint present"

if ! grep -q "Repository DNA summary generated" "$SNAPSHOT_DIR/LOG.txt"; then
    echo "[FAIL] repository DNA generation not logged"
    exit 1
fi

echo "[PASS] repository DNA generation logged"

rm -rf "$SNAPSHOT_DIR"

echo "[SUCCESS] repository DNA tests completed"
