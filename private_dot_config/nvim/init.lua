math.randomseed(os.time())

require('functions')
-- require('plugins')
-- require('spell')
require('lazy-nvim')
require('mappings')

vim.o.encoding = "utf-8"
vim.o.compatible = false
vim.o.wildmode = 'longest,list'

vim.cmd([[call SetupCommandAlias("W", "w")]])

vim.o.timeoutlen = 750
vim.o.hidden = true
vim.o.number = true
vim.o.mouse = 'a'
vim.o.mousehide = true

vim.o.showmatch = true
vim.o.ignorecase = true
vim.o.incsearch = true

vim.o.updatetime = 100

vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.breakindent = true
vim.o.linebreak = true

vim.o.signcolumn = 'yes'

vim.cmd('syntax enable')

vim.o.backspace = 'indent,eol,start'
vim.o.virtualedit = vim.o.virtualedit .. 'onemore'

vim.o.splitbelow = true
vim.o.splitright = true

vim.o.scrolloff = 10

vim.cmd([[
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif

  if (has("termguicolors"))
    set termguicolors
  endif

  set grepprg=rg\ --vimgrep\ --smart-case\ --follow
  set formatprg=par

  let &t_ut=''
]])
