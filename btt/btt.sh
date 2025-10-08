#!/bin/sh

set -e  # Exit on error
set -u  # Exit on undefined variable

DOTFILES_DIR="$HOME/Developer/dotfiles"

echo "✨ Setting up BetterTouchTool..."

# Create SymLink
if ln -sf "$DOTFILES_DIR/btt/.btt_autoload_preset.bttpreset" ~/.btt_autoload_preset.bttpreset; then
    echo "  ✅ Created symlink for BetterTouchTool preset"
else
    echo "  ❌ Failed to create symlink for BetterTouchTool preset" >&2
    exit 1
fi

echo "🎉 BetterTouchTool setup complete!"