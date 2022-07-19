is_cmd() {
  [[ -n $(command -v $1) ]]
}

qpushd() {
    pushd $1 > /dev/null
}

qpopd() {
    popd > /dev/null
}

fix_zsh_history() {
  mv ~/.zsh_history ~/.zsh_history_bad
  strings -eS ~/.zsh_history_bad > ~/.zsh_history
  #R in capital gives an error so the solution
  fc -r ~/.zsh_history
  rm ~/.zsh_history_bad
}

split_tldr() {
  [[ -n $TMUX ]] && tmux split-window -vb -d tldr "$@" || tldr "$@"
}

