#! /bin/bash
#
# Based on https://github.com/holman/dotfiles/blob/master/macos
# Based on https://github.com/ulwlu/dotfiles/blob/master/system/macos.sh

# Change won to backtick
target_dir=$HOME/Library/KeyBindings
mkdir -p $target_dir
cat > $target_dir/DefaultkeyBinding.dict <<- "EOF"
{
    "₩" = ("insertText:", "`");
}
EOF

Keyboard() {
    # Keyboard will apply after reboot

    # 15 is the fastest. default is 10
    defaults write -g InitialKeyRepeat -int 15
    # 2 is the fastest.
    defaults write -g KeyRepeat -int 2
    # Disable press-and-hold for keys in favor of key repeat.
    defaults write -g ApplePressAndHoldEnabled -bool false

    # Switch Modifier Keys
    osascript -e '
    tell application "System Preferences"
        activate
        reveal anchor "keyboardTab" of pane id "com.apple.preference.keyboard"
    end tell

    tell application "System Events"
        tell application process "System Preferences"
            delay 0.5
            tell window "키보드"
                click button "보조 키…" of tab group 1
                -- Caps lock
                tell pop up button 2 of sheet 1
                    click
                    click menu item 2 of menu 1
                end tell
                click button "확인" of sheet 1
            end tell
        end tell
    end tell
    '

    # Binding Input Source shortcut
    osascript -e '
    tell application "System Preferences"
        activate
        reveal anchor "shortcutsTab" of pane id "com.apple.preference.keyboard"
    end tell
    tell application "System Events"
        tell application process "System Preferences"
            repeat while not (window 1 exists)
            end repeat
            tell window 1
                repeat while not (rows of table 1 of scroll area 1 of splitter group 1 of tab group 1 exists)
                end repeat
                repeat with current_row in (rows of table 1 of scroll area 1 of splitter group 1 of tab group 1)
                    if value of static text 1 of current_row is equal to "입력 소스" then
                        select current_row
                        exit repeat
                    end if
                end repeat
                repeat while not (rows of outline 1 of scroll area 2 of splitter group 1 of tab group 1 exists)
                end repeat
                repeat with current_row in rows of outline 1 of scroll area 2 of splitter group 1 of tab group 1
                    if name of UI element 2 of current_row is equal to "이전 입력 소스 선택" then
                        select current_row
                        key code 48
                        -- Change shortcut
                        keystroke space using {command down}
                        exit repeat
                    end if
                end repeat
            end tell
        end tell
    end tell
    '

    # Binding Spotlight shortcut
    osascript -e "
    tell application \"System Preferences\"
      activate
      reveal anchor \"shortcutsTab\" of pane id \"com.apple.preference.keyboard\"
    end tell
    tell application \"System Events\"
      tell application process \"System Preferences\"
        repeat while not (window 1 exists)
        end repeat
      tell window 1
      repeat while not (rows of table 1 of scroll area 1 of splitter group 1 of tab group 1 exists)
      end repeat
      repeat with current_row in (rows of table 1 of scroll area 1 of splitter group 1 of tab group 1)
        if value of static text 1 of current_row is equal to \"Spotlight\" then
          select current_row
          exit repeat
        end if
      end repeat
      repeat while not (rows of outline 1 of scroll area 2 of splitter group 1 of tab group 1 exists)
      end repeat
      repeat with current_row in rows of outline 1 of scroll area 2 of splitter group 1 of tab group 1
        if name of UI element 2 of current_row is equal to \"Spotlight 검색 보기\" then
          select current_row
					key code 48
					-- Change shortcut
					keystroke space using {shift down, command down}
          exit repeat
        end if
      end repeat
      end tell
      end tell
    end tell
    "
}

Trackpad() {
    # Secondary click
    #  - Click or tap with two fingers
    defaults write .GlobalPreferences ContextMenuGesture -int 1
    defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
    defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 0
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 0
    #  - Click in bottom right corner
    # defaults write .GlobalPreferences ContextMenuGesture -int 1
    # defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool false
    # defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
    # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool false
    # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
    #  - Click in bottom left corner
    # defaults write .GlobalPreferences ContextMenuGesture -int 1
    # defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool false
    # defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 1
    # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool false
    # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 1
    # - Unchecked
    # defaults write .GlobalPreferences ContextMenuGesture -int 0
    # defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool false
    # defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 0
    # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool false
    # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 0

    # Tab to click
    defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true

    # Click
    # Light: 0 Medium: 1 Firm: 2
    defaults write -g com.apple.trackpad.forceClick 0

    # Slow: 0 Fast: 3
    defaults write -g com.apple.trackpad.scaling -float 1.5

    # Swipe between full-screen apps (2: Chcked, 0: Unchecked)
    #  - Scroll left or right with four fingers
    defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerHorizSwipeGesture -int 2
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerHorizSwipeGesture -int 2
    #  - Scroll left or right with three fingers
    # defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerHorizSwipeGesture -int 2
    # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 2

    # Mission Control (2: Chcked, 0: Unchecked)
    #  - Swipe up with four fingers
    defaults write com.apple.AppleMultitouchTrackpad TrackpadFourFingerVertSwipeGesture -int 2
    defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadFourFingerVertSwipeGesture -int 2
    #  - Swipe up with three fingers
    # defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerVertSwipeGesture -int 2
    # defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerVertSwipeGesture -int 2
}

Finder() {
    # Show bar
    defaults write com.apple.finder ShowStatusBar -bool true
    defaults write com.apple.finder ShowPathbar -bool true

    # New Finder windows
    defaults write com.apple.finder NewWindowTarget -string "PfLo"
    defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Downloads/"

    # Show all file extensions
    defaults write -g AppleShowAllExtensions -bool true
}


MissionControl() {
    defaults write com.apple.dock mru-spaces -bool false # Spaces를 최근 사용 내역에 따라 자동으로 재정렬
    defaults write com.apple.dock expose-group-apps -bool true # 응용 프로그램별로 윈도우 그룹 생성
}

Dock() {
    defaults write com.apple.dock autohide -bool true # 자동으로 Dock 가리기와 보기
    defaults write com.apple.dock autohide-delay -float 0 # Dock 가리기 및 보기 시 딜레이 제거
    defaults write com.apple.dock tilesize -int 60 # 크기 (max: 128)
    defaults write com.apple.dock largesize -int 60 # 확대 (max: 128)
    defaults write com.apple.dock show-recents -bool false # Dock에서 최근 사용한 응용 프로그램 보기
}

Siri() {
    # Remove siri icon on menubar
    defaults write com.apple.Siri StatusMenuVisible -bool false
}

Menubar() {
    # Show battery percentage
    defaults write ~/Library/Preferences/ByHost/com.apple.controlcenter.plist BatteryShowPercentage -bool true
}

Keyboard
Trackpad
Finder
MissionControl
Dock
Siri
Menubar

# Cache Clear
caches=(
    "cfprefsd" "Activity Monitor" "Dock" "Finder" "SystemUIServer"
)
for app in "${caches[@]}"
do
    killall "${app}"
done
