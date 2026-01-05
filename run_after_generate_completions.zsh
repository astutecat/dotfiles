#!/bin/zsh
#
# function is_cmd() {
#   [[ -n $(command -v $1) ]]
# }
#
# function  zcompare() {
#     if [[ -s ${1} && ( ! -s "${1}.zwc" || ${1} -nt "${1}.zwc") ]]; then
#       zcompile ${1}
#     fi
# }
#
# zfuncdir="${ZDOTDIR:-$HOME}/.zfunc"
#
# if is_cmd cog; then
#   cog generate-completions zsh >! "${zfuncdir}/_cog"
# fi
#
# if is_cmd rustup; then
#   rustup completions zsh >! "${zfuncdir}/_rustup"
# fi
#
# if is_cmd just; then
#   just --completions zsh >! "${zfuncdir}/_just"
# fi
#
# if is_cmd atuin; then
#   atuin gen-completions --shell zsh >! "${zfuncdir}/_atuin"
# fi
#
# if is_cmd stg; then
#   stg completion zsh >! "${zfuncdir}/_stg"
# fi
#
# if is_cmd devbox; then
#   devbox completion zsh >! "${zfuncdir}/_devbox"
# fi
#
# if is_cmd restic; then
#   restic generate --zsh-completion "${zfuncdir}/_restic" > /dev/null
# fi
#
# if is_cmd zellij; then
#   zellij setup --generate-completion zsh >! "${zfuncdir}/_zellij"
# fi
#
# if is_cmd jj; then
#   jj util completion zsh >! "${zfuncdir}/_jj"
# fi
#
# for f in ${zfuncdir}/*; do
#   case $f in
#     *.zwc)
#       continue
#       ;;
#     *)
#       zcompare $f
#       ;;
#   esac
# done
