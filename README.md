# codebase-snapshot

Deterministic shell-first tool that converts any software repository into an **AI-ready structured snapshot**.

The goal is to allow humans and AI systems to **quickly understand a codebase** without navigating the entire repository.

---

# Project Status

Version: **0.2.0**

Current state:

- snapshot engine operational
- deterministic repository scanning
- AI-oriented snapshot artifacts
- modular shell architecture
- automated tests passing

---

# Vision

Modern development increasingly involves AI agents.

However, most repositories are **not structured for AI ingestion**.

`codebase-snapshot` solves this by generating a **clean, deterministic bundle** describing a repository.

The snapshot is:

- deterministic
- structured
- AI-readable
- portable
- versioned

---

# Snapshot Output

Each snapshot produces:

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

cat > /opt/kaobox/codebase-snapshot/README.md <<'EOF'
# codebase-snapshot

Deterministic shell-first tool that converts any software repository into an AI-ready structured snapshot.

The goal is to allow humans and AI systems to quickly understand a codebase without navigating the entire repository.

---

# Project Status

Version: 0.2.0

Current state:

- snapshot engine operational
- deterministic repository scanning
- AI-oriented snapshot artifacts
- modular shell architecture
- automated tests passing

---

# Vision

Modern development increasingly involves AI agents.

However, most repositories are not structured for AI ingestion.

codebase-snapshot solves this by generating a clean, deterministic bundle describing a repository.

The snapshot is:

- deterministic
- structured
- AI-readable
- portable
- versioned

---

# Snapshot Output

Each snapshot produces:

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

---

# Architecture

The project follows strict principles:

- shell-first
- deterministic processing
- CLI orchestration-only
- modular core modules
- explicit snapshot artifacts
- tests as contract

Core modules:

core/
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

---

# Usage

Basic usage:

bin/snapshot --target <repository> --label <snapshot_label>

Example:

bin/snapshot --target /opt/project --label initial_analysis

Snapshots are written to:

snapshots/YYYY-MM-DD/vX.Y.Z/<sequence>_<label>/

---

# Exclusion Engine

Ignored paths:

.git
node_modules
dist
build
__pycache__
logs
snapshots

---

# Testing

Test suite:

tests/
  run_all.sh
  test_naming.sh
  test_indexer.sh
  test_cli.sh

Run tests:

tests/run_all.sh

---

# Roadmap

Next milestone:

Phase 3 — richer snapshot intelligence

Planned features:

- improved architecture analysis
- entrypoint detection
- module detection
- dependency summarization
- snapshot inspection commands

See:

doc/ROADMAP.md

---

# License

MIT
