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

ARCHITECTURE.md  
DOCUMENTATION.md  
LANGUAGES.md  
AI_INGESTION_GUIDE.md  

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

Goal: move from file graph to component graph, then toward repository-level interpretation.

---

## Phase 4.0 — Semantic Component Detection

Delivered:

- deterministic component detection
- repository boundary grouping
- explicit file-to-component mapping
- readable component summary

Artifacts added:

SEMANTICS.tsv  
COMPONENTS.md  

Detected components:

cli  
core  
tests  
docs  
examples  
tools  
config  
root  
unknown  

Status: COMPLETE

---

## Phase 4.1 — Entrypoint Detection

Delivered:

- deterministic repository entrypoint detection
- CLI and application entrypoint identification
- runtime script discovery
- orchestration file detection

Artifact:

ENTRYPOINTS.tsv

Purpose:

Identify where execution begins inside a repository.

Status: COMPLETE

---

## Phase 4.2 — Repository Purpose Inference

Delivered:

- deterministic repository purpose summary
- repository type classification
- operational role interpretation
- execution profile summary
- rule-based repository signal analysis

Artifact:

PURPOSE.md

Purpose:

Explain what a repository is for using deterministic structural signals.

Status: COMPLETE

---

## Phase 4.3 — Component Grouping Refinement

Delivered:

- deterministic semantic grouping
- component → group hierarchy
- role classification
- rule-based semantic detection improvements

Artifacts:

SEMANTICS.tsv  
COMPONENTS.md  

Status: COMPLETE

---

## Phase 4.4 — Repository Structural Modeling

Goal: model the architectural topology of the repository.

---

### Increment 1 — MODULES Layer

Capabilities:

- deterministic repository module modeling
- stable architectural zones detection
- repository-level architecture interpretation

Artifact:

MODULES.tsv

Status: COMPLETE

---

### Increment 2 — SUBSYSTEMS Layer

Capabilities:

- deterministic subsystem modeling inside modules
- stable functional subsystem mapping
- deeper architectural interpretation for AI systems

Artifact:

SUBSYSTEMS.tsv

Status: COMPLETE

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
