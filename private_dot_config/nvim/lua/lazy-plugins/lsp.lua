local e = require("startup_events")

return {
    { 'nvim-lua/lsp-status.nvim',  event = e.vl },
    {
        "williamboman/mason.nvim",
        opts = {},
        version = false,
        event = e.vl
    },
    { 'mhanberg/output-panel.nvim' },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { 'mason.nvim' },
        event = e.vl
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'mason-lspconfig.nvim',
            'nvim-navic',
            'hrsh7th/cmp-nvim-lsp',
        },
        version = false,
        opts = require("lazy-plugins.opts.nvim-lspconfig"),
        config = function(_, opts)
            require("mason-lspconfig").setup_handlers(opts)
        end,
        event = e.vl
    },
    {
        "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
        dependencies = { 'nvim-lspconfig' },
        version = false,
        opts = {},
        config = function(_, _)
            require("lsp_lines").setup()
            vim.diagnostic.config({
                virtual_text = false,
                virtual_lines = false,
            })
        end,
        event = e.vl
    },
    {
        'jose-elias-alvarez/null-ls.nvim',
        opts = {},
        config = function(_, _)
            local null_ls = require("null-ls")
            local builtins = null_ls.builtins
            null_ls.setup({
                sources = {
                    builtins.diagnostics.trail_space,
                    builtins.code_actions.gitsigns,
                    builtins.formatting.yamlfmt,
                    builtins.diagnostics.yamllint,
                    null_ls.builtins.diagnostics.zsh
                },
            })
        end,
        dependencies = {
            { 'lewis6991/gitsigns.nvim' }
        }
    },
    {
        "mhanberg/output-panel.nvim",
        event = e.vl,
        config = function()
            require("output_panel").setup()
            local commands = {
                {
                    ':OutputPanel',
                    description = "LSP: Show Output Panel",
                },
            }
            require("legendary").commands(commands)
        end,
    }
}
