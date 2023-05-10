#!/bin/zsh

[[ -n $(command -v fortune) ]] || exit 0;

output_dir="$HOME/.local/share/fortunes"
pushd $output_dir
  rm *.dat
  for file in *; do
      strfile -s ${file}
  done
popd
