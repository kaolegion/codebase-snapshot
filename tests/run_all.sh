#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "[TEST] Running codebase-snapshot test suite"

bash "$ROOT_DIR/tests/test_naming.sh"
bash "$ROOT_DIR/tests/test_indexer.sh"
bash "$ROOT_DIR/tests/test_dependencies.sh"
bash "$ROOT_DIR/tests/test_cli.sh"

echo "[SUCCESS] All tests passed"
