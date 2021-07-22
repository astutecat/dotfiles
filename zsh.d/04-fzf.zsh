[[-f "$HOME/.fzf.zsh" ]] || return

source "$HOME/.fzf.zsh"
antigen bundle fzf

if [[ -n $(command -v fd) ]]
then
  export FZF_DEFAULT_COMMAND="fd --type file --follow --color=always --exclude .git"
  export FZF_DEFAULT_OPTS="--ansi"
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
