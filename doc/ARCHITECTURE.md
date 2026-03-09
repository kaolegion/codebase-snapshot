# ARCHITECTURE

This document describes the architecture of **codebase-snapshot**.

The project follows a **shell-first modular architecture** designed for determinism, portability, and clarity.

---

# Architectural Principles

The system is designed around four principles:

1. determinism
2. modularity
3. CLI orchestration
4. explicit outputs

If the same repository state is processed twice, the generated snapshot must remain identical.

---

# System Layers

The project is organized into several logical layers.

---

## CLI Layer

Location:

bin/

Purpose:

The CLI is responsible for:

- parsing arguments
- validating inputs
- loading configuration
- dispatching execution to core modules
- producing logs
- assembling snapshot artifacts

The CLI must remain **thin**.

Business logic must never live in the CLI.

---

## Core Layer

Location:

core/

The core layer contains reusable modules implementing the snapshot logic.

Current modules include:

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
purpose.sh
renderer.sh
scanner.sh
semantics.sh
utils.sh

Each module must remain:

- deterministic
- reusable
- testable
- isolated in responsibility

Example responsibilities:

scanner.sh
→ deterministic file discovery with exclusions

indexer.sh
→ generation of INDEX.tsv

classifier.sh
→ file categorization

architecture.sh
→ repository architecture summary

documentation.sh
→ extraction of documentation metadata

languages.sh
→ language and file type detection

dependencies.sh
→ dependency signal extraction

graph.sh
→ structural relationship mapping

semantics.sh
→ repository component detection and semantic grouping

entrypoints.sh
→ deterministic repository entrypoint detection

purpose.sh
→ deterministic repository purpose inference

renderer.sh
→ snapshot artifact generation

naming.sh
→ snapshot naming normalization

config.sh
→ environment and configuration handling

utils.sh
→ shared helpers

logger.sh
→ structured logging

---

## Semantic Layer

Phase 4 introduces a semantic interpretation layer on top of file discovery.

This layer moves the system from:

- file listing
- structural graphing

toward:

- repository component detection
- module boundary identification
- component-oriented AI interpretation

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

Semantic outputs:

SEMANTICS.tsv
→ file-to-component mapping with explicit detection rules

COMPONENTS.md
→ human-readable component summary

This layer is deterministic and rule-based.

No probabilistic inference is used.

---

## Entrypoint Detection Layer

Phase 4.1 introduces deterministic repository entrypoint detection.

This layer identifies **where execution begins in a repository**.

Entrypoints are detected using deterministic rules such as:

- `bin/*` and `cmd/*`
- common application files (`main.*`, `app.*`)
- service entry files (`server.*`)
- root shell scripts with shebang
- orchestration files (`docker-compose.yml`, `Makefile`)

Output artifact:

ENTRYPOINTS.tsv

---

## Purpose Inference Layer

Phase 4.2 introduces deterministic repository purpose inference.

This layer identifies **what a repository is for** using structural repository signals.

The inference engine evaluates signals such as:

- command surface presence
- application or service entry files
- documentation density
- test density
- configuration density
- repository structure patterns

Output artifact:

PURPOSE.md

This layer is deterministic and rule-based.

No probabilistic inference is used.

---

## Documentation Layer

Location:

doc/

The documentation defines the **behavioral contract** of the system.

Important documents include:

GET_STARTED.md
ARCHITECTURE.md
SNAPSHOT_FORMAT.md
CLI.md
ROADMAP.md
TODO.md

Implementation should converge toward these specifications.

---

## Test Layer

Location:

tests/

Tests ensure that the system remains deterministic and stable.

They validate:

- naming rules
- indexing behavior
- dependency extraction
- graph generation
- semantic component detection
- entrypoint detection
- purpose inference
- CLI behavior
- deterministic ordering

Tests act as a **contract protecting expected behavior**.

---

## Runtime Outputs

Location:

logs/
snapshots/

These directories contain generated runtime artifacts.

They must remain separate from implementation code.

---

# Execution Flow

A typical snapshot execution follows these steps:

1. read tool version
2. validate target repository
3. normalize snapshot label
4. compute snapshot output path
5. scan repository deterministically
6. generate PROJECT_TREE.txt
7. generate INDEX.tsv
8. generate DEPENDENCIES.tsv
9. generate GRAPH.tsv
10. generate SEMANTICS.tsv
11. generate ENTRYPOINTS.tsv
12. generate PURPOSE.md
13. generate human-readable summaries
14. generate metadata and ingestion guidance
15. export grouped CODEBASE files
