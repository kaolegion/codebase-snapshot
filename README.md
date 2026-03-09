# codebase-snapshot

Deterministic shell-first tool that converts any software repository into an **AI-ready structured snapshot**.

The goal is to allow humans and AI systems to quickly understand a codebase without navigating the entire repository.

The snapshot explains:

- what is in the repository
- what it is for
- how it works internally
- how it is structured
- where execution begins
- how its main modules and subsystems are organized
- how the repository can be summarized as a compact deterministic DNA profile
- how a repository evolves between snapshots
- how repository snapshots can be archived and explored historically
- how the full repository can be synthesized into one final explanation layer

---

# Project Status

Version: **v1.0.0**

Current capabilities:

- deterministic repository scanning
- repository structural graph
- dependency extraction
- semantic component detection
- repository entrypoint detection
- repository purpose inference
- deterministic repository module modeling
- deterministic repository subsystem modeling
- deterministic repository architecture rendering
- deterministic repository system flow explanation
- deterministic repository DNA synthesis
- deterministic repository diff intelligence
- deterministic repository explain synthesis
- deterministic snapshot history engine
- AI-ready snapshot export
- deterministic test suite

---

# CLI

Snapshot generation:

bin/snapshot --target <path> --label <label>

Snapshot comparison:

bin/snapshot diff <snapshotA> <snapshotB>

Snapshot history:

bin/snapshot history

Utility commands:

bin/snapshot --help
bin/snapshot --version

---

# Snapshot Artifacts

Each snapshot produces a structured bundle describing the repository.

Core artifacts:

PROJECT_TREE.txt
INDEX.tsv
DEPENDENCIES.tsv
GRAPH.tsv
SEMANTICS.tsv
ENTRYPOINTS.tsv
MODULES.tsv
SUBSYSTEMS.tsv

Comparison artifacts:

DIFF.tsv
SNAPSHOT_DIFF.md

Interpretation artifacts:

PURPOSE.md
SYSTEM_FLOW.md
REPOSITORY_DNA.md
REPOSITORY_EXPLAIN.md

Human-readable artifacts:

ARCHITECTURE.md
DOCUMENTATION.md
LANGUAGES.md
COMPONENTS.md

Context artifacts:

MANIFEST.md
AI_INGESTION_GUIDE.md

Runtime artifacts:

LOG.txt
SNAPSHOT_META.json

Structured code export:

CODEBASE/

---

# Snapshot History

Snapshots are archived deterministically inside the repository.

History storage:

.snapshots/

History index:

SNAPSHOT_HISTORY.tsv

The history index records:

- archive timestamp
- deterministic snapshot ID
- archived snapshot path

The `bin/snapshot history` command lists this index directly.

This allows the tool to maintain a deterministic **repository timeline foundation**
independent of Git.

---

# Repository Semantics

The semantic layer classifies repository files using deterministic rules.

Each file receives four semantic signals:

- component
- group
- role
- rule

Artifacts:

SEMANTICS.tsv
COMPONENTS.md

This layer provides explicit file-to-component mapping and human-readable grouping.

---

# Repository Structural Modeling

The structural modeling layer describes repository topology above individual file semantics.

Artifacts:

MODULES.tsv
SUBSYSTEMS.tsv
ARCHITECTURE.md

This layer helps humans and AI systems understand not only repository files,
but also the higher-level organization of the engine itself.

---

# Repository Cognitive Layers

The interpretation and synthesis layers provide progressively stronger explanations.

Artifacts:

PURPOSE.md
SYSTEM_FLOW.md
REPOSITORY_DNA.md
REPOSITORY_EXPLAIN.md

These layers explain:

- what the repository is for
- how it operates internally
- what its compact identity looks like
- how the whole repository can be summarized coherently

---

# Repository Evolution Intelligence

The evolution layer explains repository change over time.

Artifacts:

DIFF.tsv
SNAPSHOT_DIFF.md
SNAPSHOT_HISTORY.tsv

This layer currently supports:

- deterministic snapshot-to-snapshot comparison
- human-readable change summaries
- persistent archived snapshot history

This is the foundation for future repository timeline and evolution signals.

---

# Deterministic Behavior

The project keeps the following principles:

- deterministic behavior
- shell-first architecture
- CLI orchestration only
- modular core engines
- explicit snapshot artifacts
- tests as contract

Running the tool on the same repository state should produce stable structural outputs.

---

# Status Summary

codebase-snapshot is now a deterministic repository intelligence engine with:

- structural intelligence
- semantic intelligence
- architectural intelligence
- cognitive intelligence
- early temporal intelligence
