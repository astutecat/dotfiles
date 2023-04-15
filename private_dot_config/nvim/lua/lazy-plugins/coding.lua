return {
    { 'tpope/vim-surround' },
    { 'tpope/vim-unimpaired' },
    {
        'tpope/vim-sleuth',
        dependencies = { 'sheerun/vim-polyglot' }
    },
    {
        'tpope/vim-projectionist',
        config = function(...)
            local heuristics = {}

            heuristics["lib/*.ex"] = {
                alternate = "test/{}_test.exs",
                type = "source",
                template = {
                    "defmodule {camelcase|capitalize|dot} do",
                    "end"
                }
            }

            heuristics["test/*_test.exs"] = {
                alternate = "lib/{}.ex",
                type = "test",
                template = {
                    "defmodule {camelcase|capitalize|dot}Test do",
                    "  use ExUnit.Case, async: true",
                    "",
                    "  alias {camelcase|capitalize|dot}",
                    "end"
                }
            }
            vim.g.projectionist_heuristics = heuristics
        end
    },
    { 'christoomey/vim-sort-motion' },
    { 'ludovicchabant/vim-gutentags' },
    {
        'machakann/vim-swap',
        opts = {},
        config = function(_, _)
            local mappings = {
                {
                    'g<',
                    '<Plug>(swap-prev)',
                    description = "nvim-swap: Swap with previous item",
                },
                {
                    'g<',
                    '<Plug>(swap-next)',
                    description = "nvim-swap: Swap with next item",
                },
            }
            require('legendary').keymaps(mappings)
        end
    },
    {
        'windwp/nvim-autopairs',
        opts = {},
        event = 'BufEnter'
    },
    {
        'AndrewRadev/splitjoin.vim',
        config = function(...)
            local mappings = {
                {
                    '<leader>ss',
                    '<cmd>SplitjoinSplit<CR>',
                    description = "Split to multiple lines",
                },
                {
                    '<leader>sj',
                    '<cmd>SplitjoinJoin<CR>',
                    description = "Join to single line",
                },
            }
            require('legendary').keymaps(mappings)
        end,
        event = "BufEnter"
    },
    {
        'numToStr/Comment.nvim',
        opts = {}
    },
    {
        'tommcdo/vim-lion',
        config = function(...)
            vim.g.lion_create_maps    = 1
            vim.g.lion_squeeze_spaces = 1
            vim.g.lion_map_right      = 'ga'
            vim.g.lion_map_left       = 'gA'
        end
    },
    { 'wakatime/vim-wakatime' },
    {
        'astutecat/nclipper.vim',
        config = function(...)
            vim.g.nclipper_nomap = 1
            local opts = { noremap = true }
            local mappings = {
                {
                    '<M-y>',
                    '<Plug>(nclipper)',
                    description = "NClipper: Context Copy (No Filename)",
                    mode = { 'v' },
                    opts = opts
                },
                {
                    '<C-y>',
                    '<Plug>(nclipper-with-filename)',
                    description = "NClipper: Context Copy",
                    mode = { 'v' },
                    opts = opts
                },
            }
            require('legendary').keymaps(mappings)
        end,
        event = 'BufEnter'
    },
}