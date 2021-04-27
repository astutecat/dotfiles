function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/VundleVim/Vundle.vim ~/.vim/bundle/Vundle.vim
  let iCanHazVundle=0
endif
set nocompatible              " be iMproved, required
filetype off                  " required
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()

Plugin 'sheerun/vim-polyglot'
Plugin 'VundleVim/Vundle.vim'
Plugin 'arkwright/vim-whiplash'
Plugin 'christoomey/vim-sort-motion'
Plugin 'dracula/vim', { 'name': 'dracula' }
Plugin 'editorconfig/editorconfig-vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plugin 'mbbill/undotree'
Plugin 'preservim/nerdtree'
Plugin 'tmsvg/pear-tree'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-erlang/vim-erlang-omnicomplete'
Plugin 'vim-erlang/vim-erlang-runtime'
Plugin 'vim-erlang/vim-erlang-tags'
Plugin 'vim-syntastic/syntastic'
Plugin 'rust-lang/rust.vim'
Plugin 'elixir-lang/vim-elixir',              { 'for': ['elixir', 'eelixir'] }
Plugin 'slashmili/alchemist.vim',             { 'for': ['elixir', 'eelixir'] }
Plugin 'mhinz/vim-mix-format'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'

call SourceIfExists("~/.vim/packages.local.vim")

if iCanHazVundle == 0
  echo "Installing Vundles, please ignore key map error messages"
  echo ""
  :PluginInstall
endif

" more Plugin commands
" ...
call vundle#end()            " required
set rtp+=~/.fzf/
filetype plugin indent on    " required

colorscheme dracula

set guicursor+=i:block-Cursor
set guicursor+=a:blinkon0
set guicursor+=i:blinkon0


if has('gui_running')
  set guioptions-=T  " no toolbar
  set lines=55 columns=120
  set scrolloff=10
  let g:airline_powerline_fonts = 1

  if has('gui_win32')
    set guifont=DejaVu_Sans_Mono:h10:cANSI
  elseif has('gui_macvim')
    set guifont=Hack-Regular:h11     " OSX.
  else
    set guifont=Hack\ Regular\ 10
  endif
else
  let g:airline_powerline_fonts = 0
endif

let g:erlang_old_style_highlight = 0

set hidden
set number
set mouse=a
set mousehide
set incsearch
set updatetime=750
set tabstop=2 shiftwidth=2 expandtab
set shell=/bin/zsh\ -l
syntax enable
"set ttymouse=sgr
let g:WhiplashProjectsDir = "~/repos/"
let g:WhiplashCommandName = "Project"
let g:WhiplashConfigDir = "~/dotfiles/vim/whiplash/"
set backspace=indent,eol,start
set virtualedit+=onemore
"set clipboard=unnamedplus
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
    write
endfun
command! TrimWhitespace call TrimWhitespace()

fun! HighlightCurrentWord()
  let @/='\<<C-R>=expand("<cword>")<CR>\>'
  set hls
endfun
command! HighlightCurrentWord call HighlightCurrentWord()


set completeopt=menuone,noinsert,noselect,preview

nnoremap <silent> <leader> :WhichKey '\'<CR>
nnoremap <C-P> :Files<CR>
nnoremap <Leader>v :sp ~/.vimrc<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <Leader>/ :TrimWhitespace<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>n :n<CR>
nnoremap <Leader>e :NERDTree<CR>
nnoremap <Leader>t :terminal<CR>
nnoremap <Leader>x "+x
nnoremap <Leader>y "+y
nnoremap <Leader>p "+gP
nnoremap <Leader>h :HighlightCurrentWord<CR>
nnoremap <Leader>v :tabedit ~/.vimrc<CR>
nnoremap <CR> :nohlsearch<CR><CR>
nnoremap <Leader>r :set relativenumber!<CR>

let g:fzf_layout = { 'down': '~35%' }
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
let g:fzf_buffers_jump = 1
set tags=./tags;,tags;

let g:pear_tree_repeatable_expand = 0

" Customize fzf colors to match your color scheme
" - fzf#wrap translates this to a set of `--color` options
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

call SourceIfExists("~/.vimrc.local")
call SourceIfExists("~/.gvimrc.local")

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
