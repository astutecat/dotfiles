local config_dir = vim.fn.stdpath('config')
local de_file_path = config_dir .. '/spell/de.utf-8.spl'
local base_url = 'http://ftp.vim.org/vim/runtime/spell'
local de_url = base_url .. '/de.utf-8.spl'

local fn = vim.fn

if fn.empty(fn.glob(de_file_path)) > 0 then
  fn.system({ 'curl', '-o', de_file_path, de_url })
end

vim.cmd([[
  let b:myLang=0
  let g:myLangList=["nospell","en_us","de_de"]
  function! ToggleSpell()
    if !exists( "b:myLang" )
      if &spell
        let b:myLang=index(g:myLangList, &spelllang)
      else
        let b:myLang=0
      endif
    endif
    let b:myLang=b:myLang+1
    if b:myLang>=len(g:myLangList) | let b:myLang=0 | endif
    if b:myLang==0
      setlocal nospell
    else
      execute "setlocal spelllang=".get(g:myLangList, b:myLang)
      setlocal spell
    endif
    echo "spell checking language:" g:myLangList[b:myLang]
  endfunction
]])
