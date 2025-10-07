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
plugins=(git zsh-autosuggestions)

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

# Git aliases
alias ga='git add .'
alias gc='git commit -m'
alias gp='git push'

# Custom scripts
alias gameon='sudo $HOME/Developer/Skripts/gameon.sh'
alias gameoff='sudo ifconfig awdl0 up'