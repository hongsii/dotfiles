#!/bin/bash

LOGGER_LOADED=true

# logger
info () { printf "\r  [ \033[00;34m..\033[0m ] $1\n"; }
user () { printf "\r  [ \033[0;33m??\033[0m ] $1\n"; }
success () { printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"; }
error () { printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"; }
fail () { error $1; echo ''; exit; }
