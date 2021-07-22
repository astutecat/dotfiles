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