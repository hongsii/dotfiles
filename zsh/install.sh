#! /bin/bash

if test $(which zsh); then
    echo "Already installed zsh"
    exit 0
fi

chsh -s $(which zsh)
