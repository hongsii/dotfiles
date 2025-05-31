#!/bin/bash

set -e # Exit immediately if a command exits with a non-zero status

[[ "$LOGGER_LOADED" != true ]] && source "$HOME/.dotfiles/script/log.sh"

SCRIPT_DIR="$HOME/.dotfiles/tool"

for script in "$SCRIPT_DIR"/*.sh; do
    if [[ "$script" != "$SCRIPT_DIR/install.sh" ]]; then
        bash "$script"
        success "Completed $script"
    fi
done
