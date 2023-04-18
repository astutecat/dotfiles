local e_vl = "VeryLazy"
local e_buf_read_or_new = { "BufReadPost", "BufNewFile" }

return {
    { 'tpope/vim-surround',   event = e_buf_read_or_new },
    { 'tpope/vim-unimpaired', event = e_buf_read_or_new },
    {
        'tpope/vim-sleuth',
        dependencies = { 'sheerun/vim-polyglot' },
        event = { "BufReadPost", "BufNewFile" }
    },
    { 'christoomey/vim-sort-motion', event = e_vl },
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
        end,
        event = e_vl
    },
    {
        'windwp/nvim-autopairs',
        opts = {},
        event = e_vl
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
        event = e_vl
    },
    {
        'numToStr/Comment.nvim',
        opts = {},
        event = e_vl
    },
    {
        'tommcdo/vim-lion',
        init = function()
            vim.g.lion_create_maps    = 1
            vim.g.lion_squeeze_spaces = 1
            vim.g.lion_map_right      = 'ga'
            vim.g.lion_map_left       = 'gA'
        end,
        event = e_vl
    },
    { 'wakatime/vim-wakatime', event = e_vl },
    {
        'astutecat/nclipper.vim',
        config = function()
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
        event = e_vl
    },
}
