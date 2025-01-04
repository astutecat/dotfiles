return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "vim-test/vim-test",
      "jfpedroza/neotest-elixir",
      "rouge8/neotest-rust",
    },
    opts = {},
    keys = {
      {
        '<leader>tn',
        function()
          require("neotest").run.run()
        end,
        desc = "Neotest: Run the nearest test",
        silent = true
      },
      {
        '<leader>tf',
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Neotest: Run the current file",
        silent = true
      },
      {
        '<leader>ts',
        function()
          require("neotest").run.stop()
        end,
        desc = "Neotest: Stop the nearest test",
        silent = true
      },
    },
    config = function()
      local n_opts = {
        adapters = {
          require("neotest-rust"),
          require("neotest-elixir"),
        },
      }
      require("neotest").setup(n_opts)
    end,
    event = "VeryLazy"
  }
}
