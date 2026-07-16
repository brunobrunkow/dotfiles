#!/bin/sh

set -e  # Exit on error
set -u  # Exit on undefined variable

echo "🤖 Setting up Claude Code configuration..."

CLAUDE_DIR="$HOME/.claude"
DOTFILES_CLAUDE_DIR="$(cd "$(dirname "$0")" && pwd)"

# Create .claude directory if it doesn't exist
mkdir -p "$CLAUDE_DIR"

# Symlink CLAUDE.md
if [ -f "$CLAUDE_DIR/CLAUDE.md" ] && [ ! -L "$CLAUDE_DIR/CLAUDE.md" ]; then
    echo "  ⚠️  Backing up existing CLAUDE.md"
    mv "$CLAUDE_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md.backup.$(date +%Y%m%d_%H%M%S)"
fi
if ln -sf "$DOTFILES_CLAUDE_DIR/CLAUDE.md" "$CLAUDE_DIR/CLAUDE.md"; then
    echo "  ✅ Symlinked CLAUDE.md"
else
    echo "  ❌ Failed to symlink CLAUDE.md" >&2
    exit 1
fi

# Symlink settings.json
if [ -f "$CLAUDE_DIR/settings.json" ] && [ ! -L "$CLAUDE_DIR/settings.json" ]; then
    echo "  ⚠️  Backing up existing settings.json"
    mv "$CLAUDE_DIR/settings.json" "$CLAUDE_DIR/settings.json.backup.$(date +%Y%m%d_%H%M%S)"
fi
if ln -sf "$DOTFILES_CLAUDE_DIR/settings.json" "$CLAUDE_DIR/settings.json"; then
    echo "  ✅ Symlinked settings.json"
else
    echo "  ❌ Failed to symlink settings.json" >&2
    exit 1
fi

# Symlink statusline.sh
if ln -sf "$DOTFILES_CLAUDE_DIR/statusline.sh" "$CLAUDE_DIR/statusline.sh"; then
    echo "  ✅ Symlinked statusline.sh"
else
    echo "  ❌ Failed to symlink statusline.sh" >&2
    exit 1
fi

echo "🎉 Claude Code setup complete!"
