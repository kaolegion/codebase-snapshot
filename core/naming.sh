#!/usr/bin/env bash
set -euo pipefail

normalize_label() {
    local raw="${1:-}"

    raw="$(printf '%s' "$raw" | tr '[:upper:]' '[:lower:]')"
    raw="$(printf '%s' "$raw" | sed 's/[^a-z0-9]/_/g')"
    raw="$(printf '%s' "$raw" | sed 's/_\+/_/g')"
    raw="$(printf '%s' "$raw" | sed 's/^_//; s/_$//')"

    printf '%s\n' "$raw"
}
