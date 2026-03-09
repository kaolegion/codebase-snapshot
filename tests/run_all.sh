#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "[TEST] Running codebase-snapshot test suite"

bash "$ROOT_DIR/tests/test_naming.sh"
bash "$ROOT_DIR/tests/test_indexer.sh"
bash "$ROOT_DIR/tests/test_dependencies.sh"
bash "$ROOT_DIR/tests/test_graph.sh"
bash "$ROOT_DIR/tests/test_semantics.sh"
bash "$ROOT_DIR/tests/test_entrypoints.sh"
bash "$ROOT_DIR/tests/test_purpose.sh"
bash "$ROOT_DIR/tests/test_structure.sh"
bash "$ROOT_DIR/tests/test_system_flow.sh"
bash "$ROOT_DIR/tests/test_repository_explain.sh"
bash "$ROOT_DIR/tests/test_dna.sh"
bash "$ROOT_DIR/tests/test_diff.sh"
bash "$ROOT_DIR/tests/test_cli.sh"

echo "[SUCCESS] Full test suite passed"
