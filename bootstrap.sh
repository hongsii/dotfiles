#!/bin/bash# 
#
# Based on https://github.com/holman/dotfiles/blob/master/script/bootstrap

# When raise first error, exit script
set -e
echo ''

# Declare global variable
DOTFILES_ROOT=$(pwd -P)

# Declare function
include_functions() {
  local readonly SCRIPT_DIR="$DOTFILES_ROOT/script"
  for script in $(find -H "$SCRIPT_DIR" -name "*.sh"); do
      source $script
  done
}

# Apply dotfiles to symbolic link
install_dotfiles() {
  info 'installing dotfiles'
  local overwrite_all=false backup_all=false skip_all=false

  for src in $(find -H "$DOTFILES_ROOT" -maxdepth 5 -name '*.symlink' -not -path '*.git*')
  do
    dst="$HOME/.$(basename "${src%.*}")"
    dir_path=$(dirname ${src/$DOTFILES_ROOT/.})
    dir_depth=$(echo $dir_path | grep -o '/' | wc -l)
    if (( $dir_depth > 1 )); then
      dst_dir="$(echo $dir_path | sed -E 's/^\.\/.+\///g')"
      dst="$HOME/.$dst_dir/$(basename "${src%.*}")"
      mkdir -p $(dirname $dst)
    fi
    link_file "$src" "$dst"
  done
}

# setup_gitconfig
include_functions
install_dotfiles
