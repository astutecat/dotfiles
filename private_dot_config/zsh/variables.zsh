if is_cmd nvim; then
  export EDITOR="nvim"
fi
if is_cmd bat; then
  export BAT_THEME="Dracula"
fi
if is_cmd most; then
  export PAGER="most"
fi

export ASDF_PYTHON_DEFAULT_PACKAGES_FILE="$HOME/.config/asdf/.default-python-packages"
