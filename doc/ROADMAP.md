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

Artifact:

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
- deterministic repository explanation access through the CLI
- deterministic artifact convergence for human and AI use

Artifacts exposed through the CLI:

PURPOSE.md
SYSTEM_FLOW.md
REPOSITORY_DNA.md
REPOSITORY_EXPLAIN.md

Status: COMPLETE

---

# Phase 5 — Repository Evolution and Operational Intelligence

Goal: extend repository understanding from structure and interpretation
to change tracking, operational diagnostics, risk, and governance signals.

---

## Phase 5.0 — Snapshot History Engine

Capabilities:

- deterministic archived snapshot storage
- historical snapshot indexing
- snapshot archive retrieval foundation

Artifacts:

SNAPSHOT_HISTORY.tsv

Status: COMPLETE

---

## Phase 5.1 — Repository Timeline Engine

Capabilities:

- deterministic repository timeline rendering
- chronological snapshot interpretation
- history-to-report projection

Artifacts:

REPOSITORY_TIMELINE.md

Status: COMPLETE

---

## Phase 5.2 — Evolution Signals Engine

Capabilities:

- deterministic repository evolution signal generation
- machine-readable change interpretation between snapshots
- stable signal ordering across archived history

Artifacts:

EVOLUTION_SIGNALS.tsv

Status: COMPLETE

---

## Phase 5.3 — Repository Health Signals

Capabilities:

- deterministic repository health interpretation
- archived history evidence synthesis
- repository growth and stability reporting

Artifacts:

REPOSITORY_HEALTH.md

Status: COMPLETE

---

## Phase 5.4 — Repository Risk Signals

Capabilities:

- deterministic repository risk signaling
- archived snapshot sensitivity interpretation
- dependency gravity and entrypoint criticality analysis

Artifacts:

REPOSITORY_RISKS.md

Status: COMPLETE

---

## Phase 5.5 — Repository Lint Signals

Capabilities:

- deterministic repository lint signaling
- structural repository quality diagnostics
- artifact consistency verification

Artifacts:

REPOSITORY_LINT.md

Status: COMPLETE

---

## Phase 5.6 — Repository Policy Signals

Goal: interpret repository-visible governance and policy evidence.

Capabilities:

- deterministic repository policy signaling
- repository-visible governance evidence synthesis
- release discipline interpretation from explicit repository evidence
- testing and documentation governance interpretation
- non-speculative policy reporting

Artifacts:

REPOSITORY_POLICY.md

Evidence scope:

- license presence
- changelog presence
- contribution guidance presence
- development protocol presence
- roadmap presence
- testing governance evidence
- release discipline evidence
- documentation governance evidence

CLI surface:

bin/snapshot policy

Status: COMPLETE

---

# Phase 6 — Future Repository Intelligence Expansion

Goal: extend repository intelligence beyond current deterministic operational layers.

Candidate directions:

- repository scorecards
- repository governance trend analysis
- cross-snapshot policy drift detection
- repository explain compression layers
- richer machine-readable operational exports
- repository intelligence dashboards

Status: PLANNED
