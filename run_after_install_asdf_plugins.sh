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

if [[ -z $(command -v just) ]]; then
  asdf plugin add just
  asdf install just latest
  asdf global just latest
fi
