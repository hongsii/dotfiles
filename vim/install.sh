#!/bin/bash

# Install VimPlug
plug_file=~/.vim/autoload/plug.vim
if [ ! -f "$plug_file" ]; then
    echo "Download vim-plug"
    curl -sfLo $plug_file --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi 

# Apply vimrc
vim ~/.vimrc '+so %' +PlugInstall +qall < /dev/tty
