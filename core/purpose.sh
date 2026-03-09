#!/usr/bin/env bash
set -euo pipefail

detect_repository_purpose() {
    local target_dir="$1"

    [[ -d "$target_dir" ]] || {
        echo "[ERROR] Directory not found: $target_dir" >&2
        return 1
    }

    local file
    local rel

    local cli_count=0
    local app_count=0
    local service_count=0
    local docs_count=0
    local tests_count=0
    local config_count=0
    local core_count=0
    local total_files=0

    while IFS= read -r file; do
        [[ -n "$file" ]] || continue
        total_files=$((total_files + 1))
        rel="${file#$target_dir/}"

        case "$rel" in
            bin/*|cmd/*)
                cli_count=$((cli_count + 1))
                ;;
        esac

        case "$rel" in
            main.*|*/main.*|app.*|*/app.*)
                app_count=$((app_count + 1))
                ;;
        esac

        case "$rel" in
            server.*|*/server.*|docker-compose.yml|*/docker-compose.yml)
                service_count=$((service_count + 1))
                ;;
        esac

        case "$rel" in
            tests/*|test/*|*/tests/*|*/test/*)
                tests_count=$((tests_count + 1))
                ;;
        esac

        case "$rel" in
            core/*|src/*|lib/*|*/core/*|*/src/*|*/lib/*)
                core_count=$((core_count + 1))
                ;;
        esac

        case "$rel" in
            *.md|doc/*|docs/*|*/doc/*|*/docs/*)
                docs_count=$((docs_count + 1))
                ;;
        esac

        case "$rel" in
            *.yml|*.yaml|*.json|*.toml|*.ini|*.env|config/*|configs/*|*/config/*|*/configs/*)
                config_count=$((config_count + 1))
                ;;
        esac
    done < <(scan_files "$target_dir")

    local classification="unknown"
    local role="undetermined"
    local execution_profile="no clear execution profile detected"

    if (( cli_count > 0 )) && (( cli_count >= app_count )) && (( cli_count >= service_count )); then
        classification="cli_tool"
        role="repository exposes one or more command-line entry surfaces"
        execution_profile="command-line oriented"
    elif (( service_count > 0 )) && (( service_count >= app_count )); then
        classification="service"
        role="repository appears to expose a long-running or orchestrated service surface"
        execution_profile="service or orchestration oriented"
    elif (( app_count > 0 )); then
        classification="application"
        role="repository appears to expose an application entry surface"
        execution_profile="application oriented"
    elif (( docs_count > 0 )) && (( docs_count == total_files )); then
        classification="documentation_repository"
        role="repository is primarily documentation"
        execution_profile="documentation oriented"
    elif (( tests_count > 0 )) && (( tests_count >= core_count )) && (( tests_count >= cli_count )); then
        classification="test_repository"
        role="repository is strongly test-oriented"
        execution_profile="test oriented"
    elif (( config_count > 0 )) && (( config_count >= core_count )) && (( config_count >= docs_count )); then
        classification="configuration_repository"
        role="repository is strongly configuration-oriented"
        execution_profile="configuration oriented"
    fi

    if (( cli_count > 0 )) && (( app_count > 0 || service_count > 0 )); then
        classification="multi_purpose"
        role="repository exposes multiple strong execution patterns"
        execution_profile="mixed execution surfaces detected"
    fi

    cat <<EOF_SUMMARY
# Repository Purpose Summary

Primary classification:
$classification

Operational role:
$role

Execution profile:
$execution_profile

Deterministic signals:
- cli_count: $cli_count
- application_count: $app_count
- service_count: $service_count
- docs_count: $docs_count
- tests_count: $tests_count
- config_count: $config_count
- core_count: $core_count
- total_files: $total_files

Interpretation notes:
- This summary is deterministic and rule-based.
- No probabilistic inference is used.
- The result is derived from repository structure and naming signals only.
EOF_SUMMARY
}
