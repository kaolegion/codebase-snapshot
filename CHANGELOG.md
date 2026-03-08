# Changelog

All notable changes to this project will be documented in this file.

The format loosely follows the Keep a Changelog style.

---

## v0.2.0 — Snapshot Intelligence Foundation

Release date: 2026-03-08

Major milestone: snapshot engine operational.

### Added

- deterministic snapshot generation
- exclusion engine
- architecture summary generation
- documentation index generation
- language summary generation
- AI ingestion guide
- structured CODEBASE export

### Snapshot Artifacts

Snapshots now include:

PROJECT_TREE.txt  
INDEX.tsv  
MANIFEST.md  
AI_INGESTION_GUIDE.md  
ARCHITECTURE.md  
DOCUMENTATION.md  
LANGUAGES.md  
LOG.txt  
SNAPSHOT_META.json  

CODEBASE/

Structure:

CODEBASE/
  01_cli.md
  02_core.md
  03_tests.md
  04_docs.md

### Core Modules

The following core modules were implemented:

naming.sh  
scanner.sh  
indexer.sh  
classifier.sh  
renderer.sh  
logger.sh  
utils.sh  
config.sh  
architecture.sh  
documentation.sh  
languages.sh  

### Testing

Automated tests implemented:

tests/run_all.sh  
tests/test_naming.sh  
tests/test_indexer.sh  
tests/test_cli.sh  

All tests passing.

---

## v0.1.0 — Initial Snapshot Engine

Initial project bootstrap.

Implemented:

- repository structure
- CLI skeleton
- core module layout
- initial snapshot generation
