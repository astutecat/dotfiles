#!/bin/zsh
setopt null_glob
if [[ -n $(command -v mise) ]]; then
  :
else
  curl https://mise.run | sh
  mise install cargo:just
fi

if [[ -n $(command -v just) ]]; then
  just --justfile $HOME/.user.justfile --working-directory . ensure-mise-plugins 2>/dev/null
fi
