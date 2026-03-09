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
tools/
logs/
snapshots/

Directory roles:

bin/        CLI entrypoints
core/       internal modules
doc/        documentation
examples/   configuration examples
tests/      automated tests
tools/      development utilities
logs/       runtime logs
snapshots/  generated snapshot outputs

---

# 3. Fix permissions after clone

Some environments may not preserve executable permissions as expected.

To restore the expected executable bits, run:

./tools/fix-permissions.sh

This ensures the CLI and test scripts can be executed directly.

---

# 4. Running the tool

The main command is:

bin/snapshot

Future versions may allow installation as:

snapshot

---

# 5. Example usage

Example command:

bin/snapshot --target /path/to/project --label initial

Expected output:

snapshots/YYYY-MM-DD/vX.Y.Z/01_initial/

---

# 6. Snapshot contents

A snapshot should contain files such as:

AI_INGESTION_GUIDE.md
MANIFEST.md
ARCHITECTURE.md
PROJECT_TREE.txt
INDEX.tsv
DEPENDENCIES.tsv
DOCUMENTATION.md
LANGUAGES.md
LOG.txt
SNAPSHOT_META.json
CODEBASE/

These files provide a structured description of the project.

---

# 7. Running tests

Run the full test suite with:

./tests/run_all.sh

Tests ensure:

- deterministic behavior
- stable naming rules
- correct indexing
- dependency extraction
- proper CLI behavior

---

# 8. Development workflow

Recommended development workflow:

1. update documentation when behavior changes
2. implement logic in core modules
3. keep CLI minimal
4. add tests for stable features
5. preserve deterministic outputs
6. ensure executable scripts keep the correct permissions
