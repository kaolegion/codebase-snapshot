#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "[INFO] Fixing executable permissions"

chmod +x "$ROOT_DIR/bin/snapshot"

chmod +x "$ROOT_DIR/tests/run_all.sh"
chmod +x "$ROOT_DIR/tests/test_cli.sh"
chmod +x "$ROOT_DIR/tests/test_indexer.sh"
chmod +x "$ROOT_DIR/tests/test_naming.sh"
chmod +x "$ROOT_DIR/tests/test_dependencies.sh"

echo "[SUCCESS] Permissions corrected"
