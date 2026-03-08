# ARCHITECTURE

This document describes the architecture of **codebase-snapshot**.

The project follows a **shell-first modular architecture** designed for determinism, portability, and clarity.

---

# Architectural Principles

The system is designed around four principles:

1. determinism
2. modularity
3. CLI orchestration
4. explicit outputs

If the same repository state is processed twice, the generated snapshot must remain identical.

---

# System Layers

The project is organized into several logical layers.

---

## CLI Layer

Location:

bin/

Purpose:

The CLI is responsible for:

- parsing arguments
- validating inputs
- loading configuration
- dispatching execution to core modules
- producing logs

The CLI must remain **thin**.

Business logic must never live in the CLI.

---

## Core Layer

Location:

core/

The core layer contains reusable modules implementing the snapshot logic.

Typical modules include:

logger.sh  
config.sh  
scanner.sh  
classifier.sh  
indexer.sh  
renderer.sh  
naming.sh  
utils.sh  

Each module must remain:

- deterministic
- reusable
- testable
- isolated in responsibility

---

## Documentation Layer

Location:

doc/

The documentation defines the **behavioral contract** of the system.

Important documents include:

GET_STARTED.md  
ARCHITECTURE.md  
SNAPSHOT_FORMAT.md  
CLI.md  
ROADMAP.md  

Implementation should converge toward these specifications.

---

## Test Layer

Location:

tests/

Tests ensure that the system remains deterministic and stable.

They validate:

- naming rules
- indexing behavior
- CLI behavior
- deterministic ordering

Tests act as a **contract protecting expected behavior**.

---

## Runtime Outputs

Location:

logs/  
snapshots/

These directories contain generated runtime artifacts.

They must remain separate from implementation code.

---

# Execution Flow

A typical snapshot execution should follow these steps:

1. read tool version
2. load configuration
3. validate target repository
4. normalize snapshot label
5. compute output path
6. scan repository deterministically
7. classify files
8. generate index
9. render documentation artifacts
10. generate metadata
11. write logs

---

# Determinism Rules

To ensure reproducibility, the following rules must be respected:

- file discovery must use stable ordering
- scanning should rely on `find` + `sort`
- naming must be normalized
- exclusions must be explicit
- output structure must remain predictable

---

# Non-Goals

The project should not become:

- a heavy static analysis engine
- a language-specific parser framework
- a complex archiving tool

Its purpose is to remain a **lightweight deterministic snapshot generator**.
