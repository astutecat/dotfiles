return {
  {
    'folke/which-key.nvim',
    opts = {},
    version = "^1.2.3"
  },
  {
    'mrjones2014/legendary.nvim',
    dependencies = {
      'kkharji/sqlite.lua',
      'nvim-telescope/telescope.nvim',
      'folke/which-key.nvim',
    },
    opts = require('lazy-plugins.opts.legendary-nvim')
  }
}
