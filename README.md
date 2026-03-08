# codebase-snapshot

A shell-first, deterministic, and portable utility that transforms any software project into a structured snapshot, versioned and immediately understandable by both humans and AI systems.

---

## Vision

`codebase-snapshot` is designed to accelerate project understanding.

It produces a structured bundle that helps both a human reader and an AI system answer essential questions:

- what is this project
- how is it organized
- what are the important files
- what should be ignored
- where to start reading
- how to transfer project context cleanly

The project is intentionally:

- shell-first
- deterministic
- portable
- modular
- lightweight
- reusable across repositories
- open-source friendly

---

## Product Goals

The tool should allow a user to:

1. install `codebase-snapshot`
2. configure a target project
3. run the snapshot command
4. generate a structured snapshot directory
5. obtain a readable and shareable bundle

Target snapshot outputs include:

- `AI_INGESTION_GUIDE.md`
- `MANIFEST.md`
- `ARCHITECTURE.md`
- `INDEX.tsv`
- `DOCUMENTATION.md`
- `CODEBASE/`
- `PROJECT_TREE.txt`
- `LOG.txt`
- `SNAPSHOT_META.json`

---

## Core Principles

### 1. Determinism first

The same input state should produce the same snapshot structure.

This requires:

- deterministic file traversal
- stable sorting
- explicit exclusions
- normalized naming
- predictable output layout

### 2. Shell-first architecture

The project should remain easy to run in standard Unix-like environments.

This implies:

- no heavy dependencies
- transparent execution
- portable shell scripts
- simple install and reuse model

### 3. CLI orchestration-only

The CLI must stay thin.

Its role is to:

- parse arguments
- validate inputs
- load configuration
- dispatch to core modules
- report explicit status

Business logic belongs in `core/`.

### 4. Modular core

Core functions should remain:

- reusable
- testable
- replaceable
- isolated by responsibility

### 5. Tests as contract

Stable behavior must be protected by tests.

This includes:

- naming rules
- file ordering
- snapshot structure
- exclusion behavior
- CLI exit behavior
- metadata integrity

---

## Repository Structure

README.md
LICENSE
VERSION
.gitignore
CODEBASE_ROOT.md
bin/
core/
doc/
examples/
tests/
logs/
snapshots/
Current Core Layout
bin/snapshot

core/
  classifier.sh
  config.sh
  indexer.sh
  logger.sh
  naming.sh
  renderer.sh
  scanner.sh
  utils.sh

This confirms the current implementation direction:

- CLI entrypoint in bin/
- functional modules in core/
- tests isolated under tests/
- generated runtime outputs separated in logs/ and snapshots/

---

## Documentation

- doc/GET_STARTED.md
- doc/ARCHITECTURE.md
- doc/SNAPSHOT_FORMAT.md
- doc/CLI.md
- doc/ROADMAP.md

---

## Development Method

This project is developed:

- step by step
- with complete code
- with explicit paths
- with precise commands
- with documentation updated continuously
- with tests added at each meaningful stage

---

## Status

Current version:
0.1.0

Current objective:

- finalize foundation
- stabilize the first CLI contract
- produce the first reliable snapshot flow
- harden deterministic behavior

---

##Long-Term Direction

codebase-snapshot is not tied to KaoBox or any single repository.

It is intended to become a reusable open-source utility for:

- project onboarding
- AI-assisted development
- architecture audits
- repository transfer
- machine-ingestible project packaging
- documentation support
- clean snapshot versioning
