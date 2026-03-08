# CODEBASE ROOT

This repository contains the **codebase-snapshot** project.

The purpose of this tool is to transform any software repository into a **structured snapshot bundle** that is easy to understand for both humans and AI systems.

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
• builds structured documentation  
• exports a reproducible snapshot  

The output snapshot becomes a **portable knowledge bundle** describing the project.

---

# Key Directories

## bin/

CLI entrypoints.

These scripts expose commands used by the user.

Example:

bin/snapshot

---

## core/

Contains the internal modules implementing the snapshot logic.

Typical modules include:

- scanner
- indexer
- classifier
- renderer
- naming
- logger

These modules must remain deterministic and reusable.

---

## doc/

Project specifications and documentation.

This directory defines the intended behavior of the system.

---

## tests/

Automated tests protecting stable behavior.

Tests validate:

- naming rules
- indexing
- CLI behavior
- deterministic ordering

---

## examples/

Example configurations.

---

## logs/

Execution logs.

---

## snapshots/

Generated snapshot bundles.

These are runtime artifacts and should not pollute source code.

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

- deterministic scanning
- stable sorting
- explicit exclusions
- normalized output naming
- predictable snapshot layout

If the same repository state is processed twice, the snapshot structure must remain identical.
