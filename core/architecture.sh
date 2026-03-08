#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$ROOT_DIR/core/scanner.sh"

count_section_files() {
    local target_dir="$1"
    local section="$2"

    scan_files "$target_dir" | while read -r file; do
        case "$file" in
            */"$section"/*|"$target_dir"/"$section"/*)
                printf '%s\n' "$file"
                ;;
        esac
    done | wc -l | tr -d ' '
}

render_architecture() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || {
        echo "[ERROR] Directory not found: $target_dir" >&2
        return 1
    }

    local bin_count core_count tests_count doc_count examples_count total_count
    bin_count="$(count_section_files "$target_dir" "bin")"
    core_count="$(count_section_files "$target_dir" "core")"
    tests_count="$(count_section_files "$target_dir" "tests")"
    doc_count="$(count_section_files "$target_dir" "doc")"
    examples_count="$(count_section_files "$target_dir" "examples")"
    total_count="$(scan_files "$target_dir" | wc -l | tr -d ' ')"

    cat <<ARCH
# Architecture Summary

This file was generated automatically by **codebase-snapshot**.

## Overview

The repository is analyzed as a deterministic shell-first project snapshot.

Included file count: $total_count

## Major Directories

- bin/ : CLI entrypoints ($bin_count files)
- core/ : reusable implementation modules ($core_count files)
- tests/ : automated validation scripts ($tests_count files)
- doc/ : project documentation ($doc_count files)
- examples/ : sample configuration and usage files ($examples_count files)

## Interpretation

The project follows a modular structure where:

- CLI entrypoints are expected under bin/
- reusable logic lives under core/
- validation is isolated in tests/
- specifications and usage docs live in doc/
- sample inputs live in examples/

## Design Signals

This repository appears to follow these architectural patterns:

- separation between interface and implementation
- explicit documentation
- test-oriented stabilization
- deterministic file processing
- snapshot-oriented output design
ARCH
}
