# Codebase Snapshot — Vision

This document captures the long-term strategic vision of the project.

The goal is to preserve ideas and directions without prematurely
complicating the core implementation.

The project evolves step-by-step through deterministic releases,
while keeping a clear long-term direction.

---

# Core Philosophy

codebase-snapshot converts repositories into **structured knowledge**.

The tool answers fundamental questions about a codebase:

- What is in the repository?
- What is it for?
- How does it work internally?
- Where does execution begin?
- How does it evolve over time?

This benefits both:

- humans exploring unfamiliar repositories
- AI systems that require structured context

The long-term objective is to evolve the project into a **repository intelligence engine**
capable of explaining software systems in a deterministic and reproducible way.

---

# Repository Intelligence

codebase-snapshot aims to transform a repository from raw source code into
a structured knowledge model.

Conceptually:

Repository
→ structural signals
→ semantic signals
→ architectural interpretation
→ execution model
→ repository explanation
→ repository evolution memory

The result is a **deterministic understanding layer** for software repositories.

This approach allows both humans and AI systems to understand complex projects
without reading the entire source tree.

---

# Intelligence Layers

The repository intelligence model evolves across multiple layers.

## 1. Structural Intelligence

Describes the raw structure of the repository.

Artifacts:

PROJECT_TREE.txt
INDEX.tsv
DEPENDENCIES.tsv
GRAPH.tsv

Purpose:

Provide a deterministic structural map of the repository.

---

## 2. Semantic Intelligence

Describes the roles of repository files.

Artifacts:

SEMANTICS.tsv
COMPONENTS.md
ENTRYPOINTS.tsv

Purpose:

Identify repository components, roles, and execution entrypoints.

---

## 3. Architectural Intelligence

Describes the architecture of the repository.

Artifacts:

MODULES.tsv
SUBSYSTEMS.tsv
ARCHITECTURE.md

Purpose:

Interpret the repository as a structured software system.

---

## 4. Cognitive Intelligence

Explains the meaning and operation of the repository.

Artifacts:

PURPOSE.md
SYSTEM_FLOW.md
REPOSITORY_EXPLAIN.md
REPOSITORY_DNA.md

Purpose:

Provide deterministic explanations answering:

- what the repository is
- what it is designed to do
- how it operates internally
- how its architecture is organized
- what compact identity signals define it

This layer enables rapid understanding of unfamiliar repositories.

---

## 5. Temporal Intelligence

Explains repository change and continuity across snapshots.

Artifacts:

DIFF.tsv
SNAPSHOT_DIFF.md
SNAPSHOT_HISTORY.tsv
.snapshots/

Purpose:

Provide deterministic repository memory through:

- snapshot-to-snapshot comparison
- archived historical snapshots
- persistent repository timeline foundations

This layer is the first step toward timeline-aware repository intelligence.

---

# Human Onboarding

One of the primary goals of codebase-snapshot is to reduce the friction
of joining an unfamiliar repository.

Instead of manually exploring the project structure,
a developer should be able to read a small set of artifacts
to understand the system.

Recommended onboarding reading order:

1. MANIFEST.md
2. REPOSITORY_EXPLAIN.md
3. PURPOSE.md
4. ARCHITECTURE.md
5. REPOSITORY_DNA.md
6. MODULES.tsv
7. SUBSYSTEMS.tsv
8. COMPONENTS.md

This allows a developer to understand a repository in minutes instead of hours.

---

# AI Ingestion Protocol

AI systems require structured context before reading raw source code.

codebase-snapshot provides deterministic artifacts designed to support AI ingestion.

Recommended AI ingestion order:

1. MANIFEST.md
2. REPOSITORY_EXPLAIN.md
3. PURPOSE.md
4. SYSTEM_FLOW.md
5. REPOSITORY_DNA.md
6. SEMANTICS.tsv
7. MODULES.tsv
8. SUBSYSTEMS.tsv
9. GRAPH.tsv
10. CODEBASE/

This approach allows AI systems to understand the structure,
purpose, behavior, and compact identity of a repository before analyzing its implementation.

The long-term goal is to enable **AI systems to reason about repositories
using structured knowledge rather than raw code alone**.

---

# Explain-First Repositories

In the long term, the primary interface for repository exploration
may become an **explain-first workflow**.

Concept:

git clone <repo>
snapshot explain

The tool produces a deterministic explanation package describing:

- repository identity
- project purpose
- execution entrypoints
- architectural structure
- semantic components
- artifact generation pipeline

This approach allows developers and AI systems to understand
an unfamiliar repository **before reading its source code**.

---

# Timeline-Aware Repositories

As temporal intelligence matures, repository exploration can become timeline-aware.

Concept:

snapshot history
snapshot diff <snapshotA> <snapshotB>
snapshot timeline

The tool progressively evolves from a snapshot generator into
a deterministic repository memory engine.

This enables:

- repository change tracking without Git dependency
- longitudinal architecture interpretation
- AI repository memory across archived states

---

# Near-Term Roadmap

Features expected in the next development phases.

---

## Repository Timeline

Artifact:

REPOSITORY_TIMELINE.md

Purpose:

Provide a chronological human-readable report describing repository history
from archived snapshots.

---

## Evolution Signals

Artifact:

EVOLUTION_SIGNALS.tsv

Purpose:

Capture deterministic signals such as:

- growth
- dependency expansion
- semantic drift
- architecture change

---

# Mid-Term Evolution

Capabilities that strengthen repository understanding.

---

## Repository Health

Artifact:

REPOSITORY_HEALTH.md

Purpose:

Evaluate repository stability and quality signals over time.

---

## Repository Lint

Command:

snapshot lint

Purpose:

Evaluate repository quality signals:

- documentation presence
- test presence
- entrypoint clarity
- structural conventions
- component organization

This acts as a **repository health report**.

---

# Long-Term Concepts

Ideas that extend repository intelligence further.

These remain experimental and will only be implemented
when the deterministic repository model becomes sufficiently mature.

## Repository Memory

Purpose:

Allow AI systems and humans to navigate a repository not only
as a static structure, but as an evolving knowledge space.

Possible directions:

- archive browsing
- timeline synthesis
- history-aware AI ingestion
- repository drift interpretation
