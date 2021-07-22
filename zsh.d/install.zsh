link_dotfile() {
  new_name=".${1:1}"

  [ -h "$HOME/$new_name" ] && echo "skipping $new_name (link) " && return
  [ -f "$HOME/$new_name" ] && echo "skipping $new_name (file) " && return
  [ -d "$HOME/$new_name" ] && echo "skipping $new_name (dir) " && return

  if [ -v SSH_TTY ] && [ $1 = "_tmux.conf" ]; then
    echo "skipping .tmux.conf because on ssh"
    return
  fi

  echo "linking $PWD/$1 -> ~/$new_name"
  ln -s $PWD/$1 "$HOME/$new_name"
}

install_dotfiles() {
  source "$HOME/.dotfiles-dir"
  [ ! -d "$DOTFILES" ] && return
  echo "installing from $DOTFILES..."
  (
    pushd $DOTFILES > /dev/null
    for file in _*; do
      link_dotfile $file
    done
    popd > /dev/null
  )
}