#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$ROOT_DIR/core/dependencies.sh"

echo "[TEST] dependencies module"

output_file="$ROOT_DIR/tests/fixtures/dependencies_output.tsv"

generate_dependencies "$ROOT_DIR" > "$output_file"

if [[ ! -f "$output_file" ]]; then
    echo "[FAIL] dependencies output not generated"
    exit 1
fi

if ! grep -Fq $'DEPENDENCY\t'"$ROOT_DIR"$'/bin/snapshot\t7\tsource\t$ROOT_DIR/core/config.sh' "$output_file"; then
    echo "[FAIL] expected config dependency not found"
    exit 1
fi

if ! grep -Fq $'DEPENDENCY\t'"$ROOT_DIR"$'/bin/snapshot\t8\tsource\t$ROOT_DIR/core/naming.sh' "$output_file"; then
    echo "[FAIL] expected snapshot dependency not found"
    exit 1
fi

if ! grep -Fq $'DEPENDENCY\t'"$ROOT_DIR"$'/core/architecture.sh\t5\tsource\t$ROOT_DIR/core/structure.sh' "$output_file"; then
    echo "[FAIL] expected architecture dependency not found"
    exit 1
fi

echo "[PASS] dependencies detected"

rm -f "$output_file"

echo "[SUCCESS] dependencies tests completed"
