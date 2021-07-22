function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

for f in glob('$DOTFILES/vim.d/**/*.vim', 0, 1)
  execute 'source' f
endfor