# CODEBASE ROOT

This repository contains the **codebase-snapshot** project.

The purpose of this tool is to transform any software repository into a **structured snapshot bundle** that is easy to understand for both humans and AI systems.

The snapshot provides a deterministic, portable description of a codebase including its structure, dependencies, architecture, and execution entrypoints.

---

# Reading Order

When exploring this repository, the recommended reading order is:

1. README.md
2. doc/GET_STARTED.md
3. doc/ARCHITECTURE.md
4. doc/SNAPSHOT_FORMAT.md
5. doc/CLI.md
6. doc/ROADMAP.md
7. bin/snapshot
8. core/

---

# Project Purpose

The project provides a deterministic tool that:

• scans a repository  
• classifies files  
• generates indexes  
• extracts architecture information  
• analyzes documentation  
• detects programming languages  
• extracts dependencies  
• builds a repository graph  
• detects semantic repository components  
• detects repository entrypoints  
• exports a reproducible snapshot bundle  

The output snapshot becomes a **portable knowledge bundle** describing the repository.

---

# Key Directories

## bin/

CLI entrypoints.

These scripts expose commands used by the user.

Example:

bin/snapshot

The CLI layer must remain **orchestration-only**.

Business logic must never be implemented in CLI scripts.

---

## core/

Contains the internal modules implementing the snapshot logic.

Core modules currently include:

architecture.sh  
classifier.sh  
config.sh  
dependencies.sh  
documentation.sh  
entrypoints.sh  
graph.sh  
indexer.sh  
languages.sh  
logger.sh  
naming.sh  
renderer.sh  
scanner.sh  
semantics.sh  
utils.sh  

These modules implement deterministic repository analysis and artifact generation.

---

## doc/

Project specifications and documentation.

This directory defines the intended behavior of the system.

Documentation acts as a **contract describing system behavior**.

---

## tests/

Automated tests protecting stable behavior.

Tests validate:

- naming rules
- indexing
- dependency extraction
- graph generation
- semantic detection
- entrypoint detection
- CLI behavior

---

## examples/

Example configurations and usage examples.

---

## logs/

Execution logs generated during development and testing.

---

## snapshots/

Generated snapshot bundles.

Snapshots are organized by date and version.

Example layout:

snapshots/YYYY-MM-DD/vX.Y.Z/<sequence>_<label>/

Snapshots are **runtime artifacts**, not source code.

---

# Snapshot Artifacts

A snapshot contains structured artifacts describing the repository.

Typical artifacts include:

PROJECT_TREE.txt  
INDEX.tsv  
DEPENDENCIES.tsv  
GRAPH.tsv  
SEMANTICS.tsv  
ENTRYPOINTS.tsv  
ARCHITECTURE.md  
DOCUMENTATION.md  
LANGUAGES.md  
COMPONENTS.md  
MANIFEST.md  
AI_INGESTION_GUIDE.md  
LOG.txt  
SNAPSHOT_META.json  

CODEBASE/

These artifacts allow humans and AI systems to understand a repository quickly.

---

# Design Rule

The architecture follows one simple rule:

CLI orchestrates.  
Core implements.  
Tests validate.  
Documentation defines the contract.

---

# Determinism Requirement

The project must guarantee reproducibility.

This means:

- deterministic repository scanning
- stable file ordering
- explicit exclusion rules
- normalized artifact generation
- predictable snapshot layout

If the same repository state is processed twice, the snapshot structure must remain identical.
