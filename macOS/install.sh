#! /bin/sh


# won to backtick
target_dir=$HOME/Library/KeyBindings
mkdir -p $target_dir
cat > $target_dir/DefaultkeyBinding.dict <<- "EOF"
{
    "₩" = ("insertText:", "`");
}
EOF
