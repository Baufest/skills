# Baufest Skills

A curated collection of agent skills for Baufest consulting teams, built on the [agentskills.io](https://agentskills.io/specification) open standard.

Skills are structured instruction sets that any compatible AI coding agent can discover and execute. Each skill is a folder containing a `SKILL.md` file with YAML frontmatter (for discovery) and a markdown body (for execution). Skills follow a progressive disclosure model: agents see only the name and description at discovery time, load the full instructions on trigger, and pull in references or scripts on demand. This keeps context lean while enabling deep, specialized behavior.

Skills are agent-agnostic. The same skill works across Claude Code, Cursor, VS Code / Copilot, Codex, Gemini CLI, and any agent that supports the agentskills.io specification.

## Available Skills

| Skill | Description | Type |
|-------|-------------|------|
| [`baufest-brand`](skills/baufest-brand/) | Apply Baufest brand colors, typography, and voice to any deliverable | Simple |
| [`api-design`](skills/api-design/) | Design ergonomic REST APIs that work well with OpenAPI and code generators | Reference-backed |
| [`data-table-design`](skills/data-table-design/) | Design clear, scannable data tables with correct alignment, formatting, and layout | Reference-backed |
| [`architecture-decision`](skills/architecture-decision/) | Produce Architecture Decision Records with options analysis and recommendations | Reference-backed |
| [`delivery-status`](skills/delivery-status/) | Write delivery status reports — weekly updates, steering committee summaries, executive roll-ups | Example-backed |

## How to Use

### Claude Code

Install from the marketplace:

```
plugin marketplace add baufest/skills
```

Select the `consulting-skills` plugin, then install. Skills are automatically available in all sessions.

**Manual install**: Clone this repo and symlink to your skills directory:

```bash
git clone https://github.com/baufest/skills.git
ln -s $(pwd)/skills ~/.claude/skills
```

### Cursor

Clone the repo, then add the skills directory to your Cursor settings:

```json
{
  "chat.agentSkillsLocations": [
    "/path/to/baufest-skills/skills"
  ]
}
```

### VS Code / Copilot

Place skills in `.github/skills/` in your project, or configure `chat.agentSkillsLocations` in VS Code settings:

```json
{
  "chat.agentSkillsLocations": [
    "/path/to/baufest-skills/skills"
  ]
}
```

### Any Spec-Compliant Agent

Clone this repo and point your agent's skill discovery at the `skills/` directory. The agent must support the [agentskills.io specification](https://agentskills.io/specification) — it will read `SKILL.md` frontmatter for discovery and load skill bodies on demand.

## Skill Anatomy

```
skill-name/
├── SKILL.md          # Required: YAML frontmatter + markdown instructions
├── scripts/          # Optional: executable helpers
├── references/       # Optional: loaded on-demand into context
└── assets/           # Optional: templates, images, static files
```

- **SKILL.md**: The only required file. Contains YAML frontmatter (`name`, `description`, `license`, `metadata`) and a markdown body with instructions.
- **references/**: Supporting documents loaded on demand when the skill's instructions reference them. Keeps the main SKILL.md focused.
- **examples/**: Format exemplars that show the agent what good output looks like.
- **scripts/**: Executable helpers for deterministic operations (file transforms, validation).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for how to author, test, and register new skills.

## License

Apache-2.0 — see [LICENSE](LICENSE).
