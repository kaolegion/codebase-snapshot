# Changelog

All notable changes to this project will be documented in this file.

---

## v1.2.0

### Phase 5.2 — Evolution Signals Engine

Enhancements:

- introduced deterministic repository evolution signal engine
- added machine-readable repository evolution artifact `EVOLUTION_SIGNALS.tsv`
- added deterministic comparison between consecutive archived snapshots
- established the first machine-readable repository evolution signal layer

Core engine:

- added `core/evolution.sh`
- implemented deterministic evolution signal generation
- implemented metadata comparison between archived snapshots
- added stable evolution signal ordering

Signals introduced:

FILE_COUNT_INCREASED
FILE_COUNT_DECREASED
FILE_COUNT_STABLE
TOOL_VERSION_CHANGED
LABEL_CHANGED

CLI integration:

- added `bin/snapshot evolution`
- integrated evolution signal generation into CLI surface

Tests:

- added `tests/test_evolution.sh`
- validated deterministic evolution signal generation
- validated metadata comparison logic
- validated signal ordering

Documentation:

- updated README to expose repository evolution signals
- updated roadmap to mark Phase 5.2 as complete
- updated CLI documentation
- updated snapshot format documentation

This release introduces the first deterministic **repository evolution signal layer**,
allowing AI systems and humans to interpret repository change patterns over time.

---

