# codebase-snapshot

Deterministic shell-first tool that converts any software repository into an **AI-ready structured snapshot**.

The goal is to allow humans and AI systems to **quickly understand a codebase** without navigating the entire repository.

It helps explain:

- what is in the repository
- what it is for
- how it is structured
- where execution begins

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
- deterministic repository entrypoint detection
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

- faster repository comprehension
- better AI context quality
- reduced context token cost
- improved developer onboarding

---

# Snapshot Output

Each snapshot produces a structured bundle describing the repository.

Artifacts generated:

PROJECT_TREE.txt  
INDEX.tsv  
DEPENDENCIES.tsv  
GRAPH.tsv  
SEMANTICS.tsv  
ENTRYPOINTS.tsv  
MANIFEST.md  
AI_INGESTION_GUIDE.md  
ARCHITECTURE.md  
DOCUMENTATION.md  
LANGUAGES.md  
COMPONENTS.md  
LOG.txt  
SNAPSHOT_META.json  

CODEBASE/

CODEBASE structure:

CODEBASE/
  01_cli.md
  02_core.md
  03_tests.md
  04_docs.md

---

# Repository Semantics

Phase 4 introduces a repository semantics layer.

The tool detects repository-level components such as:

- CLI
- core modules
- tests
- documentation
- examples
- tools
- config
- root files

Semantic artifacts:

SEMANTICS.tsv  
File-to-component mapping with deterministic detection rules.

COMPONENTS.md  
Human-readable overview of detected repository components.

This moves the system from a **file graph** toward a **component graph** representation.

---

# Entrypoint Detection

Phase 4.1 introduces deterministic repository entrypoint detection.

The tool now generates:

ENTRYPOINTS.tsv

Entrypoints are detected using deterministic rules:

- `bin/*` and `cmd/*` directories
- common application files (`main.*`, `app.*`)
- service entrypoints (`server.*`)
- root shell scripts with shebang
- runtime or orchestration files (`docker-compose.yml`, `Makefile`)

This allows the snapshot to identify **where execution begins inside a repository**.

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

architecture.sh  
classifier.sh  
config.sh  
dependencies.sh  
documentation.sh  
entrypoints.sh  
graph.sh  
indexer.sh  
languages.sh  
logger.sh  
naming.sh  
renderer.sh  
scanner.sh  
semantics.sh  
utils.sh  

---

# CLI Usage

Basic usage:

bin/snapshot --target <repository> --label <snapshot_label>

Example:

bin/snapshot --target /opt/project --label initial_analysis

Snapshots are written to:

snapshots/YYYY-MM-DD/vX.Y.Z/<sequence>_<label>/

---

# Exclusion Engine

Ignored paths during repository scanning:

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
test_entrypoints.sh  
test_cli.sh  

Run tests:

tests/run_all.sh

---

# Roadmap

Current milestone:

Phase 4.1 — Entrypoint Detection

Current focus:

- repository component boundaries
- semantic repository understanding
- deterministic entrypoint detection
- AI-oriented repository explainability

See:

doc/ROADMAP.md

---

# License

MIT
