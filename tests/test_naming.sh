#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$ROOT_DIR/core/naming.sh"

echo "[TEST] naming module"

label="$(normalize_label "Initial Snapshot")"

if [[ "$label" != "initial_snapshot" ]]; then
    echo "[FAIL] label normalization failed"
    exit 1
fi

echo "[PASS] label normalization"

echo "[SUCCESS] naming tests completed"
