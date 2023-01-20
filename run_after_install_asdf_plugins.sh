#!/bin/zsh
[[ -n $(command -v asdf) ]] || return;

if [[ -z $(command -v adr) ]]; then
  asdf plugin add adr-tools
  asdf install adr-tools latest
  asdf global adr-tools latest
fi

if [[ -z $(command -v sops) ]]; then
  asdf plugin add sops
  asdf install sops latest
  asdf global sops latest
fi
