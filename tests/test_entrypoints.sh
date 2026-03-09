#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT_DIR/core/scanner.sh"
source "$ROOT_DIR/core/entrypoints.sh"

TEST_DIR="$(mktemp -d)"
trap 'rm -rf "$TEST_DIR"' EXIT

mkdir -p "$TEST_DIR/bin"
mkdir -p "$TEST_DIR/cmd"
mkdir -p "$TEST_DIR/services"

cat > "$TEST_DIR/bin/tool" <<'FILE'
#!/usr/bin/env bash
echo "cli"
FILE

cat > "$TEST_DIR/cmd/run" <<'FILE'
#!/usr/bin/env bash
echo "cmd"
FILE

cat > "$TEST_DIR/main.py" <<'FILE'
print("app")
FILE

cat > "$TEST_DIR/app.js" <<'FILE'
console.log("app")
FILE

cat > "$TEST_DIR/server.ts" <<'FILE'
console.log("service")
FILE

cat > "$TEST_DIR/Makefile" <<'FILE'
all:
	echo build
FILE

cat > "$TEST_DIR/docker-compose.yml" <<'FILE'
services:
  app:
    image: demo
FILE

cat > "$TEST_DIR/root_script.sh" <<'FILE'
#!/usr/bin/env bash
echo "root script"
FILE

cat > "$TEST_DIR/notes.txt" <<'FILE'
not an entrypoint
FILE

echo "[TEST] entrypoint detection rules"

kind="$(detect_entrypoint_kind "$TEST_DIR" "$TEST_DIR/bin/tool")"
rule="$(detect_entrypoint_rule "$TEST_DIR" "$TEST_DIR/bin/tool")"
[[ "$kind" == "cli" && "$rule" == "path:bin" ]] || {
    echo "[FAIL] bin path rule failed"
    exit 1
}
echo "[PASS] bin path rule"

kind="$(detect_entrypoint_kind "$TEST_DIR" "$TEST_DIR/cmd/run")"
rule="$(detect_entrypoint_rule "$TEST_DIR" "$TEST_DIR/cmd/run")"
[[ "$kind" == "cli" && "$rule" == "path:cmd" ]] || {
    echo "[FAIL] cmd path rule failed"
    exit 1
}
echo "[PASS] cmd path rule"

kind="$(detect_entrypoint_kind "$TEST_DIR" "$TEST_DIR/main.py")"
rule="$(detect_entrypoint_rule "$TEST_DIR" "$TEST_DIR/main.py")"
[[ "$kind" == "application" && "$rule" == "filename:main.py" ]] || {
    echo "[FAIL] main.py rule failed"
    exit 1
}
echo "[PASS] main.py rule"

kind="$(detect_entrypoint_kind "$TEST_DIR" "$TEST_DIR/app.js")"
rule="$(detect_entrypoint_rule "$TEST_DIR" "$TEST_DIR/app.js")"
[[ "$kind" == "application" && "$rule" == "filename:app.js" ]] || {
    echo "[FAIL] app.js rule failed"
    exit 1
}
echo "[PASS] app.js rule"

kind="$(detect_entrypoint_kind "$TEST_DIR" "$TEST_DIR/server.ts")"
rule="$(detect_entrypoint_rule "$TEST_DIR" "$TEST_DIR/server.ts")"
[[ "$kind" == "service" && "$rule" == "filename:server.ts" ]] || {
    echo "[FAIL] server.ts rule failed"
    exit 1
}
echo "[PASS] server.ts rule"

kind="$(detect_entrypoint_kind "$TEST_DIR" "$TEST_DIR/Makefile")"
rule="$(detect_entrypoint_rule "$TEST_DIR" "$TEST_DIR/Makefile")"
[[ "$kind" == "build" && "$rule" == "filename:Makefile" ]] || {
    echo "[FAIL] Makefile rule failed"
    exit 1
}
echo "[PASS] Makefile rule"

kind="$(detect_entrypoint_kind "$TEST_DIR" "$TEST_DIR/docker-compose.yml")"
rule="$(detect_entrypoint_rule "$TEST_DIR" "$TEST_DIR/docker-compose.yml")"
[[ "$kind" == "runtime" && "$rule" == "filename:docker-compose.yml" ]] || {
    echo "[FAIL] docker-compose rule failed"
    exit 1
}
echo "[PASS] docker-compose rule"

kind="$(detect_entrypoint_kind "$TEST_DIR" "$TEST_DIR/root_script.sh")"
rule="$(detect_entrypoint_rule "$TEST_DIR" "$TEST_DIR/root_script.sh")"
[[ "$kind" == "script" && "$rule" == "root-shebang:sh" ]] || {
    echo "[FAIL] root shebang rule failed"
    exit 1
}
echo "[PASS] root shebang rule"

if is_entrypoint "$TEST_DIR" "$TEST_DIR/notes.txt"; then
    echo "[FAIL] notes.txt should not be an entrypoint"
    exit 1
fi
echo "[PASS] non-entrypoint rejected"

OUTPUT_FILE="$TEST_DIR/ENTRYPOINTS.tsv"
generate_entrypoints "$TEST_DIR" > "$OUTPUT_FILE"

if ! grep -Fq $'ENTRYPOINT\t'"$TEST_DIR"$'/bin/tool\tcli\tpath:bin' "$OUTPUT_FILE"; then
    echo "[FAIL] missing bin entrypoint in output"
    exit 1
fi
echo "[PASS] output contains bin entrypoint"

if ! grep -Fq $'ENTRYPOINT\t'"$TEST_DIR"$'/main.py\tapplication\tfilename:main.py' "$OUTPUT_FILE"; then
    echo "[FAIL] missing main.py entrypoint in output"
    exit 1
fi
echo "[PASS] output contains main.py entrypoint"

if ! grep -Fq $'ENTRYPOINT\t'"$TEST_DIR"$'/Makefile\tbuild\tfilename:Makefile' "$OUTPUT_FILE"; then
    echo "[FAIL] missing Makefile entrypoint in output"
    exit 1
fi
echo "[PASS] output contains Makefile entrypoint"

if ! grep -Fq $'ENTRYPOINT\t'"$TEST_DIR"$'/root_script.sh\tscript\troot-shebang:sh' "$OUTPUT_FILE"; then
    echo "[FAIL] missing root shebang entrypoint in output"
    exit 1
fi
echo "[PASS] output contains root shebang entrypoint"

if grep -Fq 'notes.txt' "$OUTPUT_FILE"; then
    echo "[FAIL] non-entrypoint leaked into output"
    exit 1
fi
echo "[PASS] output excludes non-entrypoints"

echo "[SUCCESS] Entrypoint tests completed"
