#!/bin/sh

set -e  # Exit on error
set -u  # Exit on undefined variable

echo "Setting up SSH configuration..."

SSH_KEY_PATH="$HOME/.ssh/id_git"
SSH_CONFIG_PATH="$HOME/.ssh/config"

# Ensure .ssh directory exists with correct permissions
if [ ! -d "$HOME/.ssh" ]; then
    mkdir -p "$HOME/.ssh"
    chmod 700 "$HOME/.ssh"
    echo "✓ Created .ssh directory"
fi

# Check if SSH key exists
if [ -f "$SSH_KEY_PATH" ]; then
    echo "✓ SSH key already exists at $SSH_KEY_PATH"
else
    echo ""
    echo "SSH key not found. You can create one with:"
    echo "  ssh-keygen -t ed25519 -C 'your_email@example.com' -f $SSH_KEY_PATH"
    echo ""
    read -p "Would you like to create an SSH key now? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        read -p "Enter your email address: " email
        if ssh-keygen -t ed25519 -C "$email" -f "$SSH_KEY_PATH"; then
            echo "✓ SSH key created at $SSH_KEY_PATH"
        else
            echo "✗ Failed to create SSH key" >&2
            exit 1
        fi
    else
        echo "! Skipping SSH key creation"
        echo "! Remember to create it manually later"
    fi
fi

# Create or update SSH config
if [ ! -f "$SSH_CONFIG_PATH" ]; then
    cat > "$SSH_CONFIG_PATH" << 'EOF'
Host *
    AddKeysToAgent yes
    UseKeychain yes
    IdentityFile ~/.ssh/id_git
EOF
    chmod 600 "$SSH_CONFIG_PATH"
    echo "✓ Created SSH config at $SSH_CONFIG_PATH"
else
    echo "! SSH config already exists at $SSH_CONFIG_PATH"
fi

# Add key to ssh-agent if it exists
if [ -f "$SSH_KEY_PATH" ]; then
    # Start ssh-agent if not running
    if ! pgrep -u "$USER" ssh-agent > /dev/null; then
        eval "$(ssh-agent -s)" > /dev/null
        echo "✓ Started ssh-agent"
    fi

    # Add key to agent
    if ssh-add -l 2>/dev/null | grep -q "$SSH_KEY_PATH"; then
        echo "✓ SSH key already added to agent"
    else
        if ssh-add "$SSH_KEY_PATH" 2>/dev/null; then
            echo "✓ SSH key added to agent"
        else
            echo "! SSH key could not be added to agent (may require passphrase)"
        fi
    fi

    # Display public key for easy copying
    if [ -f "$SSH_KEY_PATH.pub" ]; then
        echo ""
        echo "Your public SSH key (add this to GitHub/GitLab):"
        echo "================================================"
        cat "$SSH_KEY_PATH.pub"
        echo "================================================"
        echo ""
    fi
fi

echo "SSH configuration complete!"
