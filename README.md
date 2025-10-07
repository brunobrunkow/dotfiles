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

This will:

Install
* Xcode command line tools
* Homebrew
  * zsh
  * Alfred
  * BetterTouchTool
  * Cryptomator
  * eul
  * Firefox
  * iTerm2
  * Nextcloud
  * Proxyman
  * RapidAPI
  * Spotify
  * Visual Studio Code
  * Xcodes

Setup
* git configuration
* zsh theming
* iTerm2

# Manual Steps

After installation completes, perform these additional steps:

## SSH Keys

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

## Xcode

Install full Xcode via Xcodes.app (installed via Homebrew):
```bash
open -a Xcodes
```

## Application Settings

### iTerm2
1. Restart iTerm2 for preferences to take effect
2. Set font to "MesloLGS NF" in Preferences → Profiles → Text

### BetterTouchTool
1. Open BetterTouchTool
2. Go to Preferences → Presets
3. The preset should auto-load from `~/.btt_autoload_preset.bttpreset`

### Zsh/Powerlevel10k
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
