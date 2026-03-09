# Codebase Snapshot — Roadmap

This roadmap describes the progressive evolution of **codebase-snapshot**
as a repository intelligence tool designed for AI interpretation.

---

# Phase 1 — Foundation

Goal: build a deterministic repository snapshot engine.

Delivered:

- repository scanner
- exclusion rules
- deterministic file listing
- snapshot directory structure
- CLI interface
- INDEX.tsv generation
- PROJECT_TREE.txt generation
- CODEBASE export

Status: COMPLETE

---

# Phase 2 — Repository Interpretation

Goal: provide semantic signals for understanding repositories.

Delivered:

- architecture analysis
- documentation indexing
- language detection
- AI ingestion guide

Artifacts added:

- ARCHITECTURE.md
- DOCUMENTATION.md
- LANGUAGES.md
- AI_INGESTION_GUIDE.md

Status: COMPLETE

---

# Phase 3 — Repository Intelligence

Goal: expose structural relationships in repositories.

---

## Phase 3.1 — Dependency Mapping

Capabilities:

- dependency extraction from source files
- support for shell, Python, JS, PHP dependency signals
- deterministic dependency output

Artifact:

DEPENDENCIES.tsv

Status: COMPLETE

---

## Phase 3.2 — Structural Graph Engine

Capabilities:

- repository relationship graph
- file role detection
- directory containment mapping
- dependency graph integration
- artifact generation relationships

Artifact:

GRAPH.tsv

Purpose:

Provide a structural relationship map allowing AI systems
to understand repository topology and component roles.

Status: COMPLETE

---

# Phase 4 — Repository Semantics

Goal: move from file graph to component graph.

---

## Phase 4.0 — Semantic Component Detection

Delivered:

- deterministic component detection
- repository boundary grouping
- explicit file-to-component mapping
- readable component summary
- CLI integration of semantic artifacts

Detected components:

- cli
- core
- tests
- docs
- examples
- tools
- config
- root
- unknown

Artifacts added:

- SEMANTICS.tsv
- COMPONENTS.md

Purpose:

Help AI systems understand not only repository files,
but also the major semantic building blocks of the repository.

Status: COMPLETE

---

## Phase 4.1 — Component Grouping Refinement

Potential capabilities:

- stronger grouping conventions
- better root artifact categorization
- repository family heuristics
- richer component summaries

Status: PLANNED

---

## Phase 4.2 — Repository Purpose Inference

Potential capabilities:

- infer repository intent
- infer project type
- infer operational role of the codebase
- AI-oriented repository purpose summary

Status: PLANNED

---

# Phase 5 — AI Context Optimization

Potential capabilities:

- token-aware compression
- intelligent code chunking
- semantic prioritization
- ingestion profiles

Status: PLANNED

---

# Phase 6 — Visualization Layer

Potential capabilities:

- graph export
- architecture visualization
- repository exploration tools
- component graph rendering

Status: PLANNED

---

# Long-Term Vision

codebase-snapshot aims to become a **repository intelligence engine**
that explains:

- what is in a codebase
- what it is for
- how its components are organized
- how AI systems should ingest it
