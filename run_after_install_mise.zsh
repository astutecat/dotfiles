#!/bin/zsh
setopt null_glob
[[ -n $(command -v mise) ]] || exit 0;

curl https://mise.run | sh
