#! /bin/bash

# create links
ln -s ./git/.gitignore_global ~/.gitignore_global
ln -s ./git/.gitconfig ~/.gitconfig

git config --global core.excludesfile ~/.gitignore_global
