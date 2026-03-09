# TODO

This document lists the next development objectives for **codebase-snapshot**.

The TODO is aligned with the official roadmap.

---

# Phase 5.1 — Repository Timeline

Extend snapshot history into a human-readable repository timeline.

Tasks:

- render archived history into `REPOSITORY_TIMELINE.md`
- provide chronological repository evolution summaries
- expose deterministic timeline generation from `SNAPSHOT_HISTORY.tsv`
- prepare timeline-aware repository onboarding

---

# Phase 5.2 — Evolution Signals

Add deterministic evolution signal extraction.

Tasks:

- detect repository growth signals
- detect dependency expansion signals
- detect semantic drift signals
- detect architecture change signals
- introduce `EVOLUTION_SIGNALS.tsv`

---

# Phase 5.3 — Repository Health Signals

Strengthen repository quality interpretation over time.

Tasks:

- derive repository health signals from historical snapshots
- evaluate documentation and test continuity
- evaluate execution surface stability
- introduce `REPOSITORY_HEALTH.md`

---

# CLI Evolution

Future CLI capabilities:

- snapshot timeline
- snapshot inspect-history
- snapshot health
- snapshot doctor

---

# Configuration

Introduce configurable behavior.

Tasks:

- support project-local configuration file
- support custom exclusion rules
- support custom snapshot output root
- support user-defined semantic overrides

---

# Hardening

Improve robustness and reliability.

Tasks:

- edge-case tests
- portability checks
- large repository behavior
- semantic regression tests
- release checklist
