# codebase-snapshot

Deterministic shell-first tool that converts any software repository into an **AI-ready structured snapshot**.

The goal is to allow humans and AI systems to **quickly understand a codebase** without navigating the entire repository.

It helps explain:

- what is in the repository
- what it is for

---

# Project Status

Version: **0.2.1**

Current state:

- snapshot engine operational
- deterministic repository scanning
- AI-oriented snapshot artifacts
- modular shell architecture
- repository graph generation
- repository semantic component detection
- automated tests passing

---

# Vision

Modern development increasingly involves AI agents.

However, most repositories are **not structured for AI ingestion**.

`codebase-snapshot` solves this by generating a **clean, deterministic bundle** describing a repository.

The snapshot is:

- deterministic
- structured
- AI-readable
- portable
- versioned

Benefits:

- time savings
- better AI understanding
- higher production
- reduced context cost

---

# Snapshot Output

Each snapshot produces:

PROJECT_TREE.txt
INDEX.tsv
DEPENDENCIES.tsv
GRAPH.tsv
SEMANTICS.tsv
MANIFEST.md
AI_INGESTION_GUIDE.md
ARCHITECTURE.md
DOCUMENTATION.md
LANGUAGES.md
COMPONENTS.md
LOG.txt
SNAPSHOT_META.json

CODEBASE/

Structure:

CODEBASE/
  01_cli.md
  02_core.md
  03_tests.md
  04_docs.md

---

# Repository Semantics

Phase 4 introduces a repository semantics layer.

The tool now detects repository-level components such as:

- CLI
- core modules
- tests
- documentation
- examples
- tools
- config
- root files

New semantic artifacts:

- `SEMANTICS.tsv`  
  file-to-component mapping with detection rules

- `COMPONENTS.md`  
  readable summary of detected repository components

This moves the project from a pure **file graph** approach toward a **component graph** approach.

---

# Architecture

The project follows strict principles:

- shell-first
- deterministic processing
- CLI orchestration-only
- modular core modules
- explicit snapshot artifacts
- tests as contract

Core modules:

core/
  naming.sh
  scanner.sh
  indexer.sh
  classifier.sh
  architecture.sh
  documentation.sh
  languages.sh
  dependencies.sh
  graph.sh
  semantics.sh
  renderer.sh
  logger.sh
  utils.sh
  config.sh

---

# Usage

Basic usage:

bin/snapshot --target <repository> --label <snapshot_label>

Example:

bin/snapshot --target /opt/project --label initial_analysis

Snapshots are written to:

snapshots/YYYY-MM-DD/vX.Y.Z/<sequence>_<label>/

---

# Exclusion Engine

Ignored paths:

.git
node_modules
dist
build
__pycache__
logs
snapshots

---

# Testing

Test suite:

tests/
  run_all.sh
  test_naming.sh
  test_indexer.sh
  test_dependencies.sh
  test_graph.sh
  test_semantics.sh
  test_cli.sh

Run tests:

tests/run_all.sh

---

# Roadmap

Current milestone:

Phase 4 — Repository Semantics

Current focus:

- component grouping
- module boundaries
- repository semantics
- AI-oriented repository understanding

See:

doc/ROADMAP.md

---

# License

MIT
