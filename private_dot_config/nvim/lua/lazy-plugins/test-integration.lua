local prefix = "<leader>u"

return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "vim-test/vim-test",
      "jfpedroza/neotest-elixir",
      "rouge8/neotest-rust",
    },
    opts = {},
    keys = {
      {
        prefix .. 'n',
        function()
          require("neotest").run.run()
        end,
        desc = "Neotest: Run the nearest test",
        silent = true
      },
      {
        prefix .. 'a',
        function()
          require("neotest").run.run(true)
        end,
        desc = "Neotest: Run all tests",
        silent = true
      },
      {
        prefix .. 'f',
        function()
          require("neotest").run.run(vim.fn.expand("%"))
        end,
        desc = "Neotest: Run tests in the current file",
        silent = true
      },
      {
        prefix .. 's',
        function()
          require("neotest").run.stop()
        end,
        desc = "Neotest: Stop the nearest test",
        silent = true
      },
      {
        prefix .. 'u',
        function()
          require("neotest").summary.toggle()
        end,
        desc = "Neotest: Show summary",
        silent = true
      },
      {
        prefix .. 'wf',
        function()
          require("neotest").watch.toggle(vim.fn.expand("%"))
        end,
        desc = "Neotest: Watch the current file"
      },
      {
        prefix .. 'wa',
        function()
          require("neotest").watch.toggle(true)
        end,
        desc = "Neotest: Watch all files"
      },
      {
        prefix .. 'o',
        function ()
          require("neotest").output.open({ enter = true, auto_close = true })
        end,
        desc = "Neotest: Open the output of a test result",
        silent = true
      }
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
