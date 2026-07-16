#!/bin/sh

set -e  # Exit on error
set -u  # Exit on undefined variable

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

echo "✨ Setting up Hammerspoon..."

# Remove existing symlink, backup a real directory
if [ -L ~/.hammerspoon ]; then
    rm ~/.hammerspoon
elif [ -e ~/.hammerspoon ]; then
    echo "  ⚠️  Backing up existing ~/.hammerspoon..."
    mv ~/.hammerspoon ~/.hammerspoon.backup.$(date +%Y%m%d_%H%M%S)
fi

# Create symlink
if ln -sf "$DOTFILES_DIR/hammerspoon" ~/.hammerspoon; then
    echo "  ✅ Created symlink for Hammerspoon config"
else
    echo "  ❌ Failed to create symlink for Hammerspoon config" >&2
    exit 1
fi

echo "🎉 Hammerspoon setup complete!"
