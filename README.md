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
- how the full repository can be synthesized into one final explanation layer

---

# Project Status

Version: **v0.7.0**

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
- deterministic repository explain synthesis
- AI-ready snapshot export
- deterministic test suite

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

Interpretation artifacts:

PURPOSE.md
SYSTEM_FLOW.md
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

# Repository Semantics

The semantic layer classifies repository files using deterministic rules.

Each file receives four semantic signals:

- component
- group
- role
- rule

Components represent high-level repository areas such as:

- cli
- core
- tests
- docs
- examples
- tools
- config
- root
- unknown

Groups represent functional subsystems inside components.

Roles describe the operational role of a file such as entrypoint, engine, guide, test, or tool.

Rules indicate the deterministic detection signal used.

Artifacts:

SEMANTICS.tsv
- machine-readable semantic mapping

COMPONENTS.md
- human-readable hierarchical component summary

---

# Entrypoint Detection

Entrypoints identify where execution begins in a repository.

Artifact:

ENTRYPOINTS.tsv

Detection signals include:

- bin/*
- cmd/*
- main.*
- app.*
- server.*
- Makefile
- docker-compose.yml
- root shell scripts

---

# Repository Structural Modeling

The structural modeling layer describes repository topology above individual file semantics.

Artifacts:

MODULES.tsv
- deterministic mapping of the repository to main architectural modules

SUBSYSTEMS.tsv
- deterministic mapping of stable functional subsystems inside those modules

This layer helps AI systems understand not only repository files, but also the architectural organization of the engine itself.

---

# Repository Purpose Inference

Purpose inference explains **what the repository is for**.

Artifact:

PURPOSE.md

The inference engine detects:

- repository classification
- operational role
- execution profile
- structural signals supporting the interpretation

The system is deterministic and rule-based.

---

# Repository System Flow Explanation

The explanation layer describes **how the repository operates internally**.

Artifact:

SYSTEM_FLOW.md

This artifact explains:

- the main execution entrypoint
- the internal repository analysis pipeline
- interactions between core modules
- how snapshot artifacts are produced

This helps both humans and AI systems understand the operational behavior of the repository.

---

# Repository Explain Synthesis

The final explanation layer synthesizes the repository into one high-level document.

Artifact:

REPOSITORY_EXPLAIN.md

This artifact explains:

- what the repository is
- what it is for
- how it works internally
- where execution begins
- how modules and subsystems are organized
- what snapshot artifacts are generated

This artifact acts as the final repository explanation layer for both humans and AI systems.

---

# CLI Usage

Basic usage:

bin/snapshot --target <repository> --label <label>

Example:

bin/snapshot --target /opt/project --label initial_analysis

Snapshots are generated under:

snapshots/YYYY-MM-DD/vX.Y.Z/<sequence>_<label>/

---

# Testing

Run the full deterministic test suite:

tests/run_all.sh

Tests validate:

- indexing
- dependency extraction
- graph generation
- semantics
- entrypoints
- purpose inference
- structural modeling
- system flow explanation
- repository explain synthesis
- CLI behavior

---

# Roadmap

Current milestone:

Phase 4.7 — Repository Explain Engine

Next milestone:

Phase 4.8 — Repository Intelligence Expansion

See:

doc/ROADMAP.md
