#!/bin/sh

# Xcode command line tools
xcode-select --install

# OSX preferences
sh osx/osx.sh

# Homebrew 🍺
sh brew/brew.sh

# ZSH
sh zsh/zsh.sh

# GIT
sh git/git.sh

# iTerm2
sh iterm2/iterm.sh

# Better Touch Tool
sh btt/btt.sh