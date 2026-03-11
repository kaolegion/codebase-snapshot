# Development Protocol

This document defines the official KaoBox surgical development workflow used for this repository.

The goal is to guarantee deterministic implementation, safe human-AI collaboration,
and fast recovery in case of implementation errors.

---

# KaoBox Surgical Heredoc Workflow

This repository follows a strict surgical implementation workflow.

The workflow favors small deterministic steps over large multi-file changes.

---

# Core Principles

- micro-steps only
- inspect before modify
- deterministic file injection only
- absolute paths only
- one file injection at a time
- chmod immediately after executable creation
- verification separated from injection
- targeted tests as early as possible
- fix errors immediately before moving forward
- documentation convergence only after implementation stabilizes
- release only after clean working tree
- push after release
- post-push validation before next sprint

---

# Command Box Sequencing

If several command boxes belong to the same functional sequence:

- the first box uses `clear`
- subsequent boxes must not use `clear`

Purpose:

- preserve continuous terminal logs
- simplify debugging
- allow full success/error trace sharing

---

# Mandatory Per-File Implementation Model

Each implementation step must modify one file only.

Required sequence:

1. announce sprint title
2. list file modified in the current step
3. state objective of the step
4. inspect the current file
5. inject deterministic content
6. run `chmod +x` if executable
7. verify file contents
8. run the most targeted relevant test
9. fix immediately if needed
10. move to the next file only after validation

---

# Context Anchor Rules

## Chat Context Anchor

The sprint title must always be the first line of the sprint bootstrap prompt.

## Terminal Context Anchor

Every command block must begin with the project anchor.

Example:

    clear
    echo "===== KaoBox Project Anchor ====="
    cd /opt/kaobox/codebase-snapshot || exit 1
    pwd
    echo "================================="

If the block is not the first one in the current functional sequence,
the `clear` line must be omitted.

---

# Safety Rules

## Stop-on-drift

If there is any doubt about current file state, re-inspect immediately before modification.

Never assume file contents.

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
- Targeted Test
- Documentation Convergence
- Full Test Suite
- Release
- Post-Push Validation

---

# Documentation Convergence Policy

Documentation updates must happen only after implementation is stable.

When converging documentation:

1. list all documentation files that will be updated
2. inspect each file before modification
3. inject deterministic final content
4. verify rendered content through direct inspection
5. run related validation commands if relevant

---

# Release Policy

A release may happen only when:

- implementation is stable
- targeted tests pass
- full test suite passes
- documentation is converged
- git status is clean enough for release intent

Release sequence:

1. final targeted diff review
2. full test suite
3. git status review
4. commit
5. tag
6. push
7. post-push validation

---

# End-of-Sprint Rule

After push, the sprint must be validated again through:

- full tool execution
- full test suite
- touched documentation inspection
- git status verification
- repository status verification

Only after post-push validation succeeds may the next sprint be drafted.

The next sprint title must always appear first.

---

# Workflow Intent

This protocol exists to prevent:

- accidental overwrites
- hidden assumptions about file contents
- oversized multi-file injections
- delayed error discovery
- difficult rollback situations
- poor human review conditions

The workflow intentionally favors slower but safer deterministic progress.
