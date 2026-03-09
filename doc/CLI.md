# CLI Reference

This document describes the command line interface of **codebase-snapshot**.

---

# Command

bin/snapshot --target <path> --label <label>

---

# Options

--target <path>
Repository root to analyze and snapshot.

--label <label>
Human-readable label used to identify the snapshot.

--help
Display command usage information.

--version
Print the current tool version.

---

# Snapshot Output Location

Snapshots are written to the following structure:

snapshots/YYYY-MM-DD/vX.Y.Z/<sequence>_<label>/

Example:

snapshots/2026-03-09/v0.2.2/01_phase_4_purpose/

Each snapshot directory contains a deterministic bundle of artifacts describing the repository.

---

# Generated Snapshot Artifacts

A snapshot generates the following artifacts:

PROJECT_TREE.txt
INDEX.tsv
DEPENDENCIES.tsv
GRAPH.tsv
SEMANTICS.tsv
ENTRYPOINTS.tsv
PURPOSE.md

ARCHITECTURE.md
DOCUMENTATION.md
LANGUAGES.md
COMPONENTS.md

MANIFEST.md
AI_INGESTION_GUIDE.md

LOG.txt
SNAPSHOT_META.json

CODEBASE/

---

# CODEBASE Export

The CODEBASE directory contains a structured export of repository source files grouped by function.

Structure:

CODEBASE/

01_cli.md
02_core.md
03_tests.md
04_docs.md

Purpose:

Allows AI systems to ingest repository source code in a structured and predictable way.

---

# Deterministic Behavior

Snapshot generation follows strict deterministic rules:

- stable file ordering
- explicit exclusion rules
- normalized naming
- predictable artifact layout

Running the command twice on the same repository state must produce identical structural outputs.

---

# Exclusion Rules

Certain paths are ignored during repository scanning:

.git
node_modules
dist
build
__pycache__
logs
snapshots

These exclusions prevent runtime artifacts and dependencies from polluting snapshot analysis.
