nnoremap <Leader>` :e ~/dev/useful-commands.erl<CR>
nnoremap <Leader>1 :cd ~/repos/NOC-Devel<CR>
nnoremap <Leader>2 :cd ~/repos/NOC-Stable<CR>
nnoremap <Leader>3 :cd ~/repos/sentinel<CR>

let g:syntastic_mode_map = { 'mode': 'passive', 'active_filetypes': [],'passive_filetypes': [] }
let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#chains = {
                         \ 'default' : ['path', 'omni', 'keyn', 'dict', 'uspl'],
                         \ 'erlang'     : ['path', 'incl', 'ulti'],
                         \ 'vim'     : ['path', 'cmd', 'keyn']
             \ }


