# Changelog

All notable changes to this project will be documented in this file.

The format loosely follows Keep a Changelog principles.

---

# v0.2.1 (unreleased)

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

## Internal

- Added `core/semantics.sh`
- Integrated semantic mapping into snapshot pipeline
- Added `tests/test_semantics.sh`
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
