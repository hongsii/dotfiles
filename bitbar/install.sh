#!/bin/bash

set -e
echo ''

DOTFILES_PATH=${DOTFILES_PATH:-~/.dotfiles}
BITBAR_PATH=$DOTFILES_PATH/bitbar

source $DOTFILES_PATH/script/log.sh
if ! [ -f $BITBAR_PATH/bitbarrc.symlink ]; then
    info 'github contribution setup'

    user ' - What is your github user name?'
    read -e github_username
    user ' - How many contributions do you want to see on menu bar?'
    read -e max_contributions

    sed -e "s/GITHUB_USERNAME/$github_username/g" -e "s/MAX_CONTRIBUTIONS/$max_contributions/g" $BITBAR_PATH/bitbarrc.symlink.example > $BITBAR_PATH/bitbarrc.symlink
    success 'bitbar setup'
fi
