# vim: ft=just:
set shell := ["zsh", "-c"]

[private]
default:
  @just --justfile "{{justfile()}}" --list

@zellij:
  [ $ZELLIJ != 0 ] && [ ${UID} != 0 ] && zellij || :

dir_leaf := `echo "${PWD##*/}"`
alias trn := tab-rename
@tab-rename name=dir_leaf: zellij # rename zellij tab
  zellij action rename-tab {{name}}
alias prn := pane-rename
@pane-rename name=dir_leaf: zellij # rename zellij pane
  zellij action rename-pane {{name}}
alias srn := session-rename
@session-rename name=dir_leaf: zellij # rename zellij session
  zellij action rename-tab {{name}}

alias ns := split-nvim
split-nvim: # launch nvim in a tmux split
  zellij --layout nvim_split

update-all: update-chezmoi update-brew update-devbox update-mise

brewfile := `echo "$HOME/.config/homebrew/chezmoi.Brewfile"`
update-brew:
  [[ -n $(command -v brew) ]] && brew update || :
  [[ -n $(command -v brew) ]] && brew bundle upgrade --file={{brewfile}}
  [[ -n $(command -v brew) ]] && brew upgrade || :

update-devbox:
  [[ -n $(command -v devbox) ]] && devbox version update || :
  [[ -n $(command -v devbox) ]] && devbox global update  || :

update-chezmoi:
  chezmoi update --init
  chezmoi apply

[macos]
ensure-mise-plugins:
  mise --quiet plugins install erlang https://github.com/michallepicki/asdf-erlang-prebuilt-macos.git

[linux]
ensure-mise-plugins:
  @:

update-mise: ensure-mise-plugins
  #!/bin/bash
  gh_token=$([[ -n $(command -v gh) ]] && gh auth token 2>/dev/null || "")
  GITHUB_TOKEN="$gh_token" mise self-update
  GITHUB_TOKEN="$gh_token" mise upgrade

@tldr +args:
  zellij run -c -- tldr --pager "{{args}}"

@dotfiles:
  [ "$ZELLIJ" ] && zellij ac rename-tab dotfiles || :
  chezmoi cd

alias lg := lazygit
lazygit:
  #!/bin/bash
  if [[ -n $(command -v lazygit) ]]; then
    export LAZYGIT_NEW_DIR_FILE=~/.lazygit/newdir

    lazygit "$@"

    if [ -f $LAZYGIT_NEW_DIR_FILE ]; then
      cd "$(cat $LAZYGIT_NEW_DIR_FILE)"
      rm -f $LAZYGIT_NEW_DIR_FILE > /dev/null
    fi
  else
    echo "Error: lazygit not on PATH."
  fi

fortune +args="-s":
  #!/bin/zsh
  if (( $+commands[fortune] )); then
    fortune -s ~/.local/share/fortunes/ | fmt
  fi
