#!/bin/bash

# Install VimPlug
curl -sfLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Apply vimrc
vim ~/.vimrc '+so %' +PlugInstall +qall < /dev/tty
