# Changelog

All notable changes to this project will be documented in this file.

---

## v1.0.0

### Phase 5.0 — Snapshot History Engine

Enhancements:

- introduced deterministic snapshot history engine
- added deterministic snapshot archiving inside `.snapshots/`
- added repository-level snapshot history index `SNAPSHOT_HISTORY.tsv`
- added deterministic snapshot ID generation for archived snapshots
- established the foundation for repository timeline intelligence

Core engine:

- added `core/history.sh`
- added snapshot history storage initialization
- added snapshot archive creation
- added snapshot history index update logic
- added snapshot history listing functions

CLI integration:

- added `bin/snapshot history`
- integrated automatic snapshot archiving into snapshot generation
- preserved existing `bin/snapshot diff <snapshotA> <snapshotB>` behavior
- kept the main snapshot output layout stable under `snapshots/`

Tests:

- added `tests/test_history.sh`
- validated history index initialization
- validated archived snapshot creation
- validated snapshot ID recording
- validated CLI history listing
- updated dependency tests to reflect new CLI sourcing

Documentation:

- updated README to expose snapshot history capability
- updated roadmap to mark Phase 5.0 as complete
- updated vision to include temporal repository intelligence
- updated snapshot format and CLI documentation for history support
- updated getting started and TODO documentation for the new project state

This release introduces the first deterministic **repository timeline foundation**,
allowing snapshots to become persistent historical artifacts that can be listed,
compared, and interpreted over time.

---

## v0.9.0

### Phase 4.9 — Repository Diff Intelligence

Enhancements:

- introduced deterministic snapshot comparison artifacts `DIFF.tsv` and `SNAPSHOT_DIFF.md`
- added a machine-readable repository evolution layer for added, removed, and modified files
- added a human-readable repository evolution summary derived only from snapshot artifacts
- preserved deterministic comparison behavior without relying on git

Core engine:

- added `core/diff.sh`
- implemented deterministic `generate_snapshot_diff`
- implemented deterministic `render_snapshot_diff`

Tests:

- added `tests/test_diff.sh`
- validated deterministic diff output
- validated ADDED, REMOVED, and MODIFIED detection
- validated snapshot diff markdown generation
- validated CLI diff output generation

CLI integration:

- added `bin/snapshot diff <snapshotA> <snapshotB>`
- added deterministic diff output directory generation
- integrated `DIFF.tsv` and `SNAPSHOT_DIFF.md` generation into the CLI surface

Documentation:

- updated README to expose repository diff intelligence
- updated roadmap to mark repository diff intelligence as complete
- updated snapshot format documentation for `DIFF.tsv` and `SNAPSHOT_DIFF.md`

This release introduces a **deterministic repository evolution layer** that allows
humans and AI systems to understand what changed between two repository snapshots.

---

## v0.8.0

### Phase 4.8 — Repository DNA

Enhancements:

- introduced deterministic repository identity artifact `REPOSITORY_DNA.md`
- added a compact repository DNA layer summarizing project type, architecture style, languages, dependency model, documentation presence, test coverage, repository size, core components, and entrypoints
- implemented deterministic hybrid project type detection using structural directory signals first and entrypoint signals as support
- kept the existing AI ingestion order unchanged while adding repository DNA as a complementary interpretation layer

Core engine:

- added `core/dna.sh`
- implemented deterministic `render_repository_dna`
- integrated repository DNA rendering at the end of the snapshot pipeline

Tests:

- added `tests/test_dna.sh`
- validated deterministic generation of `REPOSITORY_DNA.md`
- validated presence of stable DNA sections and entrypoint references
- integrated repository DNA validation into the global test suite

CLI integration:

- integrated `REPOSITORY_DNA.md` generation into `bin/snapshot`
- added repository DNA generation logging
- preserved existing AI ingestion ordering pending future evaluation of DNA reading priority

Documentation:

- updated README to expose the repository DNA interpretation layer
- updated roadmap to mark repository DNA as complete
- updated snapshot format documentation for `REPOSITORY_DNA.md`

This release introduces a **deterministic repository identity layer** that gives
humans and AI systems a compact repository signature answering:

- what kind of repository this is
- which architectural style it follows
- which languages are present
- which execution surfaces exist
- which core structural signals define the repository
