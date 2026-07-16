#!/bin/sh

set -e  # Exit on error
set -u  # Exit on undefined variable

DOTFILES_DIR="$(cd "$(dirname "$0")/.." && pwd)"

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

BREWFILE="$DOTFILES_DIR/brew/Brewfile"
INSTALL_BREWFILE="$BREWFILE"

# fzf is needed for the interactive app selection below
if ! command -v fzf >/dev/null 2>&1; then
    echo "  📥 Installing fzf for the app selection..."
    brew install fzf || true
fi

if [ -t 0 ] && command -v fzf >/dev/null 2>&1; then
    # Offer cask selection: "name<TAB>description" per line, description
    # taken from the comment directly above each cask in the Brewfile.
    CASK_CHOICES=$(awk -F'"' '
        /^# / { comment = substr($0, 3) }
        /^cask / { printf "%s\t%s\n", $2, comment }
        !/^# / { comment = "" }
    ' "$BREWFILE")
    SELECTED=$(printf '%s\n' "$CASK_CHOICES" | fzf \
        --multi \
        --layout=reverse \
        --height=80% \
        --border \
        --delimiter='\t' \
        --marker='●' \
        --header='Apps to install — Tab: toggle · Enter: confirm · Esc: install everything' \
        --bind 'load:select-all') || SELECTED=""

    if [ -n "$SELECTED" ]; then
        # Space-separated: BSD awk does not accept newlines in -v strings
        SELECTED_NAMES=$(printf '%s\n' "$SELECTED" | cut -f1 | tr '\n' ' ')
        INSTALL_BREWFILE=$(mktemp)
        awk -F'"' -v selected="$SELECTED_NAMES" '
            BEGIN {
                n = split(selected, names, " ")
                for (i = 1; i <= n; i++) keep[names[i]] = 1
            }
            # Hold comments back so they are dropped along with a deselected cask
            /^# / { pending = $0; next }
            /^cask / {
                if ($2 in keep) {
                    if (pending != "") print pending
                    print
                }
                pending = ""
                next
            }
            {
                if (pending != "") { print pending; pending = "" }
                print
            }
            END { if (pending != "") print pending }
        ' "$BREWFILE" > "$INSTALL_BREWFILE"
        TOTAL=$(printf '%s\n' "$CASK_CHOICES" | grep -c .)
        CHOSEN=$(echo "$SELECTED_NAMES" | wc -w | tr -d ' ')
        echo "  📋 Installing $CHOSEN of $TOTAL apps"
    else
        echo "  ⚠️  Selection cancelled, installing everything"
    fi
else
    echo "  ⚠️  Interactive selection unavailable, installing everything"
fi

echo "  📦 Installing packages from Brewfile..."
if brew bundle --file "$INSTALL_BREWFILE"; then
    echo "  ✅ Brew packages installed"
else
    echo "  ❌ Failed to install brew packages" >&2
    exit 1
fi

[ "$INSTALL_BREWFILE" != "$BREWFILE" ] && rm -f "$INSTALL_BREWFILE"

echo "🎉 Homebrew setup complete!"
