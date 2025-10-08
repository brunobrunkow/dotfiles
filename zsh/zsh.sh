#!/bin/sh

set -e  # Exit on error
set -u  # Exit on undefined variable

DOTFILES_DIR="$HOME/Developer/dotfiles"

echo "💻 Setting up Zsh..."

# oh-my-zsh
if [ -d ~/.oh-my-zsh ]; then
    echo "  ⚠️  oh-my-zsh already installed, skipping..."
else
    echo "  📥 Installing oh-my-zsh..."
    if sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; then
        echo "  ✅ oh-my-zsh installed"
    else
        echo "  ❌ Failed to install oh-my-zsh" >&2
        exit 1
    fi
fi

# download fonts
echo "  🔤 Downloading Powerline fonts..."
cd ~/Library/Fonts || exit 1
for font in "Regular" "Bold" "Italic" "Bold%20Italic"; do
    font_file="MesloLGS NF ${font}.ttf"
    font_file_clean=$(echo "$font_file" | sed 's/%20/ /g')
    if [ -f "$font_file_clean" ]; then
        echo "    ⚠️  Font $font_file_clean already exists, skipping..."
    else
        curl -O "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20${font}.ttf"
    fi
done
echo "  ✅ Fonts downloaded"

# themes and plugins
POWERLEVEL10K_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ -d "$POWERLEVEL10K_DIR" ]; then
    echo "  ⚠️  Powerlevel10k already installed, skipping..."
else
    echo "  🎨 Installing Powerlevel10k theme..."
    if git clone https://github.com/romkatv/powerlevel10k.git "$POWERLEVEL10K_DIR"; then
        echo "  ✅ Powerlevel10k installed"
    else
        echo "  ❌ Failed to install Powerlevel10k" >&2
        exit 1
    fi
fi

ZSH_AUTOSUGGESTIONS_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
if [ -d "$ZSH_AUTOSUGGESTIONS_DIR" ]; then
    echo "  ⚠️  zsh-autosuggestions already installed, skipping..."
else
    echo "  🔌 Installing zsh-autosuggestions plugin..."
    if git clone https://github.com/zsh-users/zsh-autosuggestions.git "$ZSH_AUTOSUGGESTIONS_DIR"; then
        echo "  ✅ zsh-autosuggestions installed"
    else
        echo "  ❌ Failed to install zsh-autosuggestions" >&2
        exit 1
    fi
fi

# create symbolic links
if ln -sf "$DOTFILES_DIR/zsh/.zshrc" ~/.zshrc; then
    echo "  ✅ Created symlink for .zshrc"
else
    echo "  ❌ Failed to create symlink for .zshrc" >&2
    exit 1
fi

if ln -sf "$DOTFILES_DIR/zsh/p10k/.p10k.zsh" ~/.p10k.zsh; then
    echo "  ✅ Created symlink for .p10k.zsh"
else
    echo "  ❌ Failed to create symlink for .p10k.zsh" >&2
    exit 1
fi

echo "🎉 Zsh setup complete!"