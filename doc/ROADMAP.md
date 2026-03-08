# Roadmap

This document describes the development roadmap of the **codebase-snapshot** project.

The goal of the project is to transform software repositories into deterministic, AI-ready snapshots.

---

# Current Status

Version: 0.2.0

The snapshot engine is operational and capable of producing structured repository snapshots.

Implemented capabilities:

- deterministic repository scanning
- exclusion engine
- project tree generation
- deterministic index generation
- dependency discovery
- architecture summary generation
- documentation index generation
- language summary generation
- AI ingestion guide
- structured CODEBASE export
- automated tests

Snapshot artifacts currently produced:

PROJECT_TREE.txt  
INDEX.tsv  
DEPENDENCIES.tsv  
MANIFEST.md  
AI_INGESTION_GUIDE.md  
ARCHITECTURE.md  
DOCUMENTATION.md  
LANGUAGES.md  
LOG.txt  
SNAPSHOT_META.json  
CODEBASE/

All current tests pass.

---

# Phase 3 — Snapshot Intelligence

Goal: improve repository understanding.

## Phase 3.1 — Dependency Mapping (DONE)

Implemented:

- dependency extraction engine
- generation of DEPENDENCIES.tsv
- detection of source / import / require / include signals
- test coverage for dependency extraction

## Next Steps (Phase 3.x)

Planned improvements:

- richer architecture analysis
- entrypoint detection
- important module detection
- repository metadata summary

---

# Phase 4 — Snapshot Tooling

Improve the CLI capabilities.

Planned features:

- snapshot list
- snapshot inspect
- snapshot diff
- snapshot doctor

These commands will allow users to navigate and compare snapshots.

---

# Phase 5 — Configuration System

Allow repository-specific configuration.

Planned features:

- project configuration file (.codebase-snapshot.env)
- customizable exclusion rules
- configurable output directory

---

# Long-Term Vision

The long-term objective is to build a deterministic repository understanding layer usable by:

- AI assistants
- automated documentation tools
- code analysis systems
- development workflows

The tool must remain:

- deterministic
- portable
- shell-first
- dependency-light
