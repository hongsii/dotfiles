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

## Apply Mission Control options
defaults write com.apple.dock mru-spaces -bool false # Spaces를 최근 사용 내역에 따라 자동으로 재정렬
defaults write com.apple.dock expose-group-apps -bool true # 응용 프로그램별로 윈도우 그룹 생성
## Apply dock options
defaults write com.apple.dock autohide -bool true # 자동으로 Dock 가리기와 보기
defaults write com.apple.dock tilesize -int 60 # 크기 (max: 128)
defaults write com.apple.dock largesize -int 60 # 확대 (max: 128)
defaults write com.apple.dock show-recents -bool false # Dock에서 최근 사용한 응용 프로그램 보기
killall Dock # Dock 설정 적용
