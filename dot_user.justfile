# vim: ft=just:
set shell := ["zsh", "-c"]

[private]
default:
  @just --justfile "{{justfile()}}" --list

alias n := nvim
@nvim: # nvim
  nvim

alias trn := tmux-rename
dir_leaf := `echo "${PWD##*/}"`
@tmux-rename name=dir_leaf: # rename tmux window
  tmux rename-window "{{name}}"\;

alias ns := split-nvim
split-nvim: # launch nvim in a tmux split
  #!/bin/bash
  dir="${PWD##*/}"
  if [[ -n $TMUX ]]; then
    tmux rename-window "$dir"\; split-window -hd\; send-keys 'nvim' C-m \;
  else
    tmux new-session\; rename-window "$dir"\; split-window -hd\; send-keys 'nvim' C-m \;
  fi

update-all: update-chezmoi update-brew update-asdf update-rust update-cargo

[macos]
update-brew:
  brew update
  brew upgrade

[linux]
[private]
update-brew:
  @ :

update-chezmoi:
  chezmoi update --init
  chezmoi apply

update-asdf:
  asdf plugin update --all
  asdf update
  @source $HOME/.config/asdf/update_asdf_tools.zsh

update-rust:
  rustup update

cargo-update-result := `cargo install --list | grep cargo-update\ v || true`
update-cargo +crates="-a":
  @[[ -n $(echo "{{cargo-update-result}}") ]] || cargo install cargo-update
  @[[ -n $(command -v eza ) ]] || cargo install eza
  cargo install-update {{crates}}

@tldr +args:
  [[ -n $TMUX ]] && tmux split-window -vb -d tldr --pager "{{args}}" || tldr --pager "{{args}}"

@dotfiles:
  [[ -n $TMUX ]] && tmux rename-window dotfiles || :
  chezmoi cd

pull-notebooks:
  docker pull jupyter/datascience-notebook

rm-notebooks: stop-notebooks
  -docker rm notebooks-local

home := `echo $HOME`
uid := `id -u`
gid := `id -g`
user := `echo $USER`
repo_dir := "~/repos"
run-notebooks dir=repo_dir:
  docker run -d \
    --name notebooks-local \
    -p 8888:8888 \
    --user root \
    -e NB_UID={{uid}} \
    -e NB_GID={{uid}} \
    -e NB_USER={{user}} \
    -e CHOWN_HOME=yes \
    -w "/home/{{user}}" \
    -v {{dir}}:/home/{{user}} \
    jupyter/datascience-notebook \
    start-notebook.sh --NotebookApp.password='argon2:$argon2id$v=19$m=10240,t=10,p=8$PcUNXQ+xDS+gw9BaJgbDrg$HSbxAbje0q8PGJnmgMwaFraKBuAvTIVrhitBuIpAVs8'
  docker exec -it notebooks-local conda install -y -c conda-forge jupyterlab-git

run-livebook dir=repo_dir:
  docker run -d --name livebook-local -p 8080:8080 -p 8081:8081 --pull always -u {{uid}}:{{gid}} -v {{repo_dir}}:/data livebook/livebook

alias nb-stop := stop-notebooks
stop-notebooks:
  -docker stop notebooks-local
  -docker stop livebook-local

update-notebooks dir=repo_dir: pull-notebooks stop-notebooks rm-notebooks (run-notebooks dir)

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
