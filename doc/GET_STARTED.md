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

Expected output directory:

snapshots/YYYY-MM-DD/vX.Y.Z/01_initial/

Example snapshot contents:

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

---

# 6. Snapshot purpose

Snapshots provide a **portable structured representation of a repository**.

They allow:

- fast repository exploration
- AI-assisted repository understanding
- architecture discovery
- dependency signal extraction
- semantic component mapping
- entrypoint identification

---

# 7. Running tests

Run the full test suite with:

./tests/run_all.sh

Tests ensure:

- deterministic behavior
- stable naming rules
- correct indexing
- dependency extraction
- graph generation
- semantic component detection
- entrypoint detection
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

Following these practices helps maintain a deterministic and predictable system.
