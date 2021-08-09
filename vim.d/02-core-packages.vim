call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'dracula/vim', { 'name': 'dracula' }
Plugin 'vim-airline/vim-airline'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'vim-scripts/PreserveNoEOL'
Plugin 'tpope/vim-commentary'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plugin 'junegunn/fzf.vim'
Plugin 'ludovicchabant/vim-gutentags'
Plugin 'sheerun/vim-polyglot'
Plugin 'vim-scripts/BufOnly.vim'
Plugin 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }
Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'arkwright/vim-whiplash'
Plugin 'christoomey/vim-sort-motion'
Plugin 'mbbill/undotree'
Plugin 'jiangmiao/auto-pairs'

Plugin 'dense-analysis/ale'
Plugin 'mattn/vim-lsp-settings'
Plugin 'prabirshrestha/vim-lsp'
Plugin 'rhysd/vim-lsp-ale'

Plugin 'preservim/nerdtree'


Plugin 'vim-erlang/vim-erlang-omnicomplete', { 'for': ['erlang'] }
Plugin 'vim-erlang/vim-erlang-runtime', { 'for': ['erlang'] }
Plugin 'vim-erlang/vim-erlang-tags'

Plugin 'rust-lang/rust.vim', {'for': ['rust']}
Plugin 'elixir-lang/vim-elixir', { 'for': ['elixir', 'eelixir'] }

"Plugin 'junegunn/vim-easy-align'
"Plugin 'kana/vim-textobj-indent'
"Plugin 'kana/vim-textobj-user'
"Plugin 'tmsvg/pear-tree'
"Plugin 'tpope/vim-eunuch'
"Plugin 'tpope/vim-repeat'
"Plugin 'tpope/vim-surround'
"Plugin 'SirVer/ultisnips'
"Plugin 'honza/vim-snippets'
"Plugin 'nathanaelkane/vim-indent-guides'

call SourceIfExists("~/.vim/packages.local.vim")

Plugin 'ryanoasis/vim-devicons'
