#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

CLI="$ROOT_DIR/bin/snapshot"

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

echo "[SUCCESS] CLI tests completed"
