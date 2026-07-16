#!/bin/sh

set -e  # Exit on error
set -u  # Exit on undefined variable

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "👻 Setting up Ghostty configuration..."

# Create Ghostty config directory if it doesn't exist
GHOSTTY_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty"
mkdir -p "$GHOSTTY_CONFIG_DIR"

# Backup existing config if it's a real file (not a symlink)
if [ -f "$GHOSTTY_CONFIG_DIR/config" ] && [ ! -L "$GHOSTTY_CONFIG_DIR/config" ]; then
    echo "  ⚠️  Backing up existing Ghostty config"
    mv "$GHOSTTY_CONFIG_DIR/config" "$GHOSTTY_CONFIG_DIR/config.backup.$(date +%Y%m%d_%H%M%S)"
fi

# Symlink the config file
if ln -sf "$DOTFILES_DIR/ghostty/config" "$GHOSTTY_CONFIG_DIR/config"; then
    echo "  ✅ Symlinked Ghostty config"
else
    echo "  ❌ Failed to symlink Ghostty config" >&2
    exit 1
fi

echo "🎉 Ghostty setup complete!"
