#!/usr/bin/env bash
set -euo pipefail

policy_output_file() {
    if [[ -n "${ROOT_DIR:-}" ]]; then
        printf "%s/REPOSITORY_POLICY.md\n" "$ROOT_DIR"
    else
        printf "%s/REPOSITORY_POLICY.md\n" "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
    fi
}

policy_repo_root() {
    if [[ -n "${ROOT_DIR:-}" ]]; then
        printf "%s\n" "$ROOT_DIR"
    else
        cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd
    fi
}

policy_has_file() {
    local relative_path="$1"
    local repo_root

    repo_root="$(policy_repo_root)"

    [[ -f "$repo_root/$relative_path" ]]
}

policy_signal_status() {
    local count="$1"

    if (( count > 0 )); then
        printf "Present\n"
    else
        printf "Missing\n"
    fi
}

policy_line_count() {
    local relative_path="$1"
    local repo_root

    repo_root="$(policy_repo_root)"

    if [[ -f "$repo_root/$relative_path" ]]; then
        awk 'END { print NR + 0 }' "$repo_root/$relative_path"
    else
        printf "0\n"
    fi
}

policy_count_matches() {
    local relative_path="$1"
    local pattern="$2"
    local repo_root

    repo_root="$(policy_repo_root)"

    if [[ -f "$repo_root/$relative_path" ]]; then
        grep -Eic "$pattern" "$repo_root/$relative_path" || true
    else
        printf "0\n"
    fi
}

policy_count_release_tags() {
    local repo_root

    repo_root="$(policy_repo_root)"

    if [[ -d "$repo_root/.git" ]]; then
        if git -C "$repo_root" rev-parse --git-dir >/dev/null 2>&1; then
            git -C "$repo_root" tag 2>/dev/null | awk 'NF > 0 { count++ } END { print count + 0 }'
        else
            printf "0\n"
        fi
    else
        printf "0\n"
    fi
}

policy_count_release_sections() {
    local changelog_file="CHANGELOG.md"

    if policy_has_file "$changelog_file"; then
        grep -Ec '^##[[:space:]]+v?[0-9]+\.[0-9]+\.[0-9]+' "$(policy_repo_root)/$changelog_file" || true
    else
        printf "0\n"
    fi
}

policy_current_version() {
    local repo_root

    repo_root="$(policy_repo_root)"

    if [[ -f "$repo_root/VERSION" ]]; then
        tr -d '\r' < "$repo_root/VERSION"
    else
        printf "unknown\n"
    fi
}

policy_count_test_files() {
    local repo_root

    repo_root="$(policy_repo_root)"

    if [[ -d "$repo_root/tests" ]]; then
        find "$repo_root/tests" -maxdepth 1 -type f -name 'test_*.sh' | wc -l | tr -d ' '
    else
        printf "0\n"
    fi
}

policy_release_discipline_status() {
    local version_present="$1"
    local changelog_present="$2"
    local release_sections="$3"
    local release_tags="$4"

    if (( version_present > 0 )) && (( changelog_present > 0 )) && (( release_sections > 0 )); then
        if (( release_tags > 0 )); then
            printf "Present\n"
        else
            printf "Partial\n"
        fi
    elif (( version_present > 0 )) || (( changelog_present > 0 )); then
        printf "Partial\n"
    else
        printf "Missing\n"
    fi
}

policy_testing_governance_status() {
    local tests_dir_present="$1"
    local run_all_present="$2"
    local test_file_count="$3"

    if (( tests_dir_present > 0 )) && (( run_all_present > 0 )) && (( test_file_count > 0 )); then
        printf "Present\n"
    elif (( tests_dir_present > 0 )) || (( run_all_present > 0 )) || (( test_file_count > 0 )); then
        printf "Partial\n"
    else
        printf "Missing\n"
    fi
}

policy_documentation_governance_status() {
    local readme_present="$1"
    local roadmap_present="$2"
    local protocol_present="$3"

    if (( readme_present > 0 )) && (( roadmap_present > 0 )) && (( protocol_present > 0 )); then
        printf "Present\n"
    elif (( readme_present > 0 )) || (( roadmap_present > 0 )) || (( protocol_present > 0 )); then
        printf "Partial\n"
    else
        printf "Missing\n"
    fi
}

policy_emit_evidence_lines() {
    local repo_root
    repo_root="$(policy_repo_root)"

    local path

    for path in \
        LICENSE \
        CHANGELOG.md \
        README.md \
        VERSION \
        tests/run_all.sh \
        doc/ROADMAP.md \
        doc/DEVELOPMENT_PROTOCOL.md \
        CONTRIBUTING.md \
        CODE_OF_CONDUCT.md
    do
        if [[ -f "$repo_root/$path" ]]; then
            printf -- "- %s\n" "$path"
        fi
    done
}

render_repository_policy() {
    local license_present=0
    local changelog_present=0
    local contributing_present=0
    local code_of_conduct_present=0
    local protocol_present=0
    local roadmap_present=0
    local readme_present=0
    local version_present=0
    local tests_dir_present=0
    local run_all_present=0

    local release_tags=0
    local release_sections=0
    local test_file_count=0

    local changelog_release_mentions=0
    local readme_version_mentions=0

    policy_has_file "LICENSE" && license_present=1
    policy_has_file "CHANGELOG.md" && changelog_present=1
    policy_has_file "CONTRIBUTING.md" && contributing_present=1
    policy_has_file "CODE_OF_CONDUCT.md" && code_of_conduct_present=1
    policy_has_file "doc/DEVELOPMENT_PROTOCOL.md" && protocol_present=1
    policy_has_file "doc/ROADMAP.md" && roadmap_present=1
    policy_has_file "README.md" && readme_present=1
    policy_has_file "VERSION" && version_present=1
    [[ -d "$(policy_repo_root)/tests" ]] && tests_dir_present=1
    policy_has_file "tests/run_all.sh" && run_all_present=1

    release_tags="$(policy_count_release_tags)"
    release_sections="$(policy_count_release_sections)"
    test_file_count="$(policy_count_test_files)"

    changelog_release_mentions="$(policy_count_matches "CHANGELOG.md" '^##[[:space:]]+v?[0-9]+\.[0-9]+\.[0-9]+')"
    readme_version_mentions="$(policy_count_matches "README.md" 'Version:[[:space:]]+\*\*v?[0-9]+\.[0-9]+\.[0-9]+\*\*')"

    local license_status
    local changelog_status
    local contribution_status
    local protocol_status
    local roadmap_status
    local release_status
    local testing_status
    local documentation_status

    license_status="$(policy_signal_status "$license_present")"
    changelog_status="$(policy_signal_status "$changelog_present")"

    if (( contributing_present > 0 )) && (( code_of_conduct_present > 0 )); then
        contribution_status="Present"
    elif (( contributing_present > 0 )) || (( code_of_conduct_present > 0 )); then
        contribution_status="Partial"
    else
        contribution_status="Missing"
    fi

    protocol_status="$(policy_signal_status "$protocol_present")"
    roadmap_status="$(policy_signal_status "$roadmap_present")"
    release_status="$(policy_release_discipline_status "$version_present" "$changelog_present" "$release_sections" "$release_tags")"
    testing_status="$(policy_testing_governance_status "$tests_dir_present" "$run_all_present" "$test_file_count")"
    documentation_status="$(policy_documentation_governance_status "$readme_present" "$roadmap_present" "$protocol_present")"

    cat <<EOF_MD
# Repository Policy

## Deterministic Policy Summary

- License policy: $license_status
- Changelog policy: $changelog_status
- Contribution guidance: $contribution_status
- Development protocol: $protocol_status
- Roadmap policy: $roadmap_status
- Release discipline: $release_status
- Testing governance: $testing_status
- Documentation governance: $documentation_status

## Governance Signals

- LICENSE present: $( [[ "$license_present" == "1" ]] && printf "yes" || printf "no" )
- CHANGELOG.md present: $( [[ "$changelog_present" == "1" ]] && printf "yes" || printf "no" )
- CONTRIBUTING.md present: $( [[ "$contributing_present" == "1" ]] && printf "yes" || printf "no" )
- CODE_OF_CONDUCT.md present: $( [[ "$code_of_conduct_present" == "1" ]] && printf "yes" || printf "no" )
- doc/DEVELOPMENT_PROTOCOL.md present: $( [[ "$protocol_present" == "1" ]] && printf "yes" || printf "no" )
- doc/ROADMAP.md present: $( [[ "$roadmap_present" == "1" ]] && printf "yes" || printf "no" )
- README.md present: $( [[ "$readme_present" == "1" ]] && printf "yes" || printf "no" )
- VERSION present: $( [[ "$version_present" == "1" ]] && printf "yes" || printf "no" )
- tests/ directory present: $( [[ "$tests_dir_present" == "1" ]] && printf "yes" || printf "no" )
- tests/run_all.sh present: $( [[ "$run_all_present" == "1" ]] && printf "yes" || printf "no" )

## Release Discipline Evidence

- Current VERSION value: $(policy_current_version)
- Release sections in CHANGELOG.md: $release_sections
- Git tags observed: $release_tags
- README version mentions: $readme_version_mentions

## Testing Governance Evidence

- Deterministic test files under tests/: $test_file_count
- tests/run_all.sh line count: $(policy_line_count "tests/run_all.sh")

## Documentation Governance Evidence

- README.md line count: $(policy_line_count "README.md")
- doc/ROADMAP.md line count: $(policy_line_count "doc/ROADMAP.md")
- doc/DEVELOPMENT_PROTOCOL.md line count: $(policy_line_count "doc/DEVELOPMENT_PROTOCOL.md")
- CHANGELOG release headings detected: $changelog_release_mentions

## Repository-Visible Evidence
EOF_MD

    policy_emit_evidence_lines

    cat <<'EOF_MD'

## Deterministic Interpretation

- Policy signals are derived only from repository-visible files and Git tag presence.
- Presence signals indicate explicit governance artifacts available in the repository.
- Partial signals indicate incomplete but visible governance structure.
- Missing signals indicate no direct repository-visible evidence for that policy area.
- No speculative governance intent is inferred beyond explicit evidence.
EOF_MD
}

write_repository_policy() {
    local output_file

    output_file="$(policy_output_file)"
    render_repository_policy > "$output_file"
    printf "%s\n" "$output_file"
}
