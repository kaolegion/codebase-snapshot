# Changelog

All notable changes to this project will be documented in this file.

---

## v0.4.0

### Phase 4.4 — Repository Structural Modeling

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

This release moves codebase-snapshot from file semantics toward repository topology modeling
and establishes the first structural architecture layer for AI-oriented repository interpretation.

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

---
