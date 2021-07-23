if [[ ! -d ~/.local/kitty.app && ! -d /Applications/kitty.app ]]; then
  # Kitty doesn't exist, install it.
  curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin launch=n

  if [[ ! -d /Applications/ ]]; then
    mkdir -p ~/.local/bin
    ln -s ~/.local/kitty.app/bin/kitty ~/.local/bin/
    cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
    sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty.desktop
  fi
fi

if [[ ! -d /Applications/kitty.app ]]; then
  export PATH=$PATH:~/.local/bin
fi

mkdir -p ~/.config/kitty
[[ -h ~/.config/kitty/kitty.conf ]] || ln -s ~/.kitty.conf ~/.config/kitty/kitty.conf
