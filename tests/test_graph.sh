#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$ROOT_DIR/core/graph.sh"

echo "[TEST] graph module"

output_file="$ROOT_DIR/tests/fixtures/graph_output.tsv"

generate_graph "$ROOT_DIR" > "$output_file"

if [[ ! -f "$output_file" ]]; then
    echo "[FAIL] graph output not generated"
    exit 1
fi

if ! grep -Fq $'GRAPH\tbin\tcontains\tbin/snapshot' "$output_file"; then
    echo "[FAIL] expected contains relation not found"
    exit 1
fi

if ! grep -Fq $'GRAPH\tbin/snapshot\trole\tcli_entrypoint' "$output_file"; then
    echo "[FAIL] expected snapshot role relation not found"
    exit 1
fi

if ! grep -Fq $'GRAPH\tbin/snapshot\tdepends_on\tcore/naming.sh' "$output_file"; then
    echo "[FAIL] expected dependency relation not found"
    exit 1
fi

if ! grep -Fq $'GRAPH\tbin/snapshot\tgenerates\tGRAPH.tsv' "$output_file"; then
    echo "[FAIL] expected generated artifact relation not found"
    exit 1
fi

echo "[PASS] graph relations detected"

rm -f "$output_file"

echo "[SUCCESS] graph tests completed"
