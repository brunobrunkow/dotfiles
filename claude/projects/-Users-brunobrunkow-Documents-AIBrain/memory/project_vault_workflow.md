---
name: AIBrain Obsidian Vault Workflow
description: This project is an Obsidian vault used as Claude's persistent memory. Auto-commits on every file change via hook.
type: project
---

This directory is an Obsidian vault that serves as Claude's persistent knowledge base.

**Why:** The user wants Claude to create and organize notes directly in this vault as a memory system. No MCP needed — just read/write files.

**How to apply:**
- When the user asks to remember, save, or note something, create/update a Markdown note in the appropriate PARA folder (Inbox, Projects, Areas, Resources, Archive).
- Use `[[wikilinks]]`, YAML frontmatter with `tags` and `date`, and kebab-case filenames.
- A PostToolUse hook on Write/Edit auto-commits and pushes to `ssh://git@192.168.10.20:222/gitea/aibrain.git` — no manual git steps needed.
- The CLAUDE.md in the vault root has full conventions.
