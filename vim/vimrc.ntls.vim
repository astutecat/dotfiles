nnoremap <Leader>` :tabedit ~/dev/useful-commands.erl<CR>
nnoremap <Leader>1 :Project NOC-Devel<CR>
nnoremap <Leader>2 :Project NOC-Stable<CR>
nnoremap <Leader>3 :Project sentinel<CR>

let g:WhiplashProjectsDir = "~/repos/"
let g:ale_completion_enabled = 1
let g:ale_sign_column_always = 1
let g:ale_set_balloons = 1
let g:ale_completion_delay = 300
" let g:ale_enabled = 0i
let g:ale_pattern_options = {'\.erl$': {'ale_enabled' : 0}}

let g:ale_sign_error = '▓'
let g:ale_sign_warning = '░'
" let g:ale_sign_error = '■'
" let g:ale_sign_warning = '■'
let g:lsp_document_code_action_signs_enabled = 0
let g:lsp_completion_documentation_enabled = 1
let g:ale_hover_cursor = 1
let g:ale_completion_autoimport = 0
set omnifunc=ale#completion#OmniFunc

" set shell=/usr/bin/zsh
