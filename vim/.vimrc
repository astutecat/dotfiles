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

Plugin 'VundleVim/Vundle.vim'
Plugin 'arkwright/vim-whiplash'
Plugin 'christoomey/vim-sort-motion'
Plugin 'dense-analysis/ale'
Plugin 'dracula/vim', { 'name': 'dracula' }
Plugin 'editorconfig/editorconfig-vim'
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'jiangmiao/auto-pairs'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'kana/vim-textobj-indent'
Plugin 'kana/vim-textobj-user'
Plugin 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'mattn/vim-lsp-settings'
Plugin 'mbbill/undotree'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'preservim/nerdtree'
Plugin 'rhysd/vim-lsp-ale'
Plugin 'sheerun/vim-polyglot'
Plugin 'tmsvg/pear-tree'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-surround'
Plugin 'vim-airline/vim-airline'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

Plugin 'vim-erlang/vim-erlang-omnicomplete', { 'for': ['erlang'] }
Plugin 'vim-erlang/vim-erlang-runtime', { 'for': ['erlang'] }
Plugin 'vim-erlang/vim-erlang-tags', { 'for': ['erlang'] }

Plugin 'rust-lang/rust.vim', {'for': ['rust']}

Plugin 'elixir-lang/vim-elixir', { 'for': ['elixir', 'eelixir'] }
Plugin 'slashmili/alchemist.vim', { 'for': ['elixir', 'eelixir'] }
Plugin 'mhinz/vim-mix-format', {'for': ['elixir', 'eelixir']}

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
  let g:airline_powerline_fonts = 0

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
set signcolumn=yes
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


"set completeopt=menuone,noinsert,noselect,preview
set completeopt=menu,menuone,noselect,noinsert


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
nnoremap <Leader>a :ALEToggle<CR>

let g:fzf_layout = { 'down': '~35%' }

if executable('fd')
  let $FZF_DEFAULT_COMMAND = 'fd --type file --follow --color=always'
  let $FZF_DEFAULT_OPTS='--ansi'
elseif executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
endif

" let g:fzf_buffers_jump = 1
set tags=./tags;,tags;

let g:pear_tree_repeatable_expand = 0

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" " If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
" autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
"     \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

call SourceIfExists("~/.vimrc.local")
call SourceIfExists("~/.gvimrc.local")
