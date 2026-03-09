#!/usr/bin/env bash
set -euo pipefail

render_repository_explain() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || {
        echo "[ERROR] Directory not found: $target_dir" >&2
        return 1
    }

    cat <<'EXPLAIN'
# Repository Explanation

This file was generated automatically by **codebase-snapshot**.

The explanation is deterministic and synthesizes the main repository
interpretation layers into one stable high-level overview.

It is intended for both humans and AI systems.

## Repository Identity

This repository is a deterministic repository intelligence engine.

Its purpose is to convert software repositories into structured artifacts
that make repository exploration, interpretation, and ingestion easier.

The repository is designed as a shell-first modular system with a command-line
entrypoint and a set of dedicated core analysis and rendering modules.

## Purpose

The repository is used to analyze a target codebase and generate a snapshot
that explains:

- what exists in the repository
- what the repository is for
- how the repository works internally
- how the repository is organized structurally
- which artifacts are produced for downstream reading or ingestion

The implementation is deterministic and rule-based.

No probabilistic interpretation is used in the generated outputs.

## Execution Entrypoints

The main execution entrypoint is:

- `bin/snapshot`

This command orchestrates the full snapshot lifecycle.

It invokes repository discovery, structural modeling, semantic mapping,
topology rendering, and explanation rendering in a fixed order.

## Internal Operation

The repository operates through a stable internal pipeline:

1. Repository scanning
2. File indexing
3. Dependency extraction
4. Structural graph modeling
5. Semantic mapping
6. Entrypoint detection
7. Module modeling
8. Subsystem modeling
9. Architecture rendering
10. Documentation rendering
11. Language reporting
12. Component rendering
13. Purpose inference
14. System flow rendering
15. Repository explanation rendering

The execution model is orchestration-first:

- the CLI coordinates the workflow
- core modules contain deterministic logic
- generated artifacts are written in a stable sequence
- tests validate expected behavior as repository contract

## Architecture Overview

The repository is organized into stable architectural layers.

### CLI layer

- `bin/snapshot`
- Provides the public command-line interface.
- Remains orchestration-only.

### Core modeling layer

- `core/indexer.sh`
- `core/dependencies.sh`
- `core/graph.sh`
- `core/semantics.sh`
- `core/entrypoints.sh`
- `core/purpose.sh`
- `core/structure.sh`

These modules produce deterministic repository intelligence signals.

### Core rendering layer

- `core/architecture.sh`
- `core/documentation.sh`
- `core/languages.sh`
- `core/renderer.sh`
- `core/explanation.sh`
- `core/repository_explain.sh`

These modules transform structural and semantic signals into human-readable
artifacts.

### Core infrastructure layer

- `core/scanner.sh`
- `core/config.sh`
- `core/logger.sh`
- `core/naming.sh`
- `core/utils.sh`
- `core/classifier.sh`

These modules provide shared services used across the pipeline.

### Validation layer

- `tests/`

This layer validates deterministic behavior and artifact generation.

### Documentation layer

- `doc/`
- root markdown documentation files

This layer documents project architecture, roadmap, formats, and usage.

## Semantic Components

The repository is semantically organized around the following stable
component families:

- CLI
- modeling
- rendering
- infrastructure
- tests
- documentation

These semantic components help explain repository intent beyond file paths
alone.

The modeling layer extracts repository intelligence.

The rendering layer transforms repository intelligence into readable
artifacts.

The infrastructure layer supports deterministic execution.

The validation layer enforces the repository contract.

## Generated Snapshot Artifacts

The repository generates structured snapshot outputs, including:

### Discovery and indexing

- `PROJECT_TREE.txt`
- `INDEX.tsv`

### Structural relationships

- `DEPENDENCIES.tsv`
- `GRAPH.tsv`

### Semantic interpretation

- `SEMANTICS.tsv`
- `ENTRYPOINTS.tsv`
- `COMPONENTS.md`

### Topology and architecture

- `MODULES.tsv`
- `SUBSYSTEMS.tsv`
- `ARCHITECTURE.md`

### Repository interpretation

- `PURPOSE.md`
- `SYSTEM_FLOW.md`
- `REPOSITORY_EXPLAIN.md`

### Additional snapshot support artifacts

- `DOCUMENTATION.md`
- `LANGUAGES.md`
- `MANIFEST.md`
- `AI_INGESTION_GUIDE.md`
- `LOG.txt`
- `SNAPSHOT_META.json`
- `CODEBASE/`

Together, these files form a deterministic repository explanation package.

## Interpretation Notes

- This explanation is deterministic.
- Section ordering is stable.
- The content is repository-oriented and synthesis-oriented.
- The goal is to provide one high-level document that summarizes the full repository.
- This artifact complements PURPOSE.md, SYSTEM_FLOW.md, ARCHITECTURE.md, and COMPONENTS.md.
EXPLAIN
}
