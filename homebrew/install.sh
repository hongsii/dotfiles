#! /bin/bash

if [ -x "$(command -v brew)" ]; then
    echo "  > Already install brew. skip this script"
    exit 0
fi

echo "  > Install homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"


SCRIPT_PATH=$(dirname $0)
brew_file="$SCRIPT_PATH/BrewFile"
if [ ! -f "$brew_file" ]; then
    echo "  > $brew_file doesn't exist"
    exit 1
fi

brew update
brew bundle --file=$brew_file
brew cleanup
brew cask cleanup
