#!/bin/bash

[[ "$LOGGER_LOADED" != true ]] && source "$HOME/.dotfiles/script/log.sh"

# Install VimPlug
plug_file=~/.vim/autoload/plug.vim
if [ ! -f "$plug_file" ]; then
    curl -sfLo $plug_file --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    success "Downloaded vim-plug"
fi 

# Apply vimrc
vim ~/.vimrc '+so %' +PlugInstall +qall < /dev/tty
success "Installed vim-plug"
