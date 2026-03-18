## My dotfiles

A set of tools and environment setups I require for work.

This repo should be cloned into `~/Developer/dotfiles` for it to correctly link everything.

## Installation

To run the full installation:

```bash
make install
```

Or manually run:

```bash
sh bootstrap.sh
```

## Available Commands

```bash
make install  # Run full installation
make update   # Update symlinks only
make backup   # Backup existing configs
make ssh      # Setup SSH keys and config
make clean    # Remove symlinks
make help     # Show available commands
```

## What Gets Installed

The installation script will:

### 1. Install Xcode Command Line Tools
Required for development tools and compilers.

### 2. Configure macOS Preferences
Custom system preferences via `osx/osx.sh`.

### 3. Install Homebrew & Applications
The following applications are installed via Homebrew:

**CLI Tools:**
* zsh

**Applications:**
* Alfred
* Hammerspoon
* Stats
* Firefox
* Ghostty
* Proxyman
* RapidAPI
* Sourcetree
* Spotify
* Visual Studio Code
* Xcodes

### 4. Setup Zsh
* Installs Oh My Zsh
* Configures Powerlevel10k theme
* Symlinks `.zshrc` and `.p10k.zsh` to home directory

### 5. Setup Git
* Symlinks `.gitconfig` and `.gitignore_global` to home directory
* Configures global Git settings

### 6. Setup SSH
* Creates SSH directory structure
* Optionally generates SSH keys for Git
* Symlinks SSH config

### 7. Setup Ghostty
* Creates Ghostty config directory
* Symlinks Ghostty configuration to `~/.config/ghostty/config`

### 8. Setup Claude Code
* Symlinks `CLAUDE.md`, `settings.json`, and `projects/` to `~/.claude/`
* Backs up existing configs before symlinking

### 9. Setup Hammerspoon
* Creates Hammerspoon config directory
* Symlinks Hammerspoon configuration to `~/.hammerspoon/`
* Configures window management, focus modes, and custom shortcuts

## Manual Steps

After installation completes, perform these additional steps:

### SSH Keys

1. If you didn't create an SSH key during installation, run:
   ```bash
   make ssh
   ```

2. Add the public key to your Git providers:
   - **GitHub:** https://github.com/settings/keys
   - **GitLab:** https://gitlab.com/-/profile/keys

   Your public key is displayed at the end of `make ssh`, or run:
   ```bash
   cat ~/.ssh/id_git.pub
   ```

### Xcode

Install full Xcode via Xcodes.app (installed via Homebrew):
```bash
open -a Xcodes
```

### Application Settings

#### Ghostty
1. Open Ghostty
2. Configuration is automatically loaded from `~/.config/ghostty/config`
3. Font and theme settings are pre-configured

#### Hammerspoon
1. Open Hammerspoon
2. Configuration is automatically loaded from `~/.hammerspoon/`
3. Window management shortcuts and focus modes are pre-configured
4. Grant Accessibility permissions when prompted

#### Zsh/Powerlevel10k
If you need to reconfigure the prompt:
```bash
p10k configure
```

## Troubleshooting

### Symlinks not working
Run `make update` to recreate symlinks

### Restore from backup
Backups are stored with timestamps (e.g., `~/.zshrc.backup.20250108_123456`)
```bash
cp ~/.zshrc.backup.YYYYMMDD_HHMMSS ~/.zshrc
```

### Clean install
To remove all symlinks and start fresh:
```bash
make clean
make install
```
