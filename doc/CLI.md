# CLI Reference

This document describes the command line interface of **codebase-snapshot**.

---

# Commands

## Snapshot generation

bin/snapshot --target <path> --label <label>

Purpose:

Generate a deterministic repository snapshot.

Required options:

--target <path>
Repository root to analyze and snapshot.

--label <label>
Human-readable label used to identify the snapshot.

---

## Snapshot history

bin/snapshot history

Purpose:

List archived historical snapshots recorded in `SNAPSHOT_HISTORY.tsv`.

Output columns:

TIMESTAMP
SNAPSHOT_ID
SNAPSHOT_PATH

---

## Snapshot diff

bin/snapshot diff <snapshotA> <snapshotB>

Purpose:

Compare two snapshot directories and generate deterministic evolution artifacts.

Generated output:

DIFF.tsv
SNAPSHOT_DIFF.md

---

## Utility commands

bin/snapshot --help
bin/snapshot --version

---

# Snapshot Output Location

Main generated snapshots are written to:

snapshots/YYYY-MM-DD/vX.Y.Z/<sequence>_<label>/

Example:

snapshots/2026-03-09/v1.0.0/01_initial/

Archived historical snapshots are written to:

.snapshots/snapshot_YYYYMMDD_HHMMSS/

---

# Generated Snapshot Artifacts

A snapshot generates the following artifacts:

PROJECT_TREE.txt
INDEX.tsv
DEPENDENCIES.tsv
GRAPH.tsv
SEMANTICS.tsv
ENTRYPOINTS.tsv
MODULES.tsv
SUBSYSTEMS.tsv

PURPOSE.md
SYSTEM_FLOW.md
REPOSITORY_DNA.md
REPOSITORY_EXPLAIN.md

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

# Deterministic Behavior

Snapshot generation follows strict deterministic rules:

- stable file ordering
- explicit exclusion rules
- normalized naming
- predictable artifact layout
- snapshot history index creation
- stable CLI surface

Running the command twice on the same repository state must produce identical structural outputs,
while still generating distinct archived history entries because archive IDs are time-based.

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
