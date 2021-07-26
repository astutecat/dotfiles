if [[ -d /Library && ! -d /Applications/kitty.app ]]; then
  brew install kitty
fi

if [[ ! -d /Library && ! -d ~/.local/kitty.app ]]; then
  # Kitty doesn't exist, install it.
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n

  mkdir -p ~/.local/bin
  ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
  cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
  sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty.desktop
fi

mkdir -p ~/.config/kitty
[[ -h ~/.config/kitty/kitty.conf ]] || ln -sf ~/.kitty.conf ~/.config/kitty/kitty.conf

if [[ $TERM == 'xterm-kitty' ]]; then
  alias ssh="kitty +kitten ssh"
  alias icat="kitty +kitten icat"
fi
