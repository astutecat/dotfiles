# vim: ft=just:
set shell := ["zsh", "-c"]

[private]
default:
  @just --justfile "{{justfile()}}" --list

alias t := tmux
tmux:
  #!/bin/bash
  if [ -z "$TMUX" ] && [ ${UID} != 0 ]
  then
      tmux new-session -A -s main
  fi

alias trn := tmux-rename
dir_leaf := `echo "${PWD##*/}"`
@tmux-rename name=dir_leaf: tmux # rename tmux window
  tmux rename-window "{{name}}"\;

alias ns := split-nvim
split-nvim percent="30": # launch nvim in a tmux split
  #!/bin/bash
  dir="${PWD##*/}"
  if [[ -n $TMUX ]]; then
    tmux rename-window "$dir"\; split-window -hd -p {{percent}}\; send-keys 'nvim' C-m \;
  else
    tmux new-session -A -s main\; rename-window "$dir"\; split-window -hd -p {{percent}}\; send-keys 'nvim' C-m \;
  fi


update-all: update-chezmoi update-brew update-devbox update-mise

[macos]
update-brew:
  brew update
  brew upgrade

[linux]
[private]
update-brew:
  @ :

update-devbox:
  [[ -n $(command -v devbox) ]] && devbox version update || :
  [[ -n $(command -v devbox) ]] && devbox global update  || :

update-chezmoi:
  chezmoi update --init
  chezmoi apply

[macos]
ensure-mise-plugins:
  mise --quiet plugins install erlang https://github.com/michallepicki/asdf-erlang-prebuilt-macos.git
  mise --quiet plugins install lazydocker https://github.com/comdotlinux/asdf-lazydocker.git
  mise --quiet plugins install lazygit https://github.com/nklmilojevic/asdf-lazygit.git

[linux]
ensure-mise-plugins:
  mise --quiet plugins install lazydocker https://github.com/comdotlinux/asdf-lazydocker.git
  mise --quiet plugins install lazygit https://github.com/nklmilojevic/asdf-lazygit.git

gh_token := `[[ -n $(command -v gh) ]] && gh auth token 2>/dev/null`
update-mise: ensure-mise-plugins
  #!/bin/bash
  GITHUB_TOKEN={{gh_token}} mise self-update
  GITHUB_TOKEN={{gh_token}} mise upgrade

@tldr +args:
  [[ -n $TMUX ]] && tmux split-window -vb -d tldr --pager "{{args}}" || tldr --pager "{{args}}"

@dotfiles:
  [[ -n $TMUX ]] && tmux rename-window dotfiles || :
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
