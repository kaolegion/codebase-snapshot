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
structure.sh
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
→ topology-driven architecture rendering

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

structure.sh
→ repository structural modeling (modules and subsystems)

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

## Structural Modeling Layer

Phase 4.4 introduces deterministic **repository topology modeling**.

This layer describes the architectural organization of the repository itself.

Artifacts:

MODULES.tsv
→ maps the repository to its main architectural modules

SUBSYSTEMS.tsv
→ maps stable functional subsystems inside those modules

Purpose:

Allow AI systems to understand the repository architecture without reading the entire codebase.

Example topology:

repository
→ modules
→ subsystems
→ files

This structural modeling layer builds on top of the semantic layer and provides a higher-level architectural interpretation of the repository.

The modeling logic is implemented in:

core/structure.sh

---

## Structural Rendering Layer

Phase 4.5 introduces deterministic **topology-driven architecture rendering**.

This layer transforms repository topology into a human-readable architecture report.

Input artifacts:

MODULES.tsv
SUBSYSTEMS.tsv

Output artifact:

ARCHITECTURE.md

Rendering behavior:

- module sections are rendered deterministically
- subsystems are grouped under their parent module
- architecture text is derived from structural records
- manual repository-specific architecture prose is avoided

Purpose:

Allow both humans and AI systems to read a stable architectural view
without manually reconstructing topology from raw TSV files.

The rendering logic is implemented in:

core/architecture.sh

This layer is deterministic and rule-based.

No manual interpretation is injected into generated repository architecture summaries.

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

This layer produces human-readable support artifacts for repository exploration.

Artifacts include:

DOCUMENTATION.md
LANGUAGES.md
COMPONENTS.md
ARCHITECTURE.md
MANIFEST.md
AI_INGESTION_GUIDE.md

These outputs are designed to help humans and AI systems
consume repository knowledge in a stable reading order.

---

# Snapshot Interpretation Flow

The repository interpretation flow now follows these layers:

1. file discovery
2. structural relationships
3. semantic mapping
4. topology modeling
5. topology-driven rendering
6. purpose-oriented interpretation

This progression moves **codebase-snapshot** toward a full repository intelligence engine.

---

# Design Constraint

Generated architecture summaries must remain:

- deterministic
- topology-derived
- reproducible
- repository-agnostic in rendering style

`ARCHITECTURE.md` must be generated from stable structural artifacts rather than handwritten repository descriptions.

---

# Summary

**codebase-snapshot** now combines:

- deterministic file discovery
- dependency and graph extraction
- semantic repository interpretation
- topology modeling
- topology-driven architecture rendering
- purpose inference

This architecture allows the tool to explain software repositories
as structured systems rather than only listing files.
