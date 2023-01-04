vim.cmd([[
  function! GetDataDir()
    let data_dir = stdpath('data') . '/site'
    return data_dir
  endfunction

  fun! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
    write
  endfun
  command! TrimWhitespace call TrimWhitespace()

  fun! SetupCommandAlias(from, to)
    exec 'cnoreabbrev <expr> '.a:from
    \ .' ((getcmdtype() is# ":" && getcmdline() is# "'.a:from.'")'
      \ .'? ("'.a:to.'") : ("'.a:from.'"))'
  endfun
]])
