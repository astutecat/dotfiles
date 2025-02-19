if is_cmd cog; then
  cog generate-completions zsh >! "${ZDOTDIR:-$HOME}/.zfunc/_cog"
fi

if is_cmd rustup; then
  rustup completions zsh >! "${ZDOTDIR:-$HOME}/.zfunc/_rustup"
fi

if is_cmd just; then
  just --completions zsh >! "${ZDOTDIR:-$HOME}/.zfunc/_just"
fi

if is_cmd atuin; then
  atuin gen-completions --shell zsh >! "${ZDOTDIR:-$HOME}/.zfunc/_atuin"
fi

if is_cmd stg; then
  stg completion zsh >! "${ZDOTDIR:-$HOME}/.zfunc/_stg"
fi

if is_cmd devox; then
  devbox completion zsh >! "${ZDOTDIR:-$HOME}/.zfunc/_devbox"
fi

if is_cmd restic; then
  restic generate --zsh-completion "${ZDOTDIR:-$HOME}/.zfunc/_restic" > /dev/null
fi

autoload -Uz compinit bashcompinit
compinit
bashcompinit
