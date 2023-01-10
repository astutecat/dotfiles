M = {}
M.load = function(use)

use {
  'sheerun/vim-polyglot',
  config = function()
    vim.g.ployglot_disabled = "autoindent"
  end
}

use {
  'lervag/vimtex',
  config = [[require('plugins.config.vimtex')]],
  ft = { 'tex' }
}

use {
    'nvim-treesitter/nvim-treesitter',
    config = [[require('plugins.config.treesitter')]],
    event = 'VimEnter',
    module = {'nvim-treesitter', 'nvim-treesitter.query'}
}

use {
  'RRethy/nvim-treesitter-endwise',
  after = 'nvim-treesitter',
  config = function()
    require('nvim-treesitter.configs').setup {
      endwise = {
        enable = true,
      },
    }
  end,
  event = 'VimEnter'
}

use {
  'preservim/vim-markdown',
  requires = {
    {'godlygeek/tabular'}
  }
}

-- TODO:
 -- vim-nix
 -- rust-vim
 -- vim-elixir
 -- vim-markdown
 -- vim-erlang-runtime

 end

 return M
