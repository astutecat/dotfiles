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

fun! SetupCommandAlias(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfun

call SourceIfExists("~/.vim/functions.local.vim")
