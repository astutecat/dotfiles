# vim: ft=just:
set shell := ["zsh", "-uc"]

[private]
default:
  @just --justfile "{{justfile()}}" --list

update: chezmoi-update asdf-update

chezmoi-update:
  chezmoi update --apply --init

asdf-update:
  asdf plugin update --all
  asdf update
  @source $HOME/.config/asdf/update_asdf_tools.zsh
