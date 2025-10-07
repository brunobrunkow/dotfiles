#!/bin/sh

set -e  # Exit on error
set -u  # Exit on undefined variable

DOTFILES_DIR="$HOME/Developer/dotfiles"

echo "Setting up Git configuration..."

# create links
if ln -sf "$DOTFILES_DIR/git/.gitignore_global" ~/.gitignore_global; then
    echo "✓ Created symlink for .gitignore_global"
else
    echo "✗ Failed to create symlink for .gitignore_global" >&2
    exit 1
fi

if ln -sf "$DOTFILES_DIR/git/.gitconfig" ~/.gitconfig; then
    echo "✓ Created symlink for .gitconfig"
else
    echo "✗ Failed to create symlink for .gitconfig" >&2
    exit 1
fi

if git config --global core.excludesfile ~/.gitignore_global; then
    echo "✓ Set global gitignore"
else
    echo "✗ Failed to set global gitignore" >&2
    exit 1
fi

echo "Git configuration complete!"
