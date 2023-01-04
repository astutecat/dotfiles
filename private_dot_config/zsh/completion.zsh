if is_cmd cog; then
  cog generate-completions zsh >! "${ZDOTDIR:-$HOME}/.zfunc/_cog"
fi

if is_cmd rustup; then
  rustup completions zsh >! "${ZDOTDIR:-$HOME}/.zfunc/_rustup"
fi

if is_cmd just; then
  just --completions zsh >! "${ZDOTDIR:-$HOME}/.zfunc/_just"
fi

autoload -Uz compinit bashcompinit
compinit
bashcompinit
