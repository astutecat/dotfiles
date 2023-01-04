M = {}
M.load = function(use)

  use 'nvim-lua/lsp-status.nvim'

  use {
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
    config = [[require('plugins.config.lsplines')]],
    after = 'nvim-lspconfig'
  }

  use {
    'neovim/nvim-lspconfig',
    after = 'mason-lspconfig.nvim',
    config = [[require('plugins.config.lspconfig')]]
  }

  use {
    'jose-elias-alvarez/null-ls.nvim',
    config = [[require('plugins.config.null_ls')]]
  }

  use {
    "williamboman/mason-lspconfig.nvim",
    after = 'mason.nvim',
    config = [[require('plugins.config.mason-lspconfig')]]
  }

  use {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  }

end

return M
