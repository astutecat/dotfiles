[[ -f "$HOME/.asdf/asdf.sh" ]] || return;

source "$HOME/.asdf/asdf.sh"
fpath=(${ASDF_DIR}/completions $fpath)
antigen bundle asdf