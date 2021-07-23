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
nnoremap <Leader>x "+x
nnoremap <Leader>y "+y
nnoremap <Leader>p "+gP
nnoremap <Leader>h :HighlightCurrentWord<CR>
nnoremap <Leader>v :tabedit ~/.vimrc<CR>
nnoremap <CR> :nohlsearch<CR><CR>
nnoremap <Leader>r :set relativenumber!<CR>
nnoremap <Leader>a :ALEToggle<CR>
nnoremap <Leader>w :set wrap!<CR>

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

call SourceIfExists("~/.vim/mappings.local.vim")
