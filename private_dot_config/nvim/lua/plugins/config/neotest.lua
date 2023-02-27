require("neotest").setup({
  adapters = {
    require("neotest-rust"),
    require("neotest-elixir"),
    require("neotest-vim-test")({
      ignore_file_types = { "vim", "lua", "rust", "elixir" },
    }),
  },
})

local mappings = {
    {
        '<leader>tn',
        function ()
            require("neotest").run.run()
        end,
        description = "Neotest: Run the nearest test",
        opts = { silent = true }
    },
    {
        '<leader>tf',
        function ()
            require("neotest").run.run(vim.fn.expand("%"))
        end,
        description = "Neotest: Run the current file",
        opts = { silent = true }
    },
    {
        '<leader>ts',
        function ()
            require("neotest").run.stop()
        end,
        description = "Neotest: Stop the nearest test",
        opts = { silent = true }
    },
}
require('legendary').keymaps(mappings)
