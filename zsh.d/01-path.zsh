if is_cmd rustc; then
  export RUST_SRC_PATH=$(rustc --print sysroot)/lib/rustlib/src/rust/library
fi

if is_cmd go; then
  export PATH=$PATH:$(go env GOPATH)/bin
  export GOPATH=$(go env GOPATH)
fi

if is_cmd vim; then
  export EDITOR='vim'
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if is_cmd brew; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

if [[ -d ~/.local/bin ]]; then
  export PATH=$PATH:~/.local/bin
fi
