
local e = require("startup_events")

return {
    { 'tpope/vim-surround',   event = e.vl },
    { 'tpope/vim-unimpaired', event = e.vl },
    {
        'tpope/vim-sleuth',
        dependencies = { 'sheerun/vim-polyglot' },
        event = e.vl
    },
    { 'christoomey/vim-sort-motion', event = e.vl },
    { 'ludovicchabant/vim-gutentags', event = e.vl },
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
        end,
        event = e.vl
    },
    {
        'windwp/nvim-autopairs',
        opts = {},
        event = e.vl
    },
    {
        'AndrewRadev/splitjoin.vim',
        config = function()
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
        event = e.vl
    },
    {
        'numToStr/Comment.nvim',
        opts = {},
        event = e.vl
    },
    {
        'tommcdo/vim-lion',
        init = function()
            vim.g.lion_create_maps    = 1
            vim.g.lion_squeeze_spaces = 1
            vim.g.lion_map_right      = 'ga'
            vim.g.lion_map_left       = 'gA'
        end,
        event = e.vl
    },
    { 'wakatime/vim-wakatime', event = e.vl },
    {
        'astutecat/nclipper.vim',
        init = function ()
            vim.g.nclipper_nomap = 1
        end,
        config = function()
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
        event = e.vl
    },
}
