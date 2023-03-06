return {
    load = function(use)
        use {
            'EdenEast/nightfox.nvim',
            config = [[vim.cmd("colorscheme nightfox")]]
        }

        use {
            'lukas-reineke/indent-blankline.nvim',
            config = [[require('plugins.config.indent-blankline')]],
            event = 'BufEnter'
        }

        use {
            'nvim-tree/nvim-tree.lua',
            requires = {
                'nvim-tree/nvim-web-devicons',
            },
            config = [[require('plugins.config.nvim-tree')]]
        }

        use {
            'nvim-tree/nvim-web-devicons',
            config = function() require('nvim-web-devicons').setup {} end
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
                require("barbecue").setup()
            end,
        }

        use {
            'nvim-lualine/lualine.nvim',
            requires = { { 'nvim-tree/nvim-web-devicons', opt = true } },
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
            config = [[require("scrollbar").setup({})]]
        }
    end
}
