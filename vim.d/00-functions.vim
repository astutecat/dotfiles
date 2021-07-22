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

function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

call SourceIfExists("~/.vim/functions.local.vim")