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

install_brew() {
  if command -v brew &>/dev/null; then
    info 'Homebrew is already installed.'
  else
    info 'Homebrew is not installed. Installing Homebrew...'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    info 'Homebrew installation completed.'
  fi

  # bundle Brewfile
  local brewfile_path="$DOTFILES_PATH/homebrew/BrewFile"
  if [[ -f "$brewfile_path" ]]; then
    info "Brewfile found at $brewfile_path. Installing packages..."
    brew bundle --file="$brewfile_path"
    brew cleanup
    info "Package installation from Brewfile completed."
  else
    info "Brewfile not found at $brewfile_path. Skipping package installation."
  fi
}

# Apply dotfiles to symbolic link
install_dotfiles() {
  info 'installing dotfiles'
  local overwrite_all=false backup_all=false skip_all=false

  for src in $(find -H "$DOTFILES_PATH" -maxdepth 5 -name '*.symlink' -not -path '*.git*')
  do
    dst="$HOME/.$(basename "${src%.*}")"
    dir_path=$(dirname ${src/$DOTFILES_PATH/.})
    dir_depth=$(echo $dir_path | grep -o '/' | wc -l)
    if (( $dir_depth > 1 )); then
      dst_dir="$(echo $dir_path | sed -E 's/^\.\/[^\/]*\///g')"
      dst="$HOME/.$dst_dir/$(basename "${src%.*}")"
      mkdir -p $(dirname $dst)
    fi
    link_file "$src" "$dst"
  done
}

include_functions
install_brew
setup_gitconfig
install_dotfiles
run_install_script
