# Changelog

All notable changes to this project will be documented in this file.

---

## v1.4.0

### Phase 5.4 — Repository Risk Signals

Enhancements:

- introduced deterministic repository risk signaling
- added human-readable repository risk artifact `REPOSITORY_RISKS.md`
- added repository risk synthesis from archived snapshots, dependency gravity, entrypoint criticality, and core subsystem sensitivity
- established the first deterministic repository risk interpretation layer

Core engine:

- added `core/risk.sh`
- implemented deterministic risk evidence aggregation
- implemented volatility-based risk scoring from archived snapshot indexes
- implemented dependency fan-in risk scoring
- implemented entrypoint and core sensitivity weighting

Risk heuristics introduced:

- snapshot volatility
- dependency gravity
- entrypoint criticality
- core subsystem sensitivity

CLI integration:

- added `bin/snapshot risk`
- integrated repository risk rendering into the CLI surface

Tests:

- added `tests/test_risk.sh`
- validated deterministic repository risk rendering
- validated risk report generation from CLI
- integrated risk engine into the full test suite

Documentation:

- updated README to expose repository risk signals
- updated roadmap to mark Phase 5.4 as complete
- updated CLI documentation
- updated snapshot format documentation

This release introduces the first deterministic **repository risk signaling layer**,
allowing humans and AI systems to identify sensitive repository areas using stable evidence.

---

## v1.3.0

### Phase 5.3 — Repository Health Signals

Enhancements:

- introduced deterministic repository health interpretation
- added human-readable repository health artifact `REPOSITORY_HEALTH.md`
- added repository health synthesis from archived snapshot history and evolution signals
- established the first deterministic repository health interpretation layer

Core engine:

- added `core/health.sh`
- implemented deterministic health signal rendering
- implemented repository health evidence reporting
- implemented deterministic repository health interpretation

Health signals introduced:

REPOSITORY_GROWING
REPOSITORY_STABLE
CHANGE_ACTIVITY_LOW
CHANGE_ACTIVITY_MODERATE
TOOL_VERSION_PROGRESSING
SNAPSHOT_LABELS_EVOLVING

CLI integration:

- added `bin/snapshot health`
- refreshed evolution signals before health rendering for output consistency

Tests:

- added `tests/test_health.sh`
- validated deterministic repository health rendering
- validated health signal presence
- validated evidence and interpretation sections
- integrated health engine into the test suite

Documentation:

- updated README to expose repository health signals
- updated roadmap to mark Phase 5.3 as complete
- updated CLI documentation
- updated snapshot format documentation

This release introduces the first deterministic **repository health interpretation layer**,
allowing humans and AI systems to assess repository change behavior in a stable and readable form.

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
