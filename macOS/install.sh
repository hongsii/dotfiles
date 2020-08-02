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

## Finder
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true

## Disable press-and-hold for keys in favor of key repeat.
defaults write -g ApplePressAndHoldEnabled -bool false
defaults write -g InitialKeyRepeat -int 15 # min : 15
defaults write -g KeyRepeat -int 1 # min : 1

## Apply Mission Control options
defaults write com.apple.dock mru-spaces -bool false # Spaces를 최근 사용 내역에 따라 자동으로 재정렬
defaults write com.apple.dock expose-group-apps -bool true # 응용 프로그램별로 윈도우 그룹 생성
## Apply dock options
defaults write com.apple.dock autohide -bool true # 자동으로 Dock 가리기와 보기
defaults write com.apple.dock autohide-delay -float 0 # Dock 가리기 및 보기 시 딜레이 제거
defaults write com.apple.dock tilesize -int 60 # 크기 (max: 128)
defaults write com.apple.dock largesize -int 60 # 확대 (max: 128)
defaults write com.apple.dock show-recents -bool false # Dock에서 최근 사용한 응용 프로그램 보기
killall Dock # Dock 설정 적용

## Remove siri icon on menubar
defaults write com.apple.Siri StatusMenuVisible -bool false

## Add menu bar icon
defaults write com.apple.systemuiserver menuExtras -array \
    "/System/Library/CoreServices/Menu Extras/Battery.menu" \
    "/System/Library/CoreServices/Menu Extras/Clock.menu" \
    "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
    "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
    "/System/Library/CoreServices/Menu Extras/Volume.menu" \
    "/System/Library/CoreServices/Menu Extras/Displays.menu"
killall SystemUIServer
