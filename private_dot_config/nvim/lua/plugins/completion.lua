M = {}
M.load = function(use)

  use {
    'hrsh7th/vim-vsnip',
    config = [[require('plugins.config.vsnip')]]
  }

  use {
    'hrsh7th/vim-vsnip-integ',
    after = 'vim-vsnip'
  }


  use {
    'hrsh7th/nvim-cmp',
    requires = {
      { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
      'hrsh7th/cmp-nvim-lsp',
      'onsails/lspkind.nvim',
      { 'hrsh7th/cmp-nvim-lsp-signature-help', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-nvim-lua', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-vsnip', after = 'nvim-cmp' },
      { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
      { 'kdheepak/cmp-latex-symbols', after = 'nvim-cmp' }
    },
    config = [[require('plugins.config.cmp')]],
    after = 'vim-vsnip',
  }
end

return M
