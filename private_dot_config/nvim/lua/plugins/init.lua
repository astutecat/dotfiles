local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'alker0/chezmoi.vim'

  require('plugins.look_and_feel').load(use)
  require('plugins.completion').load(use)
  require('plugins.lsp').load(use)
  -- Language Support
  require('plugins.language_support').load(use)
  --

  use 'nvim-lua/plenary.nvim'

  use {
    "nvim-telescope/telescope.nvim",
    config = [[require('plugins.config.telescope')]],
  }

  use {
    'ahmedkhalf/project.nvim',
    config = [[require('plugins.config.project-nvim')]]
  }

  use 'kshenoy/vim-signature'
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'tpope/vim-unimpaired'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-sleuth'
  use 'christoomey/vim-sort-motion'

  use 'machakann/vim-swap'

  use {
    'tommcdo/vim-lion',
    config = [[require('plugins.config.lion')]]
  }

  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup {}
    end,
    event = 'VimEnter'
  }

  use 'jeffkreeftmeijer/vim-numbertoggle'

  use {
    'windwp/nvim-autopairs',
    config = function() require("nvim-autopairs").setup {} end,
    event = 'VimEnter'
  }

  use 'AndrewRadev/splitjoin.vim'


  use {
    'milkypostman/vim-togglelist',
    config = function()
      vim.g.toggle_list_no_mappings = 1
      local opts = { silent = true }
      vim.api.nvim_set_keymap('n', '<leader>o', '<cmd>call ToggleLocationList()<CR>', opts)
      vim.api.nvim_set_keymap('n', '<leader>o', '<cmd>call ToggleQuickFixList()<CR>', opts)
    end,
    event = 'VimEnter'
  }


  use 'vim-scripts/BufOnly.vim'

  use 'rafamadriz/friendly-snippets'

  use 'rbgrouleff/bclose.vim'


  use {
    'ujihisa/nclipper.vim',
    config = [[require('plugins.config.nclipper')]],
    event = 'VimEnter'
  }

  use {
    'kevinhwang91/nvim-ufo',
    requires = 'kevinhwang91/promise-async',
    event = 'BufEnter',
    config = [[require('plugins.config.nvim-ufo')]]
  }

  use {
    'puremourning/vimspector',
    config = [[require('plugins.config.vimspector')]]
  }

  use { 'ludovicchabant/vim-gutentags' }

  use 'ryanoasis/vim-devicons'

  use 'monaqa/dial.nvim'

  if packer_bootstrap then
    require('packer').sync()
  end

end)
