#!/bin/sh

set -e  # Exit on error
set -u  # Exit on undefined variable

DOTFILES_DIR="$HOME/Developer/dotfiles"

echo "✨ Setting up Hammerspoon..."

# Remove existing .hammerspoon directory or symlink
if [ -e ~/.hammerspoon ] || [ -L ~/.hammerspoon ]; then
    echo "  ⚠️  Removing existing ~/.hammerspoon..."
    rm -rf ~/.hammerspoon
fi

# Create symlink
if ln -sf "$DOTFILES_DIR/hammerspoon" ~/.hammerspoon; then
    echo "  ✅ Created symlink for Hammerspoon config"
else
    echo "  ❌ Failed to create symlink for Hammerspoon config" >&2
    exit 1
fi

echo "🎉 Hammerspoon setup complete!"
