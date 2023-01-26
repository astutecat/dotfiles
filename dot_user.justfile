# vim: ft=just:
[private]
default:
  @just --justfile "{{justfile()}}" --list

update:
  chezmoi update --apply
  just asdf-update

asdf-update:
  asdf plugin update --all
  asdf update
  @source $HOME/.config/asdf/update_asdf_tools.zsh
