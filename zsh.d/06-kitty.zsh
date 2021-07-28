mkdir -p ~/.config/kitty
[[ -h ~/.config/kitty/kitty.conf ]] || ln -sf ~/.kitty.conf ~/.config/kitty/kitty.conf

if [[ $TERM == 'xterm-kitty' ]]; then
  alias ssh="kitty +kitten ssh"
  alias icat="kitty +kitten icat"
fi
