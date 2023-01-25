#!/bin/zsh

fpath=("${ZDOTDIR:-$HOME}/.zfunc" $fpath)
autoload -Uz install_asdf_tools
install_asdf_tools
