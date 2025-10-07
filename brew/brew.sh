#!/bin/sh

set -e  # Exit on error
set -u  # Exit on undefined variable

DOTFILES_DIR="$HOME/Developer/dotfiles"

# Check if Homebrew already installed
if command -v brew >/dev/null 2>&1; then
    echo "! Homebrew already installed, skipping installation..."
else
    echo "Installing Homebrew..."
    if /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"; then
        echo "✓ Homebrew installed"
    else
        echo "✗ Failed to install Homebrew" >&2
        exit 1
    fi
fi

# Only add to .zprofile if not already there
if ! grep -q "homebrew/bin/brew shellenv" ~/.zprofile 2>/dev/null; then
    echo '# Set PATH, MANPATH, etc., for Homebrew.' >> ~/.zprofile
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
    echo "✓ Added Homebrew to .zprofile"
else
    echo "! Homebrew already configured in .zprofile"
fi

eval "$(/opt/homebrew/bin/brew shellenv)"

echo "Installing packages from Brewfile..."
if brew bundle --file "$DOTFILES_DIR/brew/Brewfile"; then
    echo "✓ Brew packages installed"
else
    echo "✗ Failed to install brew packages" >&2
    exit 1
fi

echo "Homebrew setup complete!"