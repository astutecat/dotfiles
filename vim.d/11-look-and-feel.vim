colorscheme dracula
set guicursor+=i:block-Cursor
set guicursor+=a:blinkon0
set guicursor+=i:blinkon0

if has('gui_running')
  set guioptions-=T  " no toolbar
  set lines=50 columns=120
  set scrolloff=10
  let g:airline_powerline_fonts = 0

  if has('gui_win32')
    set guifont=DejaVu_Sans_Mono:h10:cANSI
  elseif has('gui_macvim')
    set guifont=FiraCode-Regular:h11     " OSX.
  else
    set guifont=Fira\ Code\ Retina\ Nerd\ Font\ Complete\ 10
  endif
else
" let g:airline_powerline_fonts = 1
endif

set hidden
set number
set mouse=a
set mousehide
set incsearch
set updatetime=750
set tabstop=2 shiftwidth=2 expandtab
set shell=/bin/zsh\ -l
set signcolumn=yes
syntax enable
set backspace=indent,eol,start
set virtualedit+=onemore

set encoding=utf8

set grepprg=rg\ --vimgrep\ --smart-case\ --follow

let &t_ut=''
