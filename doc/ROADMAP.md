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

Capabilities:

- deterministic repository module modeling
- stable architectural zones detection
- repository-level architecture interpretation

Artifacts:

MODULES.tsv
SUBSYSTEMS.tsv

Status: COMPLETE

---

## Phase 4.5 — Structural Rendering Convergence

Goal: render repository topology into a human-readable architecture view.

Capabilities:

- deterministic architecture rendering
- module → subsystem architecture layout
- topology-driven architecture summaries
- architecture generation from structural artifacts

Artifacts:

ARCHITECTURE.md

Input artifacts:

MODULES.tsv
SUBSYSTEMS.tsv

Status: COMPLETE

---

## Phase 4.6 — Repository Explanation Engine

Goal: explain how the repository operates internally.

Capabilities:

- deterministic repository system flow rendering
- execution entrypoint explanation
- internal analysis pipeline explanation
- module interaction summary
- artifact generation flow summary

Artifact:

SYSTEM_FLOW.md

Input artifacts:

ENTRYPOINTS.tsv
MODULES.tsv
SUBSYSTEMS.tsv
GRAPH.tsv

Purpose:

Explain how the repository works internally using deterministic repository signals.

Status: COMPLETE

---

## Phase 4.7 — Repository Explain Engine

Goal: synthesize the full repository into one deterministic high-level explanation layer.

Capabilities:

- deterministic repository-wide explanation rendering
- repository identity synthesis
- purpose synthesis
- execution synthesis
- architecture synthesis
- semantic component synthesis
- generated artifact synthesis

Artifact:

REPOSITORY_EXPLAIN.md

Purpose:

Provide one stable high-level explanation layer for humans and AI systems.

Status: COMPLETE

---

## Phase 4.8 — Repository DNA

Goal: provide a compact deterministic identity signature of the repository.

Capabilities:

- deterministic repository DNA rendering
- hybrid project type detection
- architecture style summary
- language summary
- dependency model summary
- documentation presence summary
- test coverage summary
- repository size summary
- core component listing
- entrypoint listing

Artifact:

REPOSITORY_DNA.md

Purpose:

Provide a compact repository identity layer that complements
PURPOSE.md and REPOSITORY_EXPLAIN.md.

Status: COMPLETE

---

## Phase 4.9 — Repository Diff Intelligence

Goal: compare deterministic snapshots to explain repository evolution over time.

Capabilities:

- deterministic snapshot-to-snapshot comparison
- machine-readable diff generation
- human-readable repository evolution summary
- snapshot-artifact-only diff logic without git

Artifacts:

DIFF.tsv
SNAPSHOT_DIFF.md

Status: COMPLETE

---

# Phase 5 — Repository Evolution Intelligence

Goal: move from isolated snapshot comparison toward persistent repository timeline intelligence.

---

## Phase 5.0 — Snapshot History Engine

Goal: persist snapshots as historical artifacts and expose deterministic snapshot history.

Capabilities:

- deterministic snapshot archive creation
- snapshot history storage initialization
- deterministic snapshot ID generation
- repository-level history index
- CLI history listing
- timeline foundation independent of Git

Artifacts:

SNAPSHOT_HISTORY.tsv
.snapshots/

CLI:

bin/snapshot history

Status: COMPLETE

---

## Phase 5.1 — Repository Timeline

Planned capabilities:

- timeline rendering from archived snapshots
- chronological repository evolution summary
- human-readable repository history report

Planned artifact:

REPOSITORY_TIMELINE.md

Status: PLANNED

---

## Phase 5.2 — Evolution Signals

Planned capabilities:

- growth signals
- dependency expansion signals
- semantic drift signals
- architectural change signals

Planned artifact:

EVOLUTION_SIGNALS.tsv

Status: PLANNED

---

## Phase 5.3 — Repository Health Signals

Planned capabilities:

- repository quality indicators
- documentation and test presence signals over time
- execution and structure stability signals

Planned artifact:

REPOSITORY_HEALTH.md

Status: PLANNED
