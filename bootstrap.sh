#!/bin/bash
#
# Based on https://github.com/holman/dotfiles/blob/master/script/bootstrap

# When raise first error, exit script
set -e
echo ''

# Declare global variable
DOTFILES_ROOT=$(pwd -P)

# Include log function
SCRIPT_DIR="$DOTFILES_ROOT/script"
source $SCRIPT_DIR/log.sh

# Declare function
setup_gitconfig() {
  if ! [ -f git/gitconfig.local.symlink ]
  then
    info 'setup gitconfig'

    git_credential='cache'
    if [ "$(uname -s)" == "Darwin" ]
    then
      git_credential='osxkeychain'
    fi

    user ' - What is your github author name?'
    read -e git_authorname
    user ' - What is your github author email?'
    read -e git_authoremail

    sed -e "s/AUTHORNAME/$git_authorname/g" -e "s/AUTHOREMAIL/$git_authoremail/g" -e "s/GIT_CREDENTIAL_HELPER/$git_credential/g" git/gitconfig.local.symlink.example > git/gitconfig.local.symlink

    success 'gitconfig'
  fi
}

link_file() {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]; then
    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]; then
      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]; then
        skip=true;
      else
        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac
      fi
    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}

# apply dotfiles to symbolic link
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
install_dotfiles
