#!/bin/sh

set -e  # Exit on error
set -u  # Exit on undefined variable

echo "Setting up Ghostty configuration..."

# Create Ghostty config directory if it doesn't exist
GHOSTTY_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty"
mkdir -p "$GHOSTTY_CONFIG_DIR"

# Symlink the config file
if ln -sf ~/Developer/dotfiles/ghostty/config "$GHOSTTY_CONFIG_DIR/config"; then
    echo "✓ Symlinked Ghostty config"
else
    echo "✗ Failed to symlink Ghostty config" >&2
    exit 1
fi

echo "Ghostty setup complete!"
