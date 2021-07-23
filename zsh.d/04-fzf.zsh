if [[ ! -f "$HOME/.fzf.zsh"  ]]
then
  git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
  ~/.fzf/install --key-bindings --completion --no-update-rc
fi

antigen bundle asdf

if [[ -n $(command -v fd) ]]
then
  export FZF_DEFAULT_COMMAND="fd --type file --follow --color=always --exclude .git"
  export FZF_DEFAULT_OPTS='--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi
