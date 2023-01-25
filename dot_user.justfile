[private]
default:
  @just --justfile "{{justfile()}}" --list

update:
  chezmoi update --apply
  asdf plugin update --all
  asdf update
  update_asdf_tools
