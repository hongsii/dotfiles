#! /bin/bash

if ! test $(which zsh); then
    echo "zsh musb be installed"
    exit 0
fi

cat <<EOF >> $HOME/.zshrc

# Load zsh files from dotfiles
typeset -U config_files
config_files=($HOME/.dotfiles/**/*.zsh)
for file in \$config_files
do
  source \$file
done
unset config_files

EOF

cat <<EOF >> $HOME/.zshrc

# Set local configuration
if [[ -a ~/.localrc ]]; then
  source ~/.localrc
fi
EOF


