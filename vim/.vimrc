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

Plugin 'junegunn/fzf.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-commentary'
Plugin 'dracula/vim', { 'name': 'dracula' }
Plugin 'joshdick/onedark.vim'

"Plugin 'dense-analysis/ale'
Plugin 'preservim/nerdtree'
Plugin 'vim-erlang/vim-erlang-runtime'
Plugin 'vim-erlang/vim-erlang-omnicomplete'
Plugin 'vim-erlang/vim-erlang-tags'
Plugin 'arkwright/vim-whiplash'
Plugin 'szw/vim-tags'
Plugin 'vim-airline/vim-airline'
Plugin 'mbbill/undotree'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tmsvg/pear-tree'
Plugin 'lifepillar/vim-mucomplete'
Plugin 'jiangmiao/auto-pairs'
Plugin 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

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

if has('gui_running')
  set guioptions-=T  " no toolbar
  set lines=55 columns=120
  set scrolloff=10
  set guicursor+=a:blinkon0

  if has('gui_win32')
    set guifont=DejaVu_Sans_Mono:h10:cANSI
  else
    set guifont=Hasklig\ Regular\ 10
  endif
endif

let g:erlang_old_style_highlight = 0

set hidden
set number
set mouse=a
syntax on
"set ttymouse=sgr
let g:WhiplashProjectsDir = "~/repos/"
let g:WhiplashCommandName = "Project"
set backspace=indent,eol,start
set virtualedit+=onemore
"set clipboard=unnamedplus
set grepprg=rg\ --vimgrep\ --smart-case\ --follow

fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfun
command! TrimWhitespace call TrimWhitespace()

nnoremap <silent> <leader> :WhichKey '\'<CR>
nnoremap <C-P> :Files<CR>
nnoremap <Leader>v :sp ~/.vimrc<CR>
nnoremap <silent> <Leader>b :Buffers<CR>
nnoremap <silent> <Leader>f :Rg<CR>
nnoremap <Leader>/ :TrimWhitespace<CR>:w<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>n :n<CR>
nnoremap <Leader>e :NERDTree<CR>
nnoremap <Leader>t :terminal<CR>
nnoremap <Leader>x "*x
nnoremap <Leader>y "*y
nnoremap <Leader>p "*gP
nnoremap <Leader>X "+x
nnoremap <Leader>Y "+y
nnoremap <Leader>P "+gP
nnoremap <Leader>h :set hlsearch!<CR>
nnoremap <Leader>v :e ~/.vimrc<CR>

let g:fzf_layout = { 'down': '~35%' }
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden'
let g:fzf_buffers_jump = 1
let g:airline_powerline_fonts = 1
set tags=./tags;,tags;


" Completion settings
set completeopt-=preview
set completeopt+=menuone,noselect
let g:mucomplete#completion_delay = 500
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#minimum_prefix_length = 3
set shortmess+=c   " Shut off completion messages
set belloff+=ctrlg " If Vim beeps during completion


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
