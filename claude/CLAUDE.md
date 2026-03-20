- make sure the readme is correct for the project

## AIBrain — Persistent Knowledge Vault

You have an Obsidian vault at `~/Documents/AIBrain` that serves as your persistent memory across all sessions and projects. **Do NOT use the built-in `~/.claude/projects/.../memory/` system — use AIBrain instead.**

Refer to the vault's `CLAUDE.md` for lookup rules, write rules, and conventions.

### Triggers (MUST follow):
1. **Session start:** Search AIBrain (`Projects/` and `Areas/`) for notes relevant to the current working directory or task before starting work.
2. **On correction:** When the user corrects you or says "not like that", immediately save to `Areas/corrections/`.
3. **On preference:** When the user expresses a preference (tools, style, approach), immediately save to `Areas/preferences/`.
4. **Session end / significant milestone:** Offer to save relevant learnings (patterns, decisions, project context) to AIBrain.

### General rules:
- Do NOT read everything — only search for what's relevant
- Auto-commit hook handles git — no manual commits needed
- Do not save ephemeral or easily derivable information
- Refer to the vault's `CLAUDE.md` for templates, folder structure, and conventions
