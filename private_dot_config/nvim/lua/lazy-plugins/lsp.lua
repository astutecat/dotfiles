return {
    { 'nvim-lua/lsp-status.nvim', event = "LspAttach" },
    {
        "williamboman/mason.nvim",
        opts = {},
        version = false,
        event = "VeryLazy"
    },
    { 'mhanberg/output-panel.nvim' },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { 'mason.nvim' },
        event = "VeryLazy"
    },
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            'mason-lspconfig.nvim',
            'nvim-navic'
        },
        version = false,
        opts = require("lazy-plugins.opts.nvim-lspconfig"),
        config = function(_, opts)
            require("mason-lspconfig").setup_handlers(opts)
            local mappings = require("lazy-plugins.opts.keymaps-lsp")
            require('legendary').keymaps(mappings)
        end,
        event = "VeryLazy"
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
        event = "LspAttach"
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
        event = "VeryLazy",
        config = function()
            require("output_panel").setup()
        end
    }
}
