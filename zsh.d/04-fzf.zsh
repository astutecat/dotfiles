if [[ ! -f "$HOME/.fzf.zsh"  ]]
then
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  ~/.fzf/install --key-bindings --completion --no-update-rc
fi

antigen bundle asdf

if [[ -n $(command -v fd) ]]
then
  export FZF_DEFAULT_COMMAND="fd --type file --follow --color=always --exclude .git"
  export FZF_DEFAULT_OPTS="--ansi"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
