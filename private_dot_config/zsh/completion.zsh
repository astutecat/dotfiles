if is_cmd cog; then
  cog generate-completions zsh >! "${ZDOTDIR:-$HOME}/.zfunc/_cog"
fi

if is_cmd rustup; then
  rustup completions zsh >! "${ZDOTDIR:-$HOME}/.zfunc/_rustup"
fi

autoload -Uz compinit bashcompinit
compinit
bashcompinit
