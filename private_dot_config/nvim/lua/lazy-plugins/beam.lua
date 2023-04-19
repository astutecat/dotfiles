local on_d9 = require("config_flags").on_d9

return {
    -- {
    --     'vim-erlang/vim-erlang-runtime',
    --     cond = on_d9,
    -- },
    {
        "elixir-tools/elixir-tools.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            'hrsh7th/cmp-nvim-lsp',
        },
        ft = { "elixir", "eex", "heex", "surface" },
        opts = {},
        config = function()
            local shared_config = require("lazy-plugins.opts.lsp-shared")
            local elixirls = require("elixir.elixirls")
            require("elixir").setup {
                credo = {

                },
                elixirls = {
                    on_attach = function(client, bufnr)
                        local mappings = require("lazy-plugins.opts.keymaps-elixir")
                        require('legendary').keymaps(mappings)
                        shared_config.on_attach(client, bufnr)
                    end,
                    capabilities = shared_config.capabilities,
                    cmd = { vim.fn.stdpath('data') .. "/mason/bin/elixir-ls" },
                    settings = elixirls.settings({
                        dialyzerEnabled = true,
                        fetchDeps = false,
                        enableTestLenses = false,
                        suggestSpecs = true,
                    }),
                }
            }
        end,
        cond = not on_d9
    }
}
