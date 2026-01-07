#!/bin/sh

set -e  # Exit on error
set -u  # Exit on undefined variable

DOTFILES_DIR="$HOME/Developer/dotfiles"

# Check if Homebrew already installed
if command -v brew >/dev/null 2>&1; then
    echo "  ⚠️  Homebrew already installed, skipping installation..."
else
    echo "  📥 Installing Homebrew..."
    if /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"; then
        echo "  ✅ Homebrew installed"
    else
        echo "  ❌ Failed to install Homebrew" >&2
        exit 1
    fi
fi

# Resolve Homebrew path for both Apple Silicon and Intel Macs.
BREW_BIN="$(command -v brew || true)"
if [ -z "$BREW_BIN" ]; then
    if [ -x /opt/homebrew/bin/brew ]; then
        BREW_BIN=/opt/homebrew/bin/brew
    elif [ -x /usr/local/bin/brew ]; then
        BREW_BIN=/usr/local/bin/brew
    fi
fi

if [ -z "$BREW_BIN" ]; then
    echo "  ❌ Homebrew binary not found after install" >&2
    exit 1
fi

BREW_SHELLENV_LINE="eval \"\$($BREW_BIN shellenv)\""

# Only add to .zprofile if not already there
if ! grep -q "brew shellenv" ~/.zprofile 2>/dev/null; then
    echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.zprofile
    echo "$BREW_SHELLENV_LINE" >> ~/.zprofile
    echo "  ✅ Added Homebrew to .zprofile"
else
    echo "  ⚠️  Homebrew already configured in .zprofile"
fi

eval "$($BREW_BIN shellenv)"

echo "  📦 Installing packages from Brewfile..."
if brew bundle --file "$DOTFILES_DIR/brew/Brewfile"; then
    echo "  ✅ Brew packages installed"
else
    echo "  ❌ Failed to install brew packages" >&2
    exit 1
fi

echo "🎉 Homebrew setup complete!"
