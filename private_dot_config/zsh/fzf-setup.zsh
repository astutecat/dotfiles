if [[ ! -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ]]; then
  echo -n "Setting up fzf..."
  $HOME/.fzf/install \
    --xdg \
    --key-bindings \
    --completion \
    --no-fish \
    --no-bash \
    --no-update-rc \
    >/dev/null
  echo "done."
fi

source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

if is_cmd fd; then
  export FZF_DEFAULT_COMMAND="fd --type file --follow --color=always --exclude .git --exclude .hg"
  export FZF_DEFAULT_OPTIONS="--ansi"
fi
