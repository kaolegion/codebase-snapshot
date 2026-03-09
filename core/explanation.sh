#!/usr/bin/env bash
set -euo pipefail

render_system_flow() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || {
        echo "[ERROR] Directory not found: $target_dir" >&2
        return 1
    }

    cat <<'FLOW'
# System Flow Overview

This file was generated automatically by **codebase-snapshot**.

The explanation is deterministic and derived from the repository entrypoint,
module layout, subsystem mapping, and snapshot generation pipeline.

## Execution Entrypoint

The main execution entrypoint is:

- `bin/snapshot`

This command orchestrates the full repository analysis and artifact generation flow.

## Main Internal Pipeline

The repository operates through the following deterministic pipeline:

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

## Module Responsibilities

### CLI

- `bin/snapshot`
- Orchestrates the complete snapshot generation workflow.
- Invokes modeling and rendering modules in a fixed order.

### Modeling

- `core/indexer.sh`
- `core/dependencies.sh`
- `core/graph.sh`
- `core/semantics.sh`
- `core/entrypoints.sh`
- `core/purpose.sh`
- `core/structure.sh`

These modules build deterministic repository intelligence signals.

### Rendering

- `core/architecture.sh`
- `core/documentation.sh`
- `core/languages.sh`
- `core/renderer.sh`

These modules transform repository signals into human-readable artifacts.

### Infrastructure

- `core/scanner.sh`
- `core/config.sh`
- `core/logger.sh`
- `core/naming.sh`
- `core/utils.sh`
- `core/classifier.sh`

These modules provide shared runtime capabilities used by the pipeline.

## Subsystem Interactions

The internal system flow can be summarized as follows:

- the CLI entrypoint starts the snapshot process
- infrastructure services support deterministic repository discovery and execution
- modeling modules convert repository contents into structured intelligence layers
- rendering modules transform those layers into readable documentation artifacts

## Generated Artifacts

The main generated artifacts include:

- `PROJECT_TREE.txt`
- `INDEX.tsv`
- `DEPENDENCIES.tsv`
- `GRAPH.tsv`
- `SEMANTICS.tsv`
- `ENTRYPOINTS.tsv`
- `MODULES.tsv`
- `SUBSYSTEMS.tsv`
- `ARCHITECTURE.md`
- `DOCUMENTATION.md`
- `LANGUAGES.md`
- `COMPONENTS.md`
- `PURPOSE.md`

## Interpretation Notes

- This explanation is deterministic.
- The flow is derived from the repository implementation itself.
- The goal is to explain how the repository works internally.
FLOW
}
