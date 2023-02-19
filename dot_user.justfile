# vim: ft=just:
set shell := ["zsh", "-c"]

[private]
default:
  @just --justfile "{{justfile()}}" --list

alias n := nvim
@nvim: # nvim
  nvim

alias ns := split-nvim
@split-nvim: # launch nvim in a tmux split
  [[ -n $TMUX ]] || tmux
  tmux split-window -hd
  nvim

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
  chezmoi update --apply --init

update-asdf:
  asdf plugin update --all
  asdf update
  @source $HOME/.config/asdf/update_asdf_tools.zsh

update-rust:
  rustup update

cargo-update-result := `cargo install --list | grep cargo-update\ v || true`
update-cargo +crates="-a":
  @[[ -n $(echo "{{cargo-update-result}}") ]] || cargo install cargo-update
  cargo install-update {{crates}}

@tldr +args:
  [[ -n $TMUX ]] && tmux split-window -vb -d tldr --pager "{{args}}" || tldr --pager "{{args}}"

@dotfiles:
  [[ -n $TMUX ]] && tmux rename-window dotfiles || :
  chezmoi cd

pull-notebooks:
  docker pull jupyter/datascience-notebook

rm-notebooks:
  -docker rm notebooks

home := `echo $HOME`
uid := `echo $UID`
gid := `echo $GID`
user := `echo $USER`
default_dir := `echo $PWD`
run-notebooks dir=default_dir:
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

alias nb-stop := stop-notebooks
stop-notebooks:
  -docker stop notebooks

update-notebooks: pull-notebooks stop-notebooks rm-notebooks run-notebooks

