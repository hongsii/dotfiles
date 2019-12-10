if [ -x "$(command -v brew)" ]; then
    echo "Already install brew. skip this script"
    exit 0
fi

echo "   Install homebrew"
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

brew_file_name="BrewFile"
if [ ! -f "$brew_file_name" ]; then
    echo "$brew_file_name doesn't exist"
    exit 1
fi

brew update
brew install mas
brew bundle --file=./BrewFile
brew cleanup
brew csak cleanup

exit 0
