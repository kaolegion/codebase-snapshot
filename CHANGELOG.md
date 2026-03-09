# Changelog

All notable changes to this project will be documented in this file.

The format loosely follows Keep a Changelog principles.

---

# v0.2.1 (unreleased)

## Added

### Graph Engine (Phase 3.2)

A new structural graph module has been introduced.

New artifact:

GRAPH.tsv

This artifact describes structural relationships in the repository using a deterministic graph format.

Format:

GRAPH <source> <relation> <target>

Example relations:

- directory containment
- file roles
- dependency relations
- generated snapshot artifacts

Example entries:

GRAPH bin contains bin/snapshot  
GRAPH bin/snapshot role cli_entrypoint  
GRAPH bin/snapshot depends_on core/naming.sh  
GRAPH bin/snapshot generates GRAPH.tsv  

Purpose:

Enable AI systems to better understand repository topology and component responsibilities.

---

## Internal

- Added `core/graph.sh`
- Integrated graph generation into snapshot pipeline
- Added `tests/test_graph.sh`
- Extended CLI tests to validate GRAPH.tsv generation
- Updated snapshot ingestion guide
- Updated documentation and roadmap

---

# v0.2.0

Snapshot intelligence foundation.

Features introduced:

- architecture analysis
- documentation indexing
- language detection
- dependency extraction

Artifacts added:

ARCHITECTURE.md  
DOCUMENTATION.md  
LANGUAGES.md  
DEPENDENCIES.tsv  

---

# v0.1.0

Initial working snapshot engine.

Core capabilities:

- repository scanning
- exclusion rules
- deterministic snapshot generation
- file indexing
- codebase export
