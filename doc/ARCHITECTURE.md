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
- assembling snapshot artifacts

The CLI must remain **thin**.

Business logic must never live in the CLI.

---

## Core Layer

Location:

core/

The core layer contains reusable modules implementing the snapshot logic.

Current modules include:

naming.sh  
utils.sh  
scanner.sh  
indexer.sh  
architecture.sh  
documentation.sh  
languages.sh  
dependencies.sh  
logger.sh  
config.sh  
classifier.sh  
renderer.sh  

Each module must remain:

- deterministic
- reusable
- testable
- isolated in responsibility

Example responsibilities:

scanner.sh  
→ deterministic file discovery

indexer.sh  
→ generation of INDEX.tsv

architecture.sh  
→ repository architecture summary

documentation.sh  
→ extraction of documentation metadata

languages.sh  
→ language and file type detection

dependencies.sh  
→ dependency signal extraction

naming.sh  
→ snapshot naming normalization

utils.sh  
→ shared helpers

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
- dependency extraction
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

A typical snapshot execution follows these steps:

1. read tool version
2. validate target repository
3. normalize snapshot label
4. compute snapshot output path
5. scan repository deterministically
6. generate PROJECT_TREE.txt
7. generate INDEX.tsv
8. extract dependency signals
9. render architecture summary
10. generate documentation index
11. detect language summary
12. assemble CODEBASE export
13. generate metadata
14. write logs

---

# Determinism Rules

To ensure reproducibility, the following rules must be respected:

- file discovery must use stable ordering
- scanning must rely on `find` + `sort`
- naming must be normalized
- exclusions must be explicit
- output structure must remain predictable

Running the snapshot twice on the same repository state must produce identical structural outputs.

---

# Non-Goals

The project should not become:

- a heavy static analysis engine
- a language-specific parser framework
- a complex archiving tool

Its purpose is to remain a **lightweight deterministic snapshot generator**.
