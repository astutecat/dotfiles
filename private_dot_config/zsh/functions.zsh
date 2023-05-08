fpath=("${ZDOTDIR:-$HOME}/.zfunc" $fpath)
autoload -Uz is_cmd
autoload -Uz fix_zsh_history
autoload -Uz get_erl_version

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

tmux_rename() {
  [[ -n $TMUX ]] && tmux rename-window $@
}

lg() {
  if [[ -n $(command -v lazygit) ]]; then
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
      cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
      rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
  else
    echo "Error: lazygit not on PATH."
  fi
}
