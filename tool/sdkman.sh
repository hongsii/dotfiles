#!/bin/bash

[[ "$LOGGER_LOADED" != true ]] && source "$HOME/.dotfiles/script/log.sh"

echo "$DOTFILES"

info "Installing sdkman"

if ! command -v brew &> /dev/null; then
    error "Homebrew is not installed."
    exit 1
fi

SDKMAN_DIR="$HOME/.sdkman"
if [ ! -d "$SDKMAN_DIR" ]; then
    curl -s "https://get.sdkman.io" | bash
    success "Downloaded sdkman installation"
fi

source "$SDKMAN_DIR/bin/sdkman-init.sh"
ZSHRC_FILE="$HOME/.zshrc"
if ! grep -q "sdkman-init.sh" "$ZSHRC_FILE"; then
    echo "[[ -s \"$SDKMAN_DIR/bin/sdkman-init.sh\" ]] && source \"$SDKMAN_DIR/bin/sdkman-init.sh\"" >> "$ZSHRC_FILE"
fi

success "Installed sdkman"
