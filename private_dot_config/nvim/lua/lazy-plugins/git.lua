return {
  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = require("lazy-plugins.opts.gitsigns"),
  },

}
