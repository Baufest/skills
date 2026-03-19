#!/usr/bin/env bash
# validate.sh — Validates all SKILL.md files in the skills/ directory
# Checks: frontmatter has name and description, directory name matches name field, file < 500 lines

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"
SKILLS_DIR="$REPO_ROOT/skills"

pass=0
fail=0
errors=()

for skill_dir in "$SKILLS_DIR"/*/; do
    skill_name="$(basename "$skill_dir")"
    skill_file="$skill_dir/SKILL.md"

    if [[ ! -f "$skill_file" ]]; then
        errors+=("FAIL [$skill_name]: SKILL.md not found")
        ((fail++))
        continue
    fi

    # Check line count
    line_count=$(wc -l < "$skill_file" | tr -d ' ')
    if (( line_count >= 500 )); then
        errors+=("FAIL [$skill_name]: SKILL.md is $line_count lines (must be < 500)")
        ((fail++))
        continue
    fi

    # Extract frontmatter
    frontmatter=$(sed -n '/^---$/,/^---$/p' "$skill_file")

    if [[ -z "$frontmatter" ]]; then
        errors+=("FAIL [$skill_name]: No YAML frontmatter found")
        ((fail++))
        continue
    fi

    # Extract name field from frontmatter
    fm_name=$(echo "$frontmatter" | grep -E '^name:' | head -1 | sed 's/^name:[[:space:]]*//')

    if [[ -z "$fm_name" ]]; then
        errors+=("FAIL [$skill_name]: No 'name' field in frontmatter")
        ((fail++))
        continue
    fi

    # Check name matches directory
    if [[ "$fm_name" != "$skill_name" ]]; then
        errors+=("FAIL [$skill_name]: name field '$fm_name' does not match directory name '$skill_name'")
        ((fail++))
        continue
    fi

    # Check description field exists
    has_description=$(echo "$frontmatter" | grep -cE '^description:' || true)
    if (( has_description == 0 )); then
        errors+=("FAIL [$skill_name]: No 'description' field in frontmatter")
        ((fail++))
        continue
    fi

    echo "PASS [$skill_name]: $line_count lines, name matches, frontmatter valid"
    ((pass++))
done

echo ""
echo "=== Validation Summary ==="
echo "Passed: $pass"
echo "Failed: $fail"

if (( fail > 0 )); then
    echo ""
    echo "Errors:"
    for err in "${errors[@]}"; do
        echo "  $err"
    done
    exit 1
fi

echo "All skills valid."
exit 0
