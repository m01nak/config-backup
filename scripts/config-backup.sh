#!/bin/bash

###########
# SCRIPTS #
###########
script_dir="$HOME/.custom-config/scripts"
mkdir -p $script_dir
cp -f ~/.sctiprs/*.sh $sctipt_dir 


#######
# ZSH #
#######
zsh_dir="$HOME/.custom-config/zsh"
mkdir -p $zsh_dir
cp -f $HOME/.zshrc $zsh_dir/zshrc_backup


############
# HOMEBREW #
############
homebrew_dir="$HOME/.custom-config/homebrew"
mkdir -p "$homebrew_dir"

formulae_file="$homebrew_dir/homebrew-formulas.txt"
casks_file="$homebrew_dir/homebrew-casks.txt"

brew_formulae=$(brew list --formula)
brew_casks=$(brew list --cask)

echo "$brew_formulae" > "$formulae_file"
echo "$brew_casks" > "$casks_file"


##############
# COMMITTING #
##############
cd $HOME/.custom_config

commit_date=$(date +%Y%m%d%H%M%S)
git add --all
git commit -m "config backup $commit_date"

# Push to remote repository
git push origin main

