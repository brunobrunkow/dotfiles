#!/bin/sh

set -e  # Exit on error
set -u  # Exit on undefined variable

echo "╔══════════════════════════════════════╗"
echo "║  🚀 Dotfiles Installation Starting   ║"
echo "╚══════════════════════════════════════╝"

# Backup existing configs
echo "\n💾 [0/9] Backing up existing configs..."
if command -v make >/dev/null 2>&1; then
    make backup 2>/dev/null || echo "⚠️  No existing configs to backup"
else
    # Manual backup if make is not available
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    [ -f ~/.zshrc ] && cp ~/.zshrc ~/.zshrc.backup.$TIMESTAMP && echo "  ✅ Backed up ~/.zshrc" || true
    [ -f ~/.gitconfig ] && cp ~/.gitconfig ~/.gitconfig.backup.$TIMESTAMP && echo "  ✅ Backed up ~/.gitconfig" || true
    [ -f ~/.p10k.zsh ] && cp ~/.p10k.zsh ~/.p10k.zsh.backup.$TIMESTAMP && echo "  ✅ Backed up ~/.p10k.zsh" || true
    [ -f ~/.gitignore_global ] && cp ~/.gitignore_global ~/.gitignore_global.backup.$TIMESTAMP && echo "  ✅ Backed up ~/.gitignore_global" || true
fi
echo "✅ Backup complete\n"

# Xcode command line tools
echo "🛠️  [1/9] Installing Xcode command line tools..."
if xcode-select -p >/dev/null 2>&1; then
    echo "  ⚠️  Xcode command line tools already installed, skipping..."
else
    if xcode-select --install 2>/dev/null; then
        echo "  ⏳ Waiting for installation to complete..."
        until xcode-select -p >/dev/null 2>&1; do
            sleep 5
        done
        echo "  ✅ Xcode command line tools installed"
    else
        echo "  ❌ Failed to install Xcode command line tools" >&2
    fi
fi
echo "✅ Xcode setup complete\n"

# OSX preferences
echo "🍎 [2/9] Setting up macOS preferences..."
if sh osx/osx.sh; then
    echo "✅ macOS preferences configured\n"
else
    echo "❌ Failed to configure macOS preferences" >&2
    exit 1
fi

# Homebrew 🍺
echo "🍺 [3/9] Setting up Homebrew..."
if sh brew/brew.sh; then
    echo "✅ Homebrew setup complete\n"
else
    echo "❌ Failed to setup Homebrew" >&2
    exit 1
fi

# ZSH
echo "💻 [4/9] Setting up Zsh..."
if sh zsh/zsh.sh; then
    echo "✅ Zsh setup complete\n"
else
    echo "❌ Failed to setup Zsh" >&2
    exit 1
fi

# GIT
echo "📦 [5/9] Setting up Git..."
if sh git/git.sh; then
    echo "✅ Git setup complete\n"
else
    echo "❌ Failed to setup Git" >&2
    exit 1
fi

# SSH
echo "🔐 [6/9] Setting up SSH..."
if bash ssh/ssh.sh; then
    echo "✅ SSH setup complete\n"
else
    echo "❌ Failed to setup SSH" >&2
    exit 1
fi

# Ghostty
echo "👻 [7/9] Setting up Ghostty..."
if sh ghostty/ghostty.sh; then
    echo "✅ Ghostty setup complete\n"
else
    echo "❌ Failed to setup Ghostty" >&2
    exit 1
fi

# Claude Code
echo "🤖 [8/9] Setting up Claude Code..."
if sh claude/claude.sh; then
    echo "✅ Claude Code setup complete\n"
else
    echo "❌ Failed to setup Claude Code" >&2
    exit 1
fi

# Hammerspoon
echo "🔨 [9/9] Setting up Hammerspoon..."
if sh hammerspoon/hammerspoon.sh; then
    echo "✅ Hammerspoon setup complete\n"
else
    echo "❌ Failed to setup Hammerspoon" >&2
    exit 1
fi

echo "╔══════════════════════════════════════╗"
echo "║  🎉 Installation Complete! 🎉        ║"
echo "╚══════════════════════════════════════╝"
echo "\n📝 Please complete the manual steps listed in README.md"
echo "✨ Happy coding! ✨\n"