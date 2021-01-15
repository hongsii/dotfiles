_fzf_complete_ssh() {
  _fzf_complete -- "$@" < <(
    grep -r --exclude="*.txt" "^Host " ~/.ssh/config.d/ | grep -v "*" | awk '{print $2}'
  )
}

[ -n "$BASH" ] && complete -F _fzf_complete_ssh -o default -o bashdefault ssh
