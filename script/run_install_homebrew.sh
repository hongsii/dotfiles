#!/usr/bin/env bash

run_install_homebrew() {
  echo ''

  info 'Installing Homebrew'

  if command -v brew &>/dev/null; then
    success 'Homebrew is already installed.'
  else
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    success 'Installed Homebrew'
  fi

  # bundle Brewfile
  local brewfile_path="$DOTFILES_PATH/homebrew/BrewFile"
  if [[ -f "$brewfile_path" ]]; then
    brew bundle --file="$brewfile_path" > /dev/null 2>&1
    brew cleanup > /dev/null 2>&1
    success "Completed Brewfile"
  fi
}
