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

## Disable Misson Control > Automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false
## Apply dock options
defaults write com.apple.dock autohide -bool true # 자동으로 Dock 가리기와 보기
defaults write com.apple.dock tilesize -int 60 # 크기 (max: 128)
defaults write com.apple.dock largesize -int 60 # 확대 (max: 128)
defaults write com.apple.dock show-recents -bool false # Dock에서 최근 사용한 응용 프로그램 보기
killall Dock
