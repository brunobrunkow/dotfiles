# Enable Powerlevel10k instant prompt
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path configuration
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="/opt/homebrew/opt/postgresql@13/bin:$PATH"

# Oh-My-Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions fast-syntax-highlighting zsh-autocomplete)

source $ZSH/oh-my-zsh.sh

# Powerlevel10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Environment variables
export API_SECRET_KEY=""
export ARCHIVE_POSTS_COUNT="5000"
export ENABLE_SSL="false"
export INITIAL_LOAD_POST_COUNT="500"
export DB_USER="brunobrunkow"
export DB_PASSWORD="password"

# Custom scripts
alias gameon='sudo $HOME/Developer/Skripts/gameon.sh'

# Git Cheat Sheet
gh() {
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