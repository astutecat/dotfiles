# Return if requirements are not found.
if [[ "$TERM" == 'dumb' ]]; then
  return 1
fi

autoload -Uz compinit
compinit
