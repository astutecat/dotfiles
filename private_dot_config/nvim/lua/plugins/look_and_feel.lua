return {
    load = function(use)
        use {
            'folke/tokyonight.nvim',
            config = [[vim.cmd("colorscheme tokyonight-night")]]
        }

        use {
            'lukas-reineke/indent-blankline.nvim',
            config = [[require('plugins.config.indent-blankline')]],
            event = 'BufEnter'
        }

        use {
            "nvim-neo-tree/neo-tree.nvim",
            branch = "v2.x",
            requires = {
                "nvim-lua/plenary.nvim",
                "nvim-tree/nvim-web-devicons",
                "MunifTanjim/nui.nvim",
            },
            config = [[require('plugins.config.neo-tree')]]
        }

        use {
            'folke/todo-comments.nvim',
            config = [[require('plugins.config.todo-comments')]],
            event = 'BufEnter'
        }

        use {
            'SmiteshP/nvim-navic',
            config = [[require('plugins.config.navic')]]
        }

        use {
            "utilyre/barbecue.nvim",
            tag = "*",
            requires = {
                "SmiteshP/nvim-navic",
                "nvim-tree/nvim-web-devicons",
            },
            after = "nvim-web-devicons",
            config = function()
                require("barbecue").setup({
                    theme = 'tokyonight',
                })
            end,
        }

        use {
            'nvim-lualine/lualine.nvim',
            requires = { 'nvim-tree/nvim-web-devicons' },
            config = [[require('plugins.config.lualine')]],
            after = 'nvim-navic'
        }

        use {
            'kevinhwang91/nvim-hlslens',
            after = "nvim-scrollbar",
            config = [[require('plugins.config.hlslens')]]
        }

        use {
            "petertriho/nvim-scrollbar",
            config = function ()
                require("scrollbar").setup({})
                require("scrollbar.handlers.gitsigns").setup()
            end,
            requires = {
                { 'lewis6991/gitsigns.nvim' }
            }
        }
    end
}
