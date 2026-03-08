#!/usr/bin/env bash
set -euo pipefail

load_config() {
    local config_file="$1"

    [[ -f "$config_file" ]] || {
        echo "[ERROR] Config file not found: $config_file" >&2
        return 1
    }

    while IFS='=' read -r key value; do
        [[ -z "$key" ]] && continue
        [[ "$key" =~ ^# ]] && continue

        value="${value%\"}"
        value="${value#\"}"

        export "$key=$value"

    done < "$config_file"
}
