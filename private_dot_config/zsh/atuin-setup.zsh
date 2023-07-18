if [[ ! $(is_cmd atuin) ]]; then
  return
fi

eval "$(atuin init zsh)"
