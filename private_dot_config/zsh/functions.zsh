fpath=("${ZDOTDIR:-$HOME}/.zfunc" $fpath)
autoload -Uz is_cmd
autoload -Uz fix_zsh_history
autoload -Uz test_dircolors
autoload -Uz install_asdf_tools
autoload -Uz update_asdf_tools

qpushd() {
    pushd $1 > /dev/null
}

qpopd() {
    popd > /dev/null
}

split_tldr() {
  [[ -n $TMUX ]] && tmux split-window -vb -d tldr "$@" || tldr "$@"
}

source_if_exists() {
  [ -f $1 ] && source $1
}

