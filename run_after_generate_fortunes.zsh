#!/bin/zsh

[[ -n $(command -v fortune) ]] || return;

output_dir="$HOME/.local/share/fortunes"
pushd $output_dir
  rm *.dat
  for file in *; do
      strfile -s ${file}
  done
popd
