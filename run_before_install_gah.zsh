#!/bin/zsh

if [[ -n $(command -v gah) ]]; then
  gah update > /dev/null
else
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/marverix/gah/refs/heads/master/tools/install.sh)"
fi
