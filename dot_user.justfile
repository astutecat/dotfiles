# vim: ft=just:
set shell := ["zsh", "-uc"]

[private]
default:
  @just --justfile "{{justfile()}}" --list

alias dt := dev-tmux

dev-tmux:
  tmux split-window -hd
  nvim

update-all: update-chezmoi update-brew update-asdf update-cargo

[macos]
update-brew:
  brew update
  brew upgrade

[linux]
[private]
update-brew:
  @ echo -n ""

update-chezmoi:
  chezmoi update --apply --init

update-asdf:
  asdf plugin update --all
  asdf update
  @source $HOME/.config/asdf/update_asdf_tools.zsh

cargo-update-result := `cargo install --list | grep cargo-update\ v || true`
update-cargo +crates="-a":
  @[[ -n $(echo "{{cargo-update-result}}") ]] || cargo install cargo-update
  cargo install-update {{crates}}

@tldr +args:
  [[ -n $TMUX ]] && tmux split-window -vb -d tldr --pager "{{args}}" || tldr --pager "{{args}}"

@dotfiles:
  [[ -n $TMUX ]] && tmux rename-window dotfiles
  chezmoi cd
