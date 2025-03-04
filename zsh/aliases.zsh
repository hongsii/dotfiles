alias reload!='. ~/.zshrc'
alias curltime='curl -w "@$ZSH/curl/time-format.txt"'
alias hcopy='copied=$(history -r 1 | fzf | awk '\''{$1=""; print substr($0,2)}'\'') && echo "Copied Comand: $copied" && echo -n "$copied" | pbcopy'
