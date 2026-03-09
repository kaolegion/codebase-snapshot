# Changelog

All notable changes to this project will be documented in this file.

---

## v0.7.0

### Phase 4.7 — Repository Explain Engine

Enhancements:

- introduced deterministic high-level repository explanation artifact `REPOSITORY_EXPLAIN.md`
- added a final repository interpretation layer synthesizing identity, purpose, execution, architecture, semantics, and generated artifacts
- extended AI ingestion ordering to place repository-wide synthesis before lower-level interpretation layers
- strengthened CLI snapshot contract to validate final explanation output

Core engine:

- added `core/repository_explain.sh`
- implemented deterministic `render_repository_explain` engine
- integrated repository explain rendering into the snapshot generation pipeline

Tests:

- added `tests/test_repository_explain.sh`
- validated deterministic generation of `REPOSITORY_EXPLAIN.md`
- validated presence of stable explanation sections
- updated CLI snapshot validation to include repository explain synthesis
- integrated repository explain validation into the global test suite

CLI integration:

- integrated `REPOSITORY_EXPLAIN.md` generation into `bin/snapshot`
- extended AI ingestion guide ordering to include repository explain synthesis
- added repository explain generation logging

Documentation:

- updated README to expose the final repository explanation layer
- updated roadmap to mark repository explain synthesis as complete
- updated snapshot format documentation for `REPOSITORY_EXPLAIN.md`

This release introduces the **final repository explanation layer**, allowing
humans and AI systems to read one deterministic high-level document answering:

- what the repository is
- what it does
- how it works
- how it is organized

---

## v0.6.0

### Phase 4.6 — Repository Explanation Engine

Enhancements:

- introduced deterministic repository explanation artifact `SYSTEM_FLOW.md`
- added a new system flow interpretation layer explaining how repositories operate internally
- integrated repository execution flow description derived from CLI orchestration and module layout
- extended AI ingestion ordering to include internal system flow interpretation

Core engine:

- added `core/explanation.sh`
- implemented deterministic `render_system_flow` engine
- integrated system flow rendering into the snapshot generation pipeline

Tests:

- added `tests/test_system_flow.sh`
- validated deterministic generation of `SYSTEM_FLOW.md`
- validated presence of execution entrypoint and pipeline description
- integrated system flow validation into the global test suite

CLI integration:

- integrated `SYSTEM_FLOW.md` generation into `bin/snapshot`
- added system flow generation logging
- extended AI ingestion guide ordering to include repository flow explanation

Documentation:

- prepared documentation convergence for the repository explanation layer
- updated snapshot artifact interpretation ordering for AI ingestion

This release introduces the **repository explanation layer**, allowing
humans and AI systems to understand **how a repository operates internally**.

---

## v0.5.0

### Phase 4.5 — Structural Rendering Convergence

Enhancements:

- ARCHITECTURE.md is now generated deterministically from repository topology
- architecture rendering now converges MODULES.tsv and SUBSYSTEMS.tsv into a human-readable structural view
- static directory-count architecture summaries have been removed
- repository architecture is now expressed as module sections with subsystem listings

Core engine:

- replaced the legacy architecture summary renderer in core/architecture.sh
- added deterministic module title normalization for architecture reporting
- integrated topology-driven architecture rendering into the snapshot output pipeline

Tests:

- extended tests/test_cli.sh to validate SUBSYSTEMS.tsv presence in snapshots
- added architecture rendering assertions for module sections and subsystem entries
- validated deterministic architecture rendering through the CLI snapshot contract

Documentation:

- updated architecture documentation for topology-driven rendering
- updated snapshot format documentation for generated architecture behavior
- updated roadmap to mark structural rendering convergence as complete

This release moves codebase-snapshot from repository topology modeling
to deterministic topology rendering for human and AI repository interpretation.

---

## v0.4.0

### Phase 4.4 — Repository Structural Modeling

#### Increment 1 — MODULES layer

Enhancements:

- introduced the first repository topology layer with MODULES.tsv
- added deterministic repository module modeling
- added stable architectural zones: cli, modeling, rendering, infrastructure, tests, docs
- fixed snapshot version directory rendering to avoid duplicated version prefix

Core engine:

- added core/structure.sh
- added deterministic module generation logic
- integrated MODULES.tsv generation into the main snapshot pipeline

Tests:

- added tests/test_structure.sh
- integrated structural modeling into the full test suite
- validated MODULES.tsv generation through CLI snapshots

Documentation:

- updated SNAPSHOT_FORMAT specification for MODULES.tsv

#### Increment 2 — SUBSYSTEMS layer

Enhancements:

- introduced SUBSYSTEMS.tsv as the second repository topology layer
- added deterministic subsystem mapping inside repository modules
- modeled stable functional subsystems for cli, modeling, rendering, and infrastructure
- extended AI ingestion ordering to include structural subsystem interpretation

Core engine:

- extended core/structure.sh with subsystem generation logic
- added deterministic list_repository_subsystems
- added deterministic generate_subsystems
- integrated SUBSYSTEMS.tsv generation into the main snapshot pipeline

Tests:

- extended tests/test_structure.sh with subsystem validation
- validated deterministic subsystem line count
- validated SUBSYSTEMS.tsv generation through CLI snapshots

Documentation:

- updated README project status and artifact list
- prepared structural documentation convergence for subsystem modeling

This release moves codebase-snapshot from file semantics toward repository topology modeling
and establishes a two-layer structural architecture for AI-oriented repository interpretation:

- MODULES.tsv
- SUBSYSTEMS.tsv

---

## v0.3.0

### Phase 4.3 — Component Grouping Refinement

Enhancements:

- SEMANTICS.tsv now exposes component, group, role, and rule
- deterministic grouping layer for repository subsystems
- hierarchical COMPONENTS.md rendering (component → group → files)

Core engine:

- extended semantic detection logic
- deterministic group classification
- deterministic role classification

Tests:

- expanded semantic test coverage
- updated CLI snapshot validation

Documentation:

- updated README semantics section
- updated CLI documentation
- updated SNAPSHOT_FORMAT specification

This release strengthens repository modeling and prepares the system
for deeper structural analysis of repositories.
