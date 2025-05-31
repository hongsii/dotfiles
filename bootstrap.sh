# !/bin/bash
#
# Based on https://github.com/holman/dotfiles/blob/master/script/bootstrap

# When raise first error, exit script
set -e
echo ''

# Declare global variable
DOTFILES_PATH=$(pwd -P)

# Declare function
include_functions() {
  local readonly SCRIPT_DIR="$DOTFILES_PATH/script"
  for script in $(find -H "$SCRIPT_DIR" -name "*.sh"); do
      source $script
  done
}

# Configuration
include_functions
setup_gitconfig

# Installation
run_install_dotfiles
run_install_homebrew
run_install_script
