#!/usr/bin/env bash
set -euo pipefail

lint_output_file() {
    if [[ -n "${ROOT_DIR:-}" ]]; then
        printf "%s/REPOSITORY_LINT.md\n" "$ROOT_DIR"
    else
        printf "%s/REPOSITORY_LINT.md\n" "$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
    fi
}

lint_workspace_file() {
    local workspace="$1"
    local filename="$2"
    printf "%s/%s\n" "$workspace" "$filename"
}

lint_normalize_path() {
    local path="$1"
    local repo_root="${2:-}"

    path="${path#./}"
    path="${path#\$ROOT_DIR/}"
    path="${path#\$\{ROOT_DIR\}/}"

    if [[ -n "$repo_root" ]]; then
        repo_root="${repo_root%/}"

        if [[ "$path" == "$repo_root" ]]; then
            path=""
        elif [[ "$path" == "$repo_root/"* ]]; then
            path="${path#"$repo_root"/}"
        fi
    fi

    path="${path#./}"
    path="${path%/}"

    printf "%s\n" "$path"
}

lint_is_internal_target() {
    local normalized_target="$1"

    [[ -n "$normalized_target" ]] || return 1
    [[ "$normalized_target" != /* ]] || return 1
    [[ "$normalized_target" != *"://"* ]] || return 1

    case "$normalized_target" in
        bin/*|core/*|tests/*|doc/*|examples/*|tools/*|logs/*)
            return 0
            ;;
        *.sh|*.md|*.txt|*.json|*.yaml|*.yml|*.env|LICENSE|VERSION|README.md|CHANGELOG.md|CODEBASE_ROOT.md)
            return 0
            ;;
    esac

    return 1
}

lint_prefix_has_indexed_files() {
    local indexed_file="$1"
    local prefix="$2"

    [[ -n "$prefix" ]] || return 1

    awk -v prefix="$prefix" '
        {
            if ($0 == prefix) {
                found = 1
            } else if (index($0, prefix "/") == 1) {
                found = 1
            }
        }
        END {
            exit(found ? 0 : 1)
        }
    ' "$indexed_file"
}

lint_emit_signal_rows() {
    local workspace="$1"
    local repo_root="${2:-}"

    local index_file
    local dependencies_file
    local semantics_file
    local entrypoints_file
    local modules_file
    local subsystems_file
    local documentation_file

    local indexed_file
    local semantic_files
    local entrypoint_files
    local inbound_targets
    local dependency_pairs

    local markdown_count
    local test_count

    index_file="$(lint_workspace_file "$workspace" "INDEX.tsv")"
    dependencies_file="$(lint_workspace_file "$workspace" "DEPENDENCIES.tsv")"
    semantics_file="$(lint_workspace_file "$workspace" "SEMANTICS.tsv")"
    entrypoints_file="$(lint_workspace_file "$workspace" "ENTRYPOINTS.tsv")"
    modules_file="$(lint_workspace_file "$workspace" "MODULES.tsv")"
    subsystems_file="$(lint_workspace_file "$workspace" "SUBSYSTEMS.tsv")"
    documentation_file="$(lint_workspace_file "$workspace" "DOCUMENTATION.md")"

    [[ -f "$index_file" ]] || return 0

    indexed_file="$(mktemp)"
    semantic_files="$(mktemp)"
    entrypoint_files="$(mktemp)"
    inbound_targets="$(mktemp)"
    dependency_pairs="$(mktemp)"

    trap "rm -f '$indexed_file' '$semantic_files' '$entrypoint_files' '$inbound_targets' '$dependency_pairs'" RETURN

    awk -F'\t' '$1 == "FILE" { print $2 }' "$index_file" | while read -r path; do
        lint_normalize_path "$path" "$repo_root"
    done | awk 'NF > 0' | sort -u > "$indexed_file"

    if [[ -f "$semantics_file" ]]; then
        awk -F'\t' '$1 == "SEMANTIC" { print $2 }' "$semantics_file" | while read -r path; do
            lint_normalize_path "$path" "$repo_root"
        done | awk 'NF > 0' | sort -u > "$semantic_files"
    else
        : > "$semantic_files"
    fi

    if [[ -f "$entrypoints_file" ]]; then
        awk -F'\t' '$1 == "ENTRYPOINT" { print $2 }' "$entrypoints_file" | while read -r path; do
            lint_normalize_path "$path" "$repo_root"
        done | awk 'NF > 0' | sort -u > "$entrypoint_files"
    else
        : > "$entrypoint_files"
    fi

    if [[ -f "$dependencies_file" ]]; then
        awk -F'\t' '$1 == "DEPENDENCY" { print $2 "\t" $5 }' "$dependencies_file" | \
        while IFS=$'\t' read -r source target; do
            local normalized_source
            local normalized_target

            normalized_source="$(lint_normalize_path "$source" "$repo_root")"
            normalized_target="$(lint_normalize_path "$target" "$repo_root")"

            if lint_is_internal_target "$normalized_target"; then
                printf "%s\t%s\n" "$normalized_source" "$normalized_target"
            fi
        done | sort -u > "$dependency_pairs"

        awk -F'\t' '{ print $2 }' "$dependency_pairs" | awk 'NF > 0' | sort | uniq -c | \
        awk '{ print $2 "\t" $1 }' | sort > "$inbound_targets"
    else
        : > "$dependency_pairs"
        : > "$inbound_targets"
    fi

    markdown_count="$(awk '
        $0 ~ /^[^[:space:]].*\.md$/ {
            count++
        }
        END {
            print count + 0
        }
    ' "$indexed_file")"

    if (( markdown_count == 0 )); then
        printf "HIGH\tDOC_MISSING\trepository\tno markdown documentation indexed\n"
    fi

    if [[ -f "$documentation_file" ]]; then
        if ! grep -Eq '^[[:space:]]*[-*][[:space:]]+|^[[:space:]]*[0-9]+\.[[:space:]]+' "$documentation_file"; then
            if (( markdown_count == 0 )); then
                :
            else
                printf "MEDIUM\tDOC_MISSING\tdocumentation-index\tdocumentation index contains no listed documentation entries\n"
            fi
        fi
    fi

    test_count="$(awk '
        $0 ~ /^tests\/test_.*\.sh$/ {
            count++
        }
        END {
            print count + 0
        }
    ' "$indexed_file")"

    if (( test_count == 0 )); then
        printf "HIGH\tTEST_MISSING\trepository\tno deterministic test files indexed under tests/\n"
    fi

    awk '
        $0 ~ /^core\/.*\.sh$/ {
            print $0
        }
    ' "$indexed_file" | while read -r core_file; do
        local inbound_count=0

        inbound_count="$(awk -F'\t' -v file="$core_file" '
            $1 == file {
                print $2
                found = 1
            }
            END {
                if (!found) {
                    print 0
                }
            }
        ' "$inbound_targets" | tail -n 1)"

        if grep -Fxq "$core_file" "$entrypoint_files"; then
            continue
        fi

        if (( inbound_count == 0 )); then
            printf "MEDIUM\tORPHAN_MODULE\t%s\tno internal dependency points to this core module\n" "$core_file"
        fi
    done

    awk 'NF > 0 { print $0 }' "$entrypoint_files" | while read -r entry_file; do
        if ! grep -Fxq "$entry_file" "$semantic_files"; then
            printf "HIGH\tENTRYPOINT_WITHOUT_COMPONENT\t%s\tentrypoint has no semantic component mapping\n" "$entry_file"
        fi

        if ! grep -Fxq "$entry_file" "$indexed_file"; then
            printf "HIGH\tSTRUCTURE_INCONSISTENT\t%s\tentrypoint is not present in INDEX.tsv\n" "$entry_file"
        fi
    done

    awk 'NF > 0 { print $0 }' "$semantic_files" | while read -r semantic_file; do
        if ! grep -Fxq "$semantic_file" "$indexed_file"; then
            printf "HIGH\tSTRUCTURE_INCONSISTENT\t%s\tsemantic mapping points to a file absent from INDEX.tsv\n" "$semantic_file"
        fi
    done

    if [[ -f "$modules_file" ]]; then
        awk -F'\t' '$1 == "MODULE" { print $2 "\t" $3 }' "$modules_file" | \
        while IFS=$'\t' read -r module_name module_path; do
            local normalized_module_path
            normalized_module_path="$(lint_normalize_path "$module_path" "$repo_root")"

            if [[ -f "$subsystems_file" ]]; then
                if ! awk -F'\t' -v module_name="$module_name" '
                    $1 == "SUBSYSTEM" && $2 == module_name {
                        found = 1
                    }
                    END {
                        exit(found ? 0 : 1)
                    }
                ' "$subsystems_file"; then
                    printf "MEDIUM\tMODULE_WITHOUT_SUBSYSTEM\t%s\tmodule has no subsystem mapping\n" "$module_name"
                fi
            else
                printf "MEDIUM\tMODULE_WITHOUT_SUBSYSTEM\t%s\tmodule has no subsystem mapping\n" "$module_name"
            fi

            if [[ -n "$normalized_module_path" ]]; then
                if ! lint_prefix_has_indexed_files "$indexed_file" "$normalized_module_path"; then
                    printf "HIGH\tSTRUCTURE_INCONSISTENT\t%s\tmodule path has no indexed files: %s\n" "$module_name" "$normalized_module_path"
                fi
            fi
        done
    fi

    if [[ -f "$subsystems_file" ]]; then
        awk -F'\t' '$1 == "SUBSYSTEM" { print $2 "\t" $3 "\t" $4 }' "$subsystems_file" | \
        while IFS=$'\t' read -r module_name subsystem_name subsystem_path; do
            local normalized_subsystem_path
            normalized_subsystem_path="$(lint_normalize_path "$subsystem_path" "$repo_root")"

            if [[ -n "$normalized_subsystem_path" ]]; then
                if ! lint_prefix_has_indexed_files "$indexed_file" "$normalized_subsystem_path"; then
                    printf "MEDIUM\tEMPTY_SUBSYSTEM\t%s/%s\tsubsystem path has no indexed files: %s\n" \
                        "$module_name" \
                        "$subsystem_name" \
                        "$normalized_subsystem_path"
                fi
            fi
        done
    fi

    awk -F'\t' 'NF >= 2 { print $1 "\t" $2 }' "$dependency_pairs" | while IFS=$'\t' read -r source_file target_file; do
        if ! grep -Fxq "$target_file" "$indexed_file"; then
            printf "HIGH\tDEPENDENCY_UNKNOWN\t%s\treferenced by %s but absent from INDEX.tsv\n" \
                "$target_file" \
                "$source_file"
        fi
    done
}

lint_sort_rows() {
    sort -t $'\t' -k1,1 -k2,2 -k3,3
}

render_repository_lint_from_workspace() {
    local workspace="$1"
    local repo_root="${2:-}"
    local signal_rows

    signal_rows="$(lint_emit_signal_rows "$workspace" "$repo_root" | lint_sort_rows)"

    local total_signals
    local high_count
    local medium_count
    local low_count

    total_signals="$(printf '%s\n' "$signal_rows" | awk 'NF > 0 { count++ } END { print count + 0 }')"
    high_count="$(printf '%s\n' "$signal_rows" | awk -F'\t' '$1 == "HIGH" { count++ } END { print count + 0 }')"
    medium_count="$(printf '%s\n' "$signal_rows" | awk -F'\t' '$1 == "MEDIUM" { count++ } END { print count + 0 }')"
    low_count="$(printf '%s\n' "$signal_rows" | awk -F'\t' '$1 == "LOW" { count++ } END { print count + 0 }')"

    cat <<EOF_MD
# Repository Lint Signals

## Deterministic Lint Summary

- Lint signals emitted: $total_signals
- High severity signals: $high_count
- Medium severity signals: $medium_count
- Low severity signals: $low_count

## Signal Inventory

- DOC_MISSING: $(printf '%s\n' "$signal_rows" | awk -F'\t' '$2 == "DOC_MISSING" { count++ } END { print count + 0 }')
- TEST_MISSING: $(printf '%s\n' "$signal_rows" | awk -F'\t' '$2 == "TEST_MISSING" { count++ } END { print count + 0 }')
- ORPHAN_MODULE: $(printf '%s\n' "$signal_rows" | awk -F'\t' '$2 == "ORPHAN_MODULE" { count++ } END { print count + 0 }')
- ENTRYPOINT_WITHOUT_COMPONENT: $(printf '%s\n' "$signal_rows" | awk -F'\t' '$2 == "ENTRYPOINT_WITHOUT_COMPONENT" { count++ } END { print count + 0 }')
- MODULE_WITHOUT_SUBSYSTEM: $(printf '%s\n' "$signal_rows" | awk -F'\t' '$2 == "MODULE_WITHOUT_SUBSYSTEM" { count++ } END { print count + 0 }')
- EMPTY_SUBSYSTEM: $(printf '%s\n' "$signal_rows" | awk -F'\t' '$2 == "EMPTY_SUBSYSTEM" { count++ } END { print count + 0 }')
- DEPENDENCY_UNKNOWN: $(printf '%s\n' "$signal_rows" | awk -F'\t' '$2 == "DEPENDENCY_UNKNOWN" { count++ } END { print count + 0 }')
- STRUCTURE_INCONSISTENT: $(printf '%s\n' "$signal_rows" | awk -F'\t' '$2 == "STRUCTURE_INCONSISTENT" { count++ } END { print count + 0 }')

## High Severity Findings
EOF_MD

    printf '%s\n' "$signal_rows" | awk -F'\t' '
        $1 == "HIGH" {
            printf "- %s — %s — %s\n", $2, $3, $4
            found = 1
        }
        END {
            if (!found) print "- none"
        }
    '

    cat <<'EOF_MD'

## Medium Severity Findings
EOF_MD

    printf '%s\n' "$signal_rows" | awk -F'\t' '
        $1 == "MEDIUM" {
            printf "- %s — %s — %s\n", $2, $3, $4
            found = 1
        }
        END {
            if (!found) print "- none"
        }
    '

    cat <<'EOF_MD'

## Low Severity Findings
EOF_MD

    printf '%s\n' "$signal_rows" | awk -F'\t' '
        $1 == "LOW" {
            printf "- %s — %s — %s\n", $2, $3, $4
            found = 1
        }
        END {
            if (!found) print "- none"
        }
    '

    cat <<'EOF_MD'

## Deterministic Interpretation

- Report basis: INDEX.tsv, DEPENDENCIES.tsv, SEMANTICS.tsv, ENTRYPOINTS.tsv, MODULES.tsv, SUBSYSTEMS.tsv, DOCUMENTATION.md
- Analysis mode: deterministic, artifact-driven, no heuristic repository guessing
- Repository lint status: derived exclusively from structural evidence already produced by the engine
EOF_MD
}

write_repository_lint_from_workspace() {
    local workspace="$1"
    local repo_root="$2"
    local output_file="$3"

    render_repository_lint_from_workspace "$workspace" "$repo_root" > "$output_file"
    printf "%s\n" "$output_file"
}

write_repository_lint() {
    local output_file

    output_file="$(lint_output_file)"
    render_repository_lint_from_workspace "$ROOT_DIR" "$ROOT_DIR" > "$output_file"
    printf "%s\n" "$output_file"
}
