# vim: ft=just:
set shell := ["zsh", "-uc"]

[private]
default:
  @just --justfile "{{justfile()}}" --list

update: chezmoi-update brew-update asdf-update

[macos]
brew-update:
  brew update
  brew upgrade

[linux]
[private]
brew-update:
  @ echo -n ""

chezmoi-update:
  chezmoi update --apply --init

asdf-update:
  asdf plugin update --all
  asdf update
  @source $HOME/.config/asdf/update_asdf_tools.zsh

tldr +args:
  [[ -n $TMUX ]] && tmux split-window -vb -d tldr --pager "{{args}}" || tldr --pager "{{args}}"

@dotfiles:
  [[ -n $TMUX ]] && tmux rename-window dotfiles
  chezmoi cd
