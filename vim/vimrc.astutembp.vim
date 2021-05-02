set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

"let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 3
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0


function! SyntasticToggle()
  let g:wi = getloclist(2, {'winid' : 1})
  if g:wi != {}
    lclose
  else
    Errors
  endif
endfunction
command! SyntasticToggle call SyntasticToggle()

let g:WhiplashProjectsDir = "~/dev/"
let g:syntastic_aggregate_errors = 1

au User asyncomplete_setup call asyncomplete#register_source({
    \ 'name': 'alchemist',
    \ 'whitelist': ['elixir'],
    \ 'completor': function('asyncomplete#sources#elixir#completor'),
    \ 'config': { },
    \ })

"If you decided to go for prabirshrestha/asyncomplete-buffer.vim, this is an example settting
au User asyncomplete_setup call asyncomplete#register_source({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ })

nnoremap <Leader>s :SyntasticToggle<CR>


