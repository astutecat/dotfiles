set rtp+=~/.fzf/
let g:fzf_layout = { 'down': '~35%' }

if executable('fd')
  let $FZF_DEFAULT_COMMAND = 'fd --type file --follow --color=always'
  let $FZF_DEFAULT_OPTS='--ansi --color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9 --color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9 --color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6 --color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4'

elseif executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
endif
