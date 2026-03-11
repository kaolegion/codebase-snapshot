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

## Repository timeline

bin/snapshot timeline

Purpose:

Render a deterministic human-readable repository timeline from archived snapshots.

Generated output:

REPOSITORY_TIMELINE.md

---

## Repository evolution signals

bin/snapshot evolution

Purpose:

Generate deterministic machine-readable repository evolution signals
from archived snapshot history.

Generated output:

EVOLUTION_SIGNALS.tsv

Signal format:

SIGNAL <type> <snapshot_A> <snapshot_B> <value>

Signals currently supported:

FILE_COUNT_INCREASED
FILE_COUNT_DECREASED
FILE_COUNT_STABLE
TOOL_VERSION_CHANGED
LABEL_CHANGED

---

## Repository health

bin/snapshot health

Purpose:

Render a deterministic human-readable repository health summary
from archived snapshot history and evolution signals.

Generated output:

REPOSITORY_HEALTH.md

Health signals currently supported:

REPOSITORY_GROWING
REPOSITORY_STABLE
CHANGE_ACTIVITY_LOW
CHANGE_ACTIVITY_MODERATE
TOOL_VERSION_PROGRESSING
SNAPSHOT_LABELS_EVOLVING

Notes:

- the command refreshes `EVOLUTION_SIGNALS.tsv` before rendering health
- health rendering remains deterministic and history-driven

---

## Repository lint

bin/snapshot lint

Purpose:

Render a deterministic human-readable repository lint summary
from repository structural artifacts and deterministic repository signals.

Generated output:

REPOSITORY_LINT.md

Lint evidence currently supported:

- missing documentation
- missing tests
- orphan modules
- entrypoints without semantic mapping
- modules without subsystem mapping
- empty subsystems
- dependency targets absent from indexed repository files
- structural inconsistencies between generated artifacts

Notes:

- the command remains deterministic and artifact-driven
- lint rendering is based on INDEX.tsv, DEPENDENCIES.tsv, SEMANTICS.tsv, ENTRYPOINTS.tsv, MODULES.tsv, SUBSYSTEMS.tsv, and DOCUMENTATION.md

---

## Repository risks

bin/snapshot risk

Purpose:

Render a deterministic human-readable repository risk summary
from archived snapshots, dependency signals, and entrypoint criticality.

Generated output:

REPOSITORY_RISKS.md

Risk evidence currently supported:

- snapshot volatility
- dependency gravity
- entrypoint criticality
- core subsystem sensitivity

Notes:

- the command remains deterministic and evidence-driven
- risk levels are derived from archived snapshot presence and repository signals

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

snapshots/2026-03-10/v1.3.0/01_initial/

Archived historical snapshots are written to:

.snapshots/snapshot_YYYYMMDD_HHMMSS/

Repository timeline output is written to:

REPOSITORY_TIMELINE.md

Repository evolution signal output is written to:

EVOLUTION_SIGNALS.tsv

Repository health output is written to:

REPOSITORY_HEALTH.md

Repository lint output is written to:

REPOSITORY_LINT.md

Repository risk output is written to:

REPOSITORY_RISKS.md

---

# Generated Snapshot Artifacts

The snapshot generation command produces the following artifacts:

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

The repository timeline command produces:

REPOSITORY_TIMELINE.md

The repository evolution command produces:

EVOLUTION_SIGNALS.tsv

The repository health command produces:

REPOSITORY_HEALTH.md

The repository lint command produces:

REPOSITORY_LINT.md

The repository risk command produces:

REPOSITORY_RISKS.md

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

Excluded paths and generated history artifacts must not re-enter repository scans.

This prevents recursive self-analysis and preserves deterministic repository outputs.
