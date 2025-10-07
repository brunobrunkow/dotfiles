#!/bin/sh

set -e  # Exit on error
set -u  # Exit on undefined variable

echo "======================================"
echo "  Dotfiles Installation Starting"
echo "======================================"

# Backup existing configs
echo "\n[0/8] Backing up existing configs..."
if command -v make >/dev/null 2>&1; then
    make backup 2>/dev/null || echo "! No existing configs to backup"
else
    # Manual backup if make is not available
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    [ -f ~/.zshrc ] && cp ~/.zshrc ~/.zshrc.backup.$TIMESTAMP && echo "✓ Backed up ~/.zshrc" || true
    [ -f ~/.gitconfig ] && cp ~/.gitconfig ~/.gitconfig.backup.$TIMESTAMP && echo "✓ Backed up ~/.gitconfig" || true
    [ -f ~/.p10k.zsh ] && cp ~/.p10k.zsh ~/.p10k.zsh.backup.$TIMESTAMP && echo "✓ Backed up ~/.p10k.zsh" || true
    [ -f ~/.gitignore_global ] && cp ~/.gitignore_global ~/.gitignore_global.backup.$TIMESTAMP && echo "✓ Backed up ~/.gitignore_global" || true
fi
echo "✓ Backup complete"

# Xcode command line tools
echo "\n[1/8] Installing Xcode command line tools..."
if xcode-select -p >/dev/null 2>&1; then
    echo "! Xcode command line tools already installed, skipping..."
else
    if xcode-select --install 2>/dev/null; then
        echo "✓ Xcode command line tools installed"
        echo "Waiting for installation to complete..."
        until xcode-select -p >/dev/null 2>&1; do
            sleep 5
        done
    else
        echo "✗ Failed to install Xcode command line tools" >&2
    fi
fi

# OSX preferences
echo "\n[2/8] Setting up macOS preferences..."
if sh osx/osx.sh; then
    echo "✓ macOS preferences configured"
else
    echo "✗ Failed to configure macOS preferences" >&2
    exit 1
fi

# Homebrew 🍺
echo "\n[3/8] Setting up Homebrew..."
if sh brew/brew.sh; then
    echo "✓ Homebrew setup complete"
else
    echo "✗ Failed to setup Homebrew" >&2
    exit 1
fi

# ZSH
echo "\n[4/8] Setting up Zsh..."
if sh zsh/zsh.sh; then
    echo "✓ Zsh setup complete"
else
    echo "✗ Failed to setup Zsh" >&2
    exit 1
fi

# GIT
echo "\n[5/8] Setting up Git..."
if sh git/git.sh; then
    echo "✓ Git setup complete"
else
    echo "✗ Failed to setup Git" >&2
    exit 1
fi

# SSH
echo "\n[6/7] Setting up SSH..."
if sh ssh/ssh.sh; then
    echo "✓ SSH setup complete"
else
    echo "✗ Failed to setup SSH" >&2
    exit 1
fi

# Ghostty
echo "\n[7/8] Setting up Ghostty..."
if sh ghostty/ghostty.sh; then
    echo "✓ Ghostty setup complete"
else
    echo "✗ Failed to setup Ghostty" >&2
    exit 1
fi

# Better Touch Tool
echo "\n[8/8] Setting up BetterTouchTool..."
if sh btt/btt.sh; then
    echo "✓ BetterTouchTool setup complete"
else
    echo "✗ Failed to setup BetterTouchTool" >&2
    exit 1
fi

echo "\n======================================"
echo "  ✓ Installation Complete!"
echo "======================================"
echo "\nPlease complete the manual steps listed in README.md"