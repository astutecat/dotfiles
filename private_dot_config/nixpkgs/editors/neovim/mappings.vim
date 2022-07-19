nnoremap <leader>/ <cmd>TrimWhitespace<cr>
nnoremap <cr> <cmd>nohlsearch<cr><cr>
nnoremap <leader>r <cmd>set relativenumber!<cr>
nnoremap <leader>w <cmd>set wrap!<cr>
nnoremap <leader>x <cmd>BufOnly<cr>
nnoremap <leader>zz :let &scrolloff=25-&scrolloff<CR><cmd>echo "Scrolloff is now: ".&scrolloff<CR>

nmap <leader>q {v}!par -w80<CR>
vmap <leader>q !par -w80<CR>
