#!/bin/bash

cd /Users/moinak/.scripts

#####################################
# Determining whether to run update #
#####################################
today=`date +%Y%m%d`
last_run_date=`cat config_backup_last_run_date.txt`

if [ -z "$last_run_date" ]; then
  last_run_date='0'
fi

echo "Today is $today"
echo "Last run on: $last_run_date"

if [ $today -le $last_run_date ]
then
  echo "Script has already run today, hence exiting."
  exit 1;
fi



###########
# SCRIPTS #
###########
scripts_dir=/Users/moinak/.custom-config/scripts
mkdir -p $scripts_dir
rm $scripts_dir/*.sh
cp -f $HOME/.scripts/*.sh $scripts_dir


#######
# ZSH #
#######
zsh_dir="$HOME/.custom-config/zsh"
mkdir -p $zsh_dir
cp -f $HOME/.zshrc $zsh_dir



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
# CRON TABLE #
##############
crontab_dir="$HOME/.custom-config/crontab"
mkdir -p $crontab_dir
crontab -l > $crontab_dir/crontab.txt



##############
# COMMITTING #
##############

cd $HOME/.custom-config

commit_date=$(date +%Y%m%d%H%M%S)
git add --all
git commit -m "config backup $commit_date"

# Push to remote repository
git push origin main



##########################
# UPDATING LAST RUN DATE #
##########################
cd /Users/moinak/.scripts
echo `date +%Y%m%d` > ./config_backup_last_run_date.txt
