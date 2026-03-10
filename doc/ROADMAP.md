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

## Phase 4.7 — CLI Integration Convergence

Goal: converge semantic and interpretation engines into the main CLI surface.

Capabilities:

- deterministic CLI orchestration alignment
- integrated repository interpretation commands
- stronger end-to-end execution contract

Status: COMPLETE

---

## Phase 4.8 — Repository DNA

Goal: derive a compact deterministic identity layer for the repository.

Capabilities:

- deterministic repository identity synthesis
- project type inference
- architecture style summarization
- compact repository profile rendering

Artifact:

REPOSITORY_DNA.md

Status: COMPLETE

---

## Phase 4.9 — Repository Diff Intelligence

Goal: compare snapshots deterministically and expose repository evolution.

Capabilities:

- deterministic snapshot comparison
- machine-readable change artifact
- human-readable diff summary

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

- snapshot archive storage
- deterministic snapshot ID generation
- history index maintenance
- archived snapshot lookup

Artifacts:

SNAPSHOT_HISTORY.tsv
.snapshots/

Status: COMPLETE

---

## Phase 5.1 — Repository Timeline

Goal: render archived history into a deterministic chronological timeline.

Capabilities:

- chronological snapshot rendering
- archived metadata reading
- stable historical timeline summary

Artifact:

REPOSITORY_TIMELINE.md

Status: COMPLETE

---

## Phase 5.2 — Evolution Signals Engine

Goal: expose deterministic machine-readable repository evolution signals.

Capabilities:

- consecutive snapshot comparison
- file count evolution signals
- tool version change detection
- snapshot label change detection
- stable signal ordering

Artifact:

EVOLUTION_SIGNALS.tsv

Status: COMPLETE

---

## Phase 5.3 — Repository Health Signals

Goal: transform evolution signals into a deterministic human-readable repository health interpretation.

Capabilities:

- deterministic repository health signal synthesis
- health interpretation from archived history and evolution signals
- stable evidence rendering
- deterministic health summary generation

Artifact:

REPOSITORY_HEALTH.md

Signals:

REPOSITORY_GROWING
REPOSITORY_STABLE
CHANGE_ACTIVITY_LOW
CHANGE_ACTIVITY_MODERATE
TOOL_VERSION_PROGRESSING
SNAPSHOT_LABELS_EVOLVING

Status: COMPLETE

---

# Strategic Direction

The project now forms a deterministic repository intelligence pipeline:

- scan
- index
- dependencies
- graph
- semantics
- entrypoints
- modules
- subsystems
- architecture
- purpose
- system flow
- repository DNA
- repository explain
- diff
- history
- timeline
- evolution
- health

Long-term direction:

- repository risk signals
- repository quality signals
- repository drift detection
- repository intelligence scoring
- AI-native repository ingestion workflows
