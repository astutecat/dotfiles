local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

local startup_function = function(use)
    require('plugins.look_and_feel').load(use)
    require('plugins.lsp').load(use)
    require('plugins.language_support').load(use)
    require('plugins.completion').load(use)

    use 'wbthomason/packer.nvim'
    use 'alker0/chezmoi.vim'

    use 'nvim-lua/plenary.nvim'

    use { 'stevearc/dressing.nvim' }

    use { 'nvim-telescope/telescope-fzy-native.nvim',
        after = { "telescope.nvim" },
        config = function()
            require('telescope').load_extension('fzy_native')
        end
    }

    use {
        "nvim-telescope/telescope.nvim",
        requires = { { 'nvim-lua/plenary.nvim' }, { 'nvim-telescope/telescope-fzy-native.nvim' } },
        config = [[require('plugins.config.telescope')]]
    }

    use {
        "nvim-telescope/telescope-frecency.nvim",
        config = function()
            require "telescope".load_extension("frecency")
        end,
        after = { "telescope.nvim" },
        requires = { "kkharji/sqlite.lua", "nvim-telescope/telescope.nvim" }
    }

    use {
        'folke/which-key.nvim',
        config = function()
            require('which-key').setup {}
        end
    }

    use {
        'mrjones2014/legendary.nvim',
        requires = { 'kkharji/sqlite.lua', "nvim-telescope/telescope.nvim", "folke/which-key.nvim" },
        config = [[require('plugins.config.legendary')]],
        after = { "which-key.nvim" },
        module = { 'legendary' }
    }


    use {
        'ahmedkhalf/project.nvim',
        requires = { "nvim-telescope/telescope.nvim" },
        after = { "telescope.nvim" },
        config = [[require('plugins.config.project-nvim')]]
    }

    use 'kshenoy/vim-signature'
    use 'tpope/vim-commentary'
    use 'tpope/vim-surround'
    use 'tpope/vim-unimpaired'
    use 'tpope/vim-fugitive'
    use 'tpope/vim-sleuth'
    use {
        'tpope/vim-projectionist',
        config = [[require('plugins.config.projectionist')]]
    }
    use 'christoomey/vim-sort-motion'

    use 'machakann/vim-swap'

    use {
        'tommcdo/vim-lion',
        config = [[require('plugins.config.lion')]]
    }

    use 'jeffkreeftmeijer/vim-numbertoggle'

    use {
        'windwp/nvim-autopairs',
        config = function() require("nvim-autopairs").setup {} end,
        event = 'VimEnter'
    }

    use {
        'AndrewRadev/splitjoin.vim',
        config = function()
            local mappings = {
                {
                    'gS',
                    '<cmd>SplitJoinSplit<CR>',
                    description = "Split to multiple lines",
                },
                {
                    'gJ',
                    '<cmd>SplitJoinJoin<CR>',
                    description = "Join to single line",
                },
            }
            require('legendary').keymaps(mappings)
        end
    }


    use {
        'milkypostman/vim-togglelist',
        config = function()
            vim.g.toggle_list_no_mappings = true
            local opts = { silent = true }
            local mappings = {
                {
                    '<leader>qq',
                    '<cmd>call ToggleQuickfixList()<cr>',
                    description = "Toggle Quickfix List",
                    opts = opts
                },
                {
                    '<leader>qn',
                    '<cmd>cn<cr>',
                    opts = opts
                },
                {
                    '<leader>qp',
                    '<cmd>cp<cr>',
                    opts = opts
                },
                {
                    '<leader>l',
                    '<cmd>call ToggleLocationList()<CR>',
                    description = "Toggle Location List",
                    opts = opts
                },
            }
            require('legendary').keymaps(mappings)
        end
    }


    use 'vim-scripts/BufOnly.vim'

    use 'rafamadriz/friendly-snippets'

    use 'rbgrouleff/bclose.vim'

    use {
        'ujihisa/nclipper.vim',
        config = [[require('plugins.config.nclipper')]],
        event = 'VimEnter'
    }

    use {
        'kevinhwang91/nvim-ufo',
        requires = 'kevinhwang91/promise-async',
        event = 'BufEnter',
        config = [[require('plugins.config.nvim-ufo')]]
    }

    use {
        'puremourning/vimspector',
        config = [[require('plugins.config.vimspector')]]
    }

    use { 'ludovicchabant/vim-gutentags' }

    use 'ryanoasis/vim-devicons'

    use {
        'monaqa/dial.nvim',
        config = [[require('plugins.config.dial')]]
    }

    use {
        'rbong/vim-buffest'
    }

    use {
        "nvim-neotest/neotest",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
            "antoinemadec/FixCursorHold.nvim",
            "jfpedroza/neotest-elixir",
            "rouge8/neotest-rust",
            "vim-test/vim-test",
            "nvim-neotest/neotest-vim-test"
        },
        config = [[require('plugins.config.neotest')]]
    }

    use {
        "startup-nvim/startup.nvim",
        requires = {"nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim"},
        config = [[require("plugins.config.startup_nvim")]]
    }

    if packer_bootstrap then
        require('packer').sync()
    end
end

return require('packer').startup(startup_function)
