if executable('zathura')
  let g:vimtex_view_method = 'zathura'
elseif executable('skimpdf')
  let g:vimtex_view_method = 'skim'
  let g:vimtex_view_skim_sync = 1
endif

let g:vimtex_compiler_latexmk = {
        \ 'executable' : 'latexmk',
        \ 'options' : [
        \   '-xelatex',
        \   '-file-line-error',
        \   '-synctex=1',
        \   '-interaction=nonstopmode',
        \ ],
        \}

let g:vimtex_quickfix_ignore_filters = [
          \ 'Overfull \\vbox',
          \]

augroup vimtex_config
  au!
  au User VimtexEventQuit call vimtex#compiler#clean(0)
augroup END
