# CLI Reference

## Command

bin/snapshot --target <path> --label <label>

## Options

- --target <path>: repository root to snapshot
- --label <label>: human-readable snapshot label
- --help: show usage
- --version: print tool version

## Generated Snapshot Artifacts

A snapshot currently generates:

- PROJECT_TREE.txt
- INDEX.tsv
- DEPENDENCIES.tsv
- ARCHITECTURE.md
- DOCUMENTATION.md
- LANGUAGES.md
- MANIFEST.md
- AI_INGESTION_GUIDE.md
- LOG.txt
- SNAPSHOT_META.json
- CODEBASE/

## Notes

- Snapshot generation is deterministic.
- Exclusion rules are applied during scanning.
- DEPENDENCIES.tsv extracts dependency signals such as source, import, require and include.
- CODEBASE/ groups source files by section for AI ingestion.
