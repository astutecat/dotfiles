return {
    { 'stevearc/dressing.nvim' },
    {'kshenoy/vim-signature', event = "BufEnter"},
    { 'jeffkreeftmeijer/vim-numbertoggle', event = "BufEnter"},

    --TODO: Check if needed {'ryanoasis/vim-devicons'},

    {
        'lukas-reineke/indent-blankline.nvim',
        opts = {
            --  show_current_context = false,
            space_char_blankline = " ",
            --show_current_context = true,
            --show_current_context_start = true,
            show_trailing_blankline_indent = false,
            -- bufname_exclude = {'NvimTree'},
            char = '│',
            -- char_list = {'|', '¦', '┆'},
            -- use_treesitter = true
        },
        event = 'BufEnter'
    },

    {
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
        },
        opts = {
            source_selector = {
                winbar = true,
            },
            window = {
                width = 37
            },
            filesystem = {
                group_empty_dirs = true,
                use_libuv_file_watcher = true,
                filtered_items = {
                    always_show = {
                        ".gitignore",
                        ".envrc",
                    },
                }
            },
            buffers = {
                group_empty_dirs = true
            },
            default_component_configs = {
                icon = {
                    default = '',
                },
                modified = {
                    symbol = '●',
                }
            },
        },
        config = function(_, opts)
            vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

            local mappings = {
                {
                    "<leader>ee",
                    "<cmd>Neotree toggle<cr>",
                    mode = { 'n' },
                    description = "Toggle Neotree"
                }
            }
            require('legendary').keymaps(mappings)

            vim.fn.sign_define("DiagnosticSignError",
            { text = " ", texthl = "DiagnosticSignError" })
            vim.fn.sign_define("DiagnosticSignWarn",
            { text = " ", texthl = "DiagnosticSignWarn" })
            vim.fn.sign_define("DiagnosticSignInfo",
            { text = " ", texthl = "DiagnosticSignInfo" })
            vim.fn.sign_define("DiagnosticSignHint",
            { text = "", texthl = "DiagnosticSignHint" })
            require("neo-tree").setup(opts)
        end
    },

    {
        'folke/todo-comments.nvim',
        opts = {
            -- your configuration comes here
            -- or leave it empty to use the default settings
            -- refer to the configuration section below
            search = {
                comaand = "rg",
                args = {
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--glob=!node_modules",
                    "--glob=!.git",
                    "--glob=!.hg"
                },
                pattern = [[\b(KEYWORDS):]],
            },
        },
        config = function(_, opts)
            require("todo-comments").setup(opts)
            local mappings = require("lazy-plugins.opts.keymaps-todo-comments")
            require('legendary').keymaps(mappings)
        end,
        event = 'BufEnter'
    },

    {
        'SmiteshP/nvim-navic',
        opts = {
            separator = '  ',
        }
    },

    {
        "utilyre/barbecue.nvim",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            theme = 'tokyonight',
        }
    },

    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons', 'SmiteshP/nvim-navic' },
        opts = require("lazy-plugins.opts.lualine"),
    },

    {
        "petertriho/nvim-scrollbar",
        opts = {},
        config = function (_, opts)
            require("scrollbar").setup(opts)
            require("scrollbar.handlers.gitsigns").setup()
        end,
        dependencies = {
            { 'lewis6991/gitsigns.nvim' }
        }
    },

    {
        'kevinhwang91/nvim-hlslens',
        dependencies = {"nvim-scrollbar"},
        opts = {},
        config = function(_, _opts)
            require("scrollbar.handlers.search").setup()
            local kopts = {noremap = true, silent = true}
            vim.api.nvim_set_keymap('n', 'n',
            [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
            kopts)
            vim.api.nvim_set_keymap('n', 'N',
            [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
            kopts)
            local mappings = require("lazy-plugins.opts.keymaps-hlslens")
            require('legendary').keymaps(mappings)
        end
    },

    {
        'lewis6991/gitsigns.nvim',
        opts = require("lazy-plugins.opts.gitsigns")
    },


}


