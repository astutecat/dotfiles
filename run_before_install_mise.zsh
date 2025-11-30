#!/bin/zsh
setopt null_glob
if [[ -n $(command -v mise) ]]; then
    :
else
    curl https://mise.run | sh
    mise install cargo:just
fi
