set rtp+=~/.fzf/
let g:fzf_layout = { 'down': '~35%' }

if executable('fd')
  let $FZF_DEFAULT_COMMAND = 'fd --type file --follow --color=always'
  let $FZF_DEFAULT_OPTS='--ansi'
elseif executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
endif