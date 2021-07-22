
alias hl='printf %"$COLUMNS"s |tr " " "-"'
alias lcl='hl && clear'

if [[ "$(uname -s)" == "Darwin" ]]
then
  alias macvim='open -a MacVim $@'
fi
