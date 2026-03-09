#!/usr/bin/env bash
set -euo pipefail

detect_entrypoint_kind() {
    local target_dir="$1"
    local file="$2"
    local base
    local relative

    base="$(basename "$file")"
    relative="${file#$target_dir/}"

    case "$base" in
        Makefile)
            printf 'build\n'
            return 0
            ;;
        docker-compose.yml|docker-compose.yaml|compose.yml|compose.yaml)
            printf 'runtime\n'
            return 0
            ;;
    esac

    case "$relative" in
        */bin/*|bin/*)
            printf 'cli\n'
            return 0
            ;;
        */cmd/*|cmd/*)
            printf 'cli\n'
            return 0
            ;;
    esac

    case "$base" in
        main.py|main.sh|main.js|main.ts|main.go)
            printf 'application\n'
            return 0
            ;;
        app.py|app.js|app.ts)
            printf 'application\n'
            return 0
            ;;
        server.py|server.js|server.ts)
            printf 'service\n'
            return 0
            ;;
    esac

    if [[ "$relative" != */* && "$base" == *.sh && -f "$file" ]]; then
        if head -n 1 "$file" | grep -q '^#!'; then
            printf 'script\n'
            return 0
        fi
    fi

    return 1
}

detect_entrypoint_rule() {
    local target_dir="$1"
    local file="$2"
    local base
    local relative

    base="$(basename "$file")"
    relative="${file#$target_dir/}"

    case "$base" in
        Makefile)
            printf 'filename:Makefile\n'
            return 0
            ;;
        docker-compose.yml)
            printf 'filename:docker-compose.yml\n'
            return 0
            ;;
        docker-compose.yaml)
            printf 'filename:docker-compose.yaml\n'
            return 0
            ;;
        compose.yml)
            printf 'filename:compose.yml\n'
            return 0
            ;;
        compose.yaml)
            printf 'filename:compose.yaml\n'
            return 0
            ;;
    esac

    case "$relative" in
        */bin/*|bin/*)
            printf 'path:bin\n'
            return 0
            ;;
        */cmd/*|cmd/*)
            printf 'path:cmd\n'
            return 0
            ;;
    esac

    case "$base" in
        main.py)
            printf 'filename:main.py\n'
            return 0
            ;;
        main.sh)
            printf 'filename:main.sh\n'
            return 0
            ;;
        main.js)
            printf 'filename:main.js\n'
            return 0
            ;;
        main.ts)
            printf 'filename:main.ts\n'
            return 0
            ;;
        main.go)
            printf 'filename:main.go\n'
            return 0
            ;;
        app.py)
            printf 'filename:app.py\n'
            return 0
            ;;
        app.js)
            printf 'filename:app.js\n'
            return 0
            ;;
        app.ts)
            printf 'filename:app.ts\n'
            return 0
            ;;
        server.py)
            printf 'filename:server.py\n'
            return 0
            ;;
        server.js)
            printf 'filename:server.js\n'
            return 0
            ;;
        server.ts)
            printf 'filename:server.ts\n'
            return 0
            ;;
    esac

    if [[ "$relative" != */* && "$base" == *.sh && -f "$file" ]]; then
        if head -n 1 "$file" | grep -q '^#!'; then
            printf 'root-shebang:sh\n'
            return 0
        fi
    fi

    return 1
}

is_entrypoint() {
    local target_dir="$1"
    local file="$2"

    detect_entrypoint_kind "$target_dir" "$file" >/dev/null 2>&1
}

generate_entrypoints() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || {
        echo "[ERROR] Directory not found: $target_dir" >&2
        return 1
    }

    if ! declare -F scan_files >/dev/null 2>&1; then
        echo "[ERROR] scan_files not available" >&2
        return 1
    fi

    while IFS= read -r file; do
        local kind
        local rule

        if ! kind="$(detect_entrypoint_kind "$target_dir" "$file")"; then
            continue
        fi

        rule="$(detect_entrypoint_rule "$target_dir" "$file")"

        printf 'ENTRYPOINT\t%s\t%s\t%s\n' "$file" "$kind" "$rule"
    done < <(scan_files "$target_dir")
}
