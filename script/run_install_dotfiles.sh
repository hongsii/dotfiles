#!/bin/bash

# Apply dotfiles to symbolic link
run_install_dotfiles() {
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
