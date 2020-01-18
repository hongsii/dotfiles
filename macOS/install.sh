#! /bin/sh
#
# Based on https://github.com/holman/dotfiles/blob/master/macos

echo "  > Update software for macOS"
sudo softwareupdate -i -a > /dev/null

echo "  > Apply configuration"
# Change won to backtick
target_dir=$HOME/Library/KeyBindings
mkdir -p $target_dir
cat > $target_dir/DefaultkeyBinding.dict <<- "EOF"
{
    "₩" = ("insertText:", "`");
}
EOF

# set defaults

## Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false

