return {
  {
    "kdheepak/lazygit.nvim",
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    opts = {},
    config = function(_, _)
      local mappings = {
        {
          "<leader>gg",
          "<cmd>LazyGit<cr>",
          mode = { 'n' },
          description = "LazyGit"
        },
      }
      require('legendary').keymaps(mappings)
    end
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = require("lazy-plugins.opts.gitsigns"),
  },

}
