- make sure the readme is correct for the project

## AIBrain — Persistent Knowledge Vault

You have an Obsidian vault at `/Users/brunobrunkow/Documents/AIBrain` that serves as your persistent memory across all sessions and projects.

### When starting a session:
- Grep/glob the vault for notes relevant to the current project or task (e.g., `Areas/preferences/`, `Areas/patterns/`, `Projects/`)
- Do NOT read everything — only look up what's relevant

### During a session:
- When you learn something important (user preferences, architectural decisions, corrections, project context), create or update a note in the vault
- Use the folder structure: Inbox/, Projects/, Areas/ (preferences/, patterns/, corrections/), Resources/session-logs/, Archive/
- Use kebab-case filenames, YAML frontmatter with `tags` and `date`, and `[[wikilinks]]`

### After significant debugging or decision-making:
- Offer to create a session log in `Resources/session-logs/`

### Important:
- The vault has a global auto-commit hook that commits and pushes any file written inside the vault automatically
- Do not save ephemeral or easily derivable information — only things that add value across sessions