#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$ROOT_DIR/core/policy.sh"

TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

TEST_REPO="$TMP_DIR/repo"
mkdir -p "$TEST_REPO/doc" "$TEST_REPO/tests" "$TEST_REPO/.git"

cat > "$TEST_REPO/LICENSE" <<'EOF_LICENSE'
MIT License
EOF_LICENSE

cat > "$TEST_REPO/CHANGELOG.md" <<'EOF_CHANGELOG'
# Changelog

## v9.9.1

- policy improvements

## v9.9.0

- initial release
EOF_CHANGELOG

cat > "$TEST_REPO/README.md" <<'EOF_README'
# Test Repository

Version: **v9.9.1**
EOF_README

cat > "$TEST_REPO/VERSION" <<'EOF_VERSION'
v9.9.1
EOF_VERSION

cat > "$TEST_REPO/doc/ROADMAP.md" <<'EOF_ROADMAP'
# Roadmap
EOF_ROADMAP

cat > "$TEST_REPO/doc/DEVELOPMENT_PROTOCOL.md" <<'EOF_PROTOCOL'
# Development Protocol
EOF_PROTOCOL

cat > "$TEST_REPO/tests/run_all.sh" <<'EOF_RUN_ALL'
#!/usr/bin/env bash
set -euo pipefail
EOF_RUN_ALL

cat > "$TEST_REPO/tests/test_alpha.sh" <<'EOF_TEST_ALPHA'
#!/usr/bin/env bash
set -euo pipefail
EOF_TEST_ALPHA

chmod +x \
  "$TEST_REPO/tests/run_all.sh" \
  "$TEST_REPO/tests/test_alpha.sh"

ROOT_DIR="$TEST_REPO"

write_repository_policy > /dev/null

if [[ ! -f "$TEST_REPO/REPOSITORY_POLICY.md" ]]; then
    echo "[FAIL] REPOSITORY_POLICY.md was not generated"
    exit 1
fi

grep -q '^# Repository Policy' "$TEST_REPO/REPOSITORY_POLICY.md" || {
    echo "[FAIL] missing Repository Policy title"
    exit 1
}

grep -q 'License policy: Present' "$TEST_REPO/REPOSITORY_POLICY.md" || {
    echo "[FAIL] expected License policy signal missing"
    exit 1
}

grep -q 'Changelog policy: Present' "$TEST_REPO/REPOSITORY_POLICY.md" || {
    echo "[FAIL] expected Changelog policy signal missing"
    exit 1
}

grep -q 'Development protocol: Present' "$TEST_REPO/REPOSITORY_POLICY.md" || {
    echo "[FAIL] expected Development protocol signal missing"
    exit 1
}

grep -q 'Roadmap policy: Present' "$TEST_REPO/REPOSITORY_POLICY.md" || {
    echo "[FAIL] expected Roadmap policy signal missing"
    exit 1
}

grep -q 'Release discipline: Partial' "$TEST_REPO/REPOSITORY_POLICY.md" || {
    echo "[FAIL] expected Release discipline partial signal missing"
    exit 1
}

grep -q 'Testing governance: Present' "$TEST_REPO/REPOSITORY_POLICY.md" || {
    echo "[FAIL] expected Testing governance signal missing"
    exit 1
}

grep -q 'Documentation governance: Present' "$TEST_REPO/REPOSITORY_POLICY.md" || {
    echo "[FAIL] expected Documentation governance signal missing"
    exit 1
}

grep -q 'Git tags observed: 0' "$TEST_REPO/REPOSITORY_POLICY.md" || {
    echo "[FAIL] expected Git tag evidence missing"
    exit 1
}

grep -q -- '- LICENSE' "$TEST_REPO/REPOSITORY_POLICY.md" || {
    echo "[FAIL] expected LICENSE evidence missing"
    exit 1
}

grep -q -- '- doc/DEVELOPMENT_PROTOCOL.md' "$TEST_REPO/REPOSITORY_POLICY.md" || {
    echo "[FAIL] expected development protocol evidence missing"
    exit 1
}

grep -q -- '- tests/run_all.sh' "$TEST_REPO/REPOSITORY_POLICY.md" || {
    echo "[FAIL] expected test runner evidence missing"
    exit 1
}

rm -f "$TEST_REPO/REPOSITORY_POLICY.md"

echo "[PASS] repository policy signals generated"
