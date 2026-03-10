# Development Protocol

This document defines the official KaoBox surgical development workflow used for this repository.

---

# KaoBox Surgical Heredoc V1

Principles:

- one box = one intention
- inspect before modify
- deterministic injection only
- absolute paths only
- chmod immediately after executable creation
- verification separated from injection
- targeted tests before full suite
- release only after clean working tree
- push after release
- post-push validation before next sprint

---

# Context Anchor Rules

## Chat Context Anchor

The sprint title must always be the first line of the sprint bootstrap prompt.

## Terminal Context Anchor

Every command block must begin with:

echo "===== KaoBox Project Anchor ====="
cd /opt/kaobox/codebase-snapshot || exit 1
pwd
echo "================================="

---

# Safety Rules

## Stop-on-drift

If there is any doubt about current file state, re-inspect immediately before modification.

## One-risk-at-a-time

Each micro-step should modify only one main risk domain:

- engine
- CLI
- tests
- documentation
- release

---

# Official Command Boxes

- Inspection
- Injection
- Verification
- Targeted tests
- Documentation convergence
- Final test suite
- Release
- Post-push validation

---

# End-of-Sprint Rule

After push, the sprint must be validated again through:

- full test suite
- touched documentation check
- git status
- repository status

Only after post-push validation succeeds may the next sprint be drafted.

The next sprint title must always appear first.
