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
    config = function()
      local n_opts = {
        adapters = {
          require("neotest-rust"),
          require("neotest-elixir"),
        },
      }

      require("neotest").setup(n_opts)

      local mappings = {
        {
          '<leader>tn',
          function()
            require("neotest").run.run()
          end,
          description = "Neotest: Run the nearest test",
          opts = { silent = true }
        },
        {
          '<leader>tf',
          function()
            require("neotest").run.run(vim.fn.expand("%"))
          end,
          description = "Neotest: Run the current file",
          opts = { silent = true }
        },
        {
          '<leader>ts',
          function()
            require("neotest").run.stop()
          end,
          description = "Neotest: Stop the nearest test",
          opts = { silent = true }
        },
      }
      require('legendary').keymaps(mappings)
    end,
    event = "VeryLazy"
  }
}
