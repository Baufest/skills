# Contributing to Baufest Skills

This guide covers how to author, test, and register new skills in the Baufest skills repository.

## Creating a New Skill

### 1. Copy the template

```bash
cp -r template skills/your-skill-name
mv skills/your-skill-name/SKILL.md skills/your-skill-name/SKILL.md
```

### 2. Fill in the frontmatter

Edit `skills/your-skill-name/SKILL.md`:

```yaml
---
name: your-skill-name          # Must match the directory name exactly
description: >-
  What this skill does and when to trigger it...
license: Apache-2.0
metadata:
  author: baufest
  version: "1.0"
---
```

The `name` field **must** match the directory name. This is validated by the repo's validation script.

### 3. Write the instructions

The markdown body of SKILL.md contains the instructions the agent will follow. Keep it under 500 lines. Structure it with:

- **Overview**: What the skill enables
- **When to Use**: Trigger contexts
- **Instructions**: Step-by-step workflow
- **Output Format**: What the deliverable looks like
- **References**: Pointers to supporting files (if any)

### 4. Add supporting files (optional)

| Directory | Purpose | When to use |
|-----------|---------|-------------|
| `references/` | Detailed schemas, templates, domain docs | When the SKILL.md body would exceed 500 lines without them |
| `examples/` | Output format exemplars | When the skill routes to different output formats |
| `scripts/` | Executable helpers | When the skill needs deterministic code execution |
| `assets/` | Templates, images, static files | When the skill references non-markdown assets |

## Writing Good Descriptions

The `description` field is the primary trigger mechanism. Agents see only the name and description at discovery time and decide whether to load the full skill based on this alone.

### Rules

1. **Lead with what the skill does** — one clear sentence
2. **Enumerate trigger contexts** — specific phrases, keywords, and situations
3. **Include disambiguation** — when NOT to use (prevents false triggers)
4. **Be slightly pushy** — err toward triggering when borderline relevant
5. **Stay under ~150 words** — fits within the ~100 token discovery budget

### Template

```
[What it does — one sentence]. Use this skill when [trigger context 1],
[trigger context 2], or [trigger context 3]. Also triggers for [related
keywords and phrases users would actually say]. Do NOT use for [similar
but different tasks — point to the correct skill if one exists].
```

### Example (good)

```
Draft structured Architecture Decision Records (ADRs) with options analysis,
tradeoffs, and a clear recommendation. Use this skill when making technology
choices, evaluating build-vs-buy, selecting platforms, or documenting any
architectural decision. Also use when asked for a "decision doc", "options
analysis", or "tech evaluation". Do NOT use for project plans, delivery
status reports, or general technical documentation.
```

## Progressive Disclosure

Skills follow a three-level progressive disclosure model:

| Level | Content | Token Budget | When Loaded |
|-------|---------|-------------|-------------|
| 1 | Name + description | ~100 tokens | Always in agent context |
| 2 | SKILL.md body | < 5000 tokens | When skill is triggered |
| 3 | References, scripts, assets | Varies | On demand from SKILL.md pointers |

This model keeps agent context lean while enabling deep, specialized behavior. Design your skill to work within these constraints.

## Testing Your Skill

1. Write 2–3 realistic test prompts that should trigger your skill
2. In Claude Code: start a new session, install the skill, run your prompts
3. Evaluate:
   - Did the skill trigger correctly?
   - Did the agent follow the instructions?
   - Was the output structured and useful?
   - Did references load when needed?
4. Iterate on the SKILL.md based on results
5. Test with at least one prompt that should NOT trigger the skill (disambiguation check)

## Registering with the Marketplace

To make your skill available via `plugin marketplace add baufest/skills`:

1. Add your skill's path to `.claude-plugin/marketplace.json` under the appropriate plugin entry
2. Submit a PR

## Quality Checklist

Before submitting a PR, verify:

- [ ] Directory name matches `name:` field in frontmatter
- [ ] Description is trigger-oriented and includes disambiguation
- [ ] SKILL.md body is < 500 lines
- [ ] References use relative paths, one level deep
- [ ] No secrets, API keys, or client-confidential data in skill content
- [ ] Tested with at least 2 realistic prompts
- [ ] Validation script passes: `./scripts/validate.sh`

## Validation

Run the validation script to check all skills:

```bash
./scripts/validate.sh
```

This checks:
- Frontmatter has `name` and `description` fields
- Directory name matches the `name` field
- SKILL.md is under 500 lines
