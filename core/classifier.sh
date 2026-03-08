#!/usr/bin/env bash
set -euo pipefail

classify_file() {
    local file="$1"

    case "$file" in
        */bin/*|bin/*)
            printf 'SCRIPT\n'
            ;;
        *.sh)
            printf 'SCRIPT\n'
            ;;
        */tests/*|tests/*)
            printf 'TEST\n'
            ;;
        *.md)
            printf 'DOC\n'
            ;;
        *.json)
            printf 'DATA\n'
            ;;
        *.yml|*.yaml|*.env)
            printf 'CONFIG\n'
            ;;
        *)
            printf 'FILE\n'
            ;;
    esac
}
