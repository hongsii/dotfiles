#!/bin/bash

set -e
echo ''

DOTFILES_PATH=${DOTFILES_PATH:-~/.dotfiles}
BITBAR_PATH=$DOTFILES_PATH/bitbar

source $DOTFILES_PATH/script/log.sh

if [ -f $HOME/.bitbarrc ]; then
    while true; do
        user "Do you want to orvewrite .bitbarrc ?\n \
 [y]es, [n]o"
        read -n 1 yn
        case $yn in
            [Yy] ) break;;
            [Nn] ) exit 0;;
            * ) info "You should enter yes or no!";;
        esac
    done
fi

info 'setup bitbar'
user ' - What is your github user name?'
read -e github_username
user ' - How many contributions do you want to see on menu bar?'
read -e max_contributions

sed -e "s/GITHUB_USERNAME/$github_username/g" -e "s/MAX_CONTRIBUTIONS/$max_contributions/g" $BITBAR_PATH/bitbarrc.example > $HOME/.bitbarrc
success 'bitbar'
