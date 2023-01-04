if [ $(is_cmd cog) ] && [ ! -f "${ZDOTDIR:-$HOME}/.zfunc/_cog" ]; then
  cog generate_completions zsh > "${ZDOTDIR:-$HOME}/.zfunc/_cog"
fi

autoload -Uz compinit bashcompinit
compinit
bashcompinit
