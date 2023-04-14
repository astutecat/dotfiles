return {
    load = function(use)
        use 'nvim-lua/lsp-status.nvim'

        use {
            "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
            config = [[require('plugins.config.lsplines')]],
            after = 'nvim-lspconfig'
        }

        use {
            'neovim/nvim-lspconfig',
            after = 'mason-lspconfig.nvim',
            config = [[require('plugins.config.lspconfig')]]
        }

        use {
            'lewis6991/gitsigns.nvim',
            config = [[require('plugins.config.gitsigns')]]
        }

        use {
            'jose-elias-alvarez/null-ls.nvim',
            config = [[require('plugins.config.null_ls')]],
            requires = {
                { 'lewis6991/gitsigns.nvim' }
            }
        }

        use {
            "williamboman/mason-lspconfig.nvim",
            after = 'mason.nvim',
            config = [[require('plugins.config.mason-lspconfig')]]
        }

        use {
            "williamboman/mason.nvim",
            config = function()
                require("mason").setup()
            end
        }

        use {
            'simrat39/rust-tools.nvim',
            requires = {
                { 'mfussenegger/nvim-dap' },
                { 'neovim/nvim-lspconfig' }
            },
            after = 'nvim-lspconfig',
            config = [[require('plugins.config.rust-tools')]]
        }

        use {
            'mhanberg/output-panel.nvim'
        }
    end
}
