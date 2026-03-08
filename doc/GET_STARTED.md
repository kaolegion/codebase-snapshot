# GET STARTED

This document explains how to start using **codebase-snapshot**.

The goal of this tool is to generate a **structured snapshot of a software project** that can be easily understood by both humans and AI systems.

---

# 1. Clone the repository

Example:

git clone <repository-url> codebase-snapshot
cd codebase-snapshot

Or create it locally:

mkdir -p /opt/kaobox/codebase-snapshot
cd /opt/kaobox/codebase-snapshot
git init

---

# 2. Repository structure

The project uses the following structure:

bin/
core/
doc/
examples/
tests/
logs/
snapshots/

Directory roles:

bin/        CLI entrypoints  
core/       internal modules  
doc/        documentation  
examples/   configuration examples  
tests/      automated tests  
logs/       runtime logs  
snapshots/  generated snapshot outputs  

---

# 3. Running the tool

The main command is:

bin/snapshot

Future versions may allow installation as:

snapshot

---

# 4. Example usage

Example command:

bin/snapshot --target /path/to/project --label initial

Expected output:

snapshots/YYYY-MM-DD/vX.Y.Z/01_initial/

---

# 5. Snapshot contents

A snapshot should contain files such as:

AI_INGESTION_GUIDE.md
MANIFEST.md
ARCHITECTURE.md
INDEX.tsv
DOCUMENTATION.md
CODEBASE/
PROJECT_TREE.txt
LOG.txt
SNAPSHOT_META.json

These files provide a structured description of the project.

---

# 6. Running tests

Run the full test suite with:

./tests/run_all.sh

Tests ensure:

- deterministic behavior
- stable naming rules
- correct indexing
- proper CLI behavior

---

# 7. Development workflow

Recommended development workflow:

1. update documentation when behavior changes
2. implement logic in core modules
3. keep CLI minimal
4. add tests for stable features
5. preserve deterministic outputs
