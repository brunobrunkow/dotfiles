# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path configuration
# Standard user paths (personal scripts, Homebrew)
export PATH="$HOME/bin:/usr/local/bin:$HOME/Developer/dotfiles/bin:$PATH"

# PostgreSQL 13 from Homebrew
export PATH="/opt/homebrew/opt/postgresql@13/bin:$PATH"

# Oh-My-Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions fast-syntax-highlighting zsh-autocomplete)

source $ZSH/oh-my-zsh.sh

# Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Custom scripts
alias go="$HOME/Developer/dotfiles/bin/gameon"

# Git Cheat Sheet
githelp() {
  cat << 'EOF'
╔════════════════════════════════════════════════════════════════════════════╗
║                        🚀 GIT ALIASES CHEAT SHEET 🚀                       ║
╚════════════════════════════════════════════════════════════════════════════╝

📊 STATUS & INFO
  gst          git status                           Check repo status
  gd           git diff                             See unstaged changes
  gdca         git diff --cached                    See staged changes
  glog         git log --oneline --graph            Pretty commit history
  grt          cd to repo root                      Jump to project root

➕ ADDING & COMMITTING
  gaa          git add --all                        Stage all changes
  gcmsg        git commit -m                        Commit: gcmsg "message"
  gca!         git commit --amend --all             Amend last commit
  gwip         git wip commit                       Quick WIP snapshot

🌿 BRANCHES
  gco          git checkout                         Switch branch
  gcb          git checkout -b                      Create new branch
  gcm          git checkout main                    Switch to main
  gcd          git checkout develop                 Switch to develop
  gba          git branch --all                     List all branches
  gbda         delete merged branches               Clean up old branches

⬆️  PUSH & PULL
  gl           git pull                             Pull changes
  gpr          git pull --rebase                    Pull with rebase
  gp           git push                             Push commits
  gpf          git push --force-with-lease          Safe force push
  gpsup        git push --set-upstream              Push new branch

📦 STASH
  gsta         git stash push                       Stash changes
  gstp         git stash pop                        Restore stash
  gstl         git stash list                       List stashes
  gstaa        git stash apply                      Apply without removing

🔧 UTILITIES
  gclean       git clean -id                        Remove untracked files
  grh          git reset                            Unstage changes
  grhh         git reset --hard                     ⚠️  Discard all changes
  gunwip       undo last WIP commit                 Remove WIP commit

💡 TIP: Type 'alias | grep git' to see all git aliases
EOF
}

# Hammerspoon Cheat Sheet
hh() {
  cat << 'EOF'
╔════════════════════════════════════════════════════════════════════════════╗
║                     🔨 HAMMERSPOON HOTKEYS CHEAT SHEET 🔨                  ║
╚════════════════════════════════════════════════════════════════════════════╝

🖥️  APPLICATION TOGGLE
  ⌘ Space                                Toggle Ghostty terminal
  ⌘ ⇧ U                                  Download audio from clipboard URL
  ⌘ ⇧ V                                  Download video from clipboard URL

🪟 WINDOW POSITIONING (⌘ ⌥ + Arrow)
  ⌘ ⌥ ←                                  Left half of screen
  ⌘ ⌥ →                                  Right half of screen
  ⌘ ⌥ ↑                                  Maximize window
  ⌘ ⌥ ↓                                  Center window

🔲 QUARTER SCREEN (⌘ ⌥ + Key)
  ⌘ ⌥ U                                  Top-left quarter
  ⌘ ⌥ I                                  Top-right quarter
  ⌘ ⌥ N                                  Bottom-left quarter
  ⌘ ⌥ M                                  Bottom-right quarter

🎯 FOCUS NAVIGATION (⌘ ⌥ + Key)
  ⌘ ⌥ K                                  Focus window left
  ⌘ ⌥ O                                  Focus window above
  ⌘ ⌥ L                                  Focus window below
  ⌘ ⌥ Ö                                  Focus window right

🔄 WINDOW SWAP (⌘ ⌥ ⇧ + Key)
  ⌘ ⌥ ⇧ K                                Swap with left neighbor
  ⌘ ⌥ ⇧ O                                Swap with above neighbor
  ⌘ ⌥ ⇧ L                                Swap with below neighbor
  ⌘ ⌥ ⇧ Ö                                Swap with right neighbor

🖥️  MULTI-DISPLAY (⌘ ⌥ ⌃ + Arrow)
  ⌘ ⌥ ⌃ ←                                Move to left display
  ⌘ ⌥ ⌃ →                                Move to right display

🔧 SYSTEM
  ⌃ ⌥ ⌘ B                                Sleep Mac
  ⌘ ⌥ ⇧ R                                Reload Hammerspoon config

🎵 MEDIA
  Button 4                               Volume up
  Button 5                               Volume down
  ⌘ ⇧ A                                  Toggle audio output device
EOF
}

# Reset local branch to remote state
gitresetremote() {
  local current_branch=$(git branch --show-current)
  if [[ -z "$current_branch" ]]; then
    echo "Error: Not on a branch"
    return 1
  fi
  
  echo "This will reset $current_branch to origin/$current_branch (destructive!)"
  read -q "REPLY?Continue? (y/n) "
  echo
  [[ $REPLY == "y" ]] || return 0
  
  git reset --hard origin/$current_branch && \
    echo "✓ Reset to origin/$current_branch"
}
export PATH="$HOME/.local/bin:$PATH"
