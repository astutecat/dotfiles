
alias hl='printf %"$COLUMNS"s |tr " " "-"'
alias lcl='hl && clear'

if [[ "$(uname -s)" == "Darwin" ]]
then
  alias macvim='open -a MacVim $@'
else if [[ -n $(command -v gvim) ]]
 alias gvim='&>/dev/null gvim'
fi
