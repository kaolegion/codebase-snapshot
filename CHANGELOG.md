# Changelog

All notable changes to this project will be documented in this file.

The format loosely follows Keep a Changelog principles.

---

# v0.2.2

## Added

### Repository Purpose Inference (Phase 4.2)

A new deterministic repository interpretation layer has been introduced.

New artifact:

PURPOSE.md

This artifact summarizes the **probable operational role of the repository** using deterministic structural signals.

The purpose inference system analyzes repository structure to identify:

- repository classification
- operational role
- execution profile
- structural signals supporting the classification

This allows the snapshot to explicitly answer:

"What is this repository for?"

The inference system is rule-based and deterministic.

No probabilistic inference is used.

---

## Implementation

New module:

core/purpose.sh

Capabilities:

- repository classification
- structural signal detection
- repository role interpretation
- execution profile summarization

---

## Tests

Added:

tests/test_purpose.sh

Extended:

tests/test_cli.sh
tests/run_all.sh

Tests now validate:

- PURPOSE.md generation
- repository classification section
- purpose summary structure
- AI ingestion guide ordering
- purpose generation log markers

---

# v0.2.1

## Added

### Repository Semantics (Phase 4.0)

A new semantic component detection layer has been introduced.

New artifacts:

SEMANTICS.tsv  
COMPONENTS.md

These artifacts move the project from a file graph model toward a component graph model.

SEMANTICS.tsv provides deterministic file-to-component mapping with explicit detection rules.

COMPONENTS.md provides a readable summary of detected repository components.

Detected component families currently include:

- cli
- core
- tests
- docs
- examples
- tools
- config
- root
- unknown

Purpose:

Enable AI systems to better understand repository composition,
component boundaries, and repository-level structure.

---

### Entrypoint Detection (Phase 4.1)

Deterministic repository entrypoint detection has been introduced.

New artifact:

ENTRYPOINTS.tsv

Entrypoints are detected using explicit deterministic rules such as:

- `bin/*` and `cmd/*` directories
- common application entry files (`main.*`, `app.*`)
- service entry files (`server.*`)
- root-level shell scripts with shebang
- orchestration files (`docker-compose.yml`, `Makefile`)

This allows snapshots to identify where execution begins inside a repository.

---

## Internal

- Added `core/semantics.sh`
- Added `core/entrypoints.sh`
- Integrated semantic mapping into snapshot pipeline
- Added `tests/test_semantics.sh`
- Added `tests/test_entrypoints.sh`
- Extended `tests/test_cli.sh`
- Extended `tests/run_all.sh`
- Updated AI ingestion guide generation
- Updated README, architecture, roadmap, and TODO documentation

---

# v0.2.0

Snapshot intelligence foundation.

Features introduced:

- architecture analysis
- documentation indexing
- language detection
- dependency extraction

Artifacts added:

ARCHITECTURE.md  
DOCUMENTATION.md  
LANGUAGES.md  
DEPENDENCIES.tsv

---

# v0.1.0

Initial working snapshot engine.

Core capabilities:

- repository scanning
- exclusion rules
- deterministic snapshot generation
- file indexing
- codebase export
