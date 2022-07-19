set encoding=utf-8
set nocompatible
set showmatch
set ignorecase
set wildmode=longest,list
filetype off
filetype plugin indent on

call SetupCommandAlias("W","w")
set timeoutlen=750

colorscheme nightfox

set hidden
set number
set mouse=a
set mousehide
set incsearch
set updatetime=100
set tabstop=2
set shiftwidth=2
set expandtab
set breakindent
set linebreak
set signcolumn=yes
syntax enable
set backspace=indent,eol,start
set virtualedit+=onemore

set splitbelow
set splitright

set scrolloff=10

if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

if (has("termguicolors"))
  set termguicolors
endif

colorscheme nightfox

set grepprg=rg\ --vimgrep\ --smart-case\ --follow
set formatprg=par

let &t_ut=''
