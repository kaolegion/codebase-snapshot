# Codebase Snapshot

Export any project into an AI-ready structured snapshot.

Codebase Snapshot is a deterministic, shell-first CLI tool that transforms
any software project into a structured bundle optimized for AI analysis.

Instead of forcing AI systems to explore repositories blindly,
Codebase Snapshot generates a clear, versioned and structured representation
of the entire project.

The resulting snapshot can be shared with any AI system to dramatically
accelerate project understanding.

---

## Why

Modern AI assistants analyze repositories by scanning files randomly.
This approach is slow, token-expensive and often misses architectural intent.

Codebase Snapshot solves this by generating a structured export containing:

- project architecture
- documentation
- codebase sections
- machine-readable index
- project tree
- AI ingestion guide

This enables faster and more accurate analysis by any AI.

---

## Features

- deterministic project scanning
- structured markdown exports
- machine-readable index (TSV)
- versioned snapshots
- portable shell-first CLI
- no heavy dependencies
- optimized for AI ingestion

---

## Example

snapshot .

Output:

snapshots/
└── 2026-03-08/
    └── v0.1.0/
        └── 01_initial-scan/
            ├── 00_AI_INGESTION_GUIDE.md
            ├── 01_MANIFEST.md
            ├── 02_ARCHITECTURE.md
            ├── 03_INDEX.tsv
            ├── 04_DOCUMENTATION.md
            ├── 05_CODEBASE_ROOT.md
            ├── 06_CODEBASE_BIN.md
            ├── 07_CODEBASE_CORE.md
            ├── 08_CODEBASE_LIB.md
            ├── 09_CODEBASE_MODULES.md
            ├── 10_CODEBASE_TESTS.md
            ├── 11_PROJECT_TREE.txt
            └── SNAPSHOT_META.json

---

## Philosophy

Codebase Snapshot follows a few simple principles:

- deterministic outputs
- human + machine readable
- portable and lightweight
- shell-first architecture
- AI-friendly structure
- open and extensible format

---

## Status

Early development — v0.1.0
