# codebase-snapshot

Deterministic shell-first tool that converts any software repository into an **AI-ready structured snapshot**.

The goal is to allow humans and AI systems to quickly understand a codebase without navigating the entire repository.

The snapshot explains:

- what is in the repository
- what it is for
- how it is structured
- where execution begins
- how its main modules and subsystems are organized

---

# Project Status

Version: **v0.4.0**

Current capabilities:

- deterministic repository scanning
- repository structural graph
- dependency extraction
- semantic component detection
- repository entrypoint detection
- repository purpose inference
- deterministic repository module modeling
- deterministic repository subsystem modeling
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
PURPOSE.md

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

Example classifications:

- cli_tool
- application
- service
- library
- automation_toolkit
- documentation_repository
- configuration_repository
- multi_purpose
- unknown

The system is deterministic and rule-based.

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
- CLI behavior

---

# Roadmap

Current milestone:

Phase 4.4 — Repository Structural Modeling

Current increment:

Increment 2: SUBSYSTEMS layer

Next milestone:

Phase 4.5 — Structural Rendering Convergence

See:

doc/ROADMAP.md
