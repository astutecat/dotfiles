return {
    { 'tpope/vim-surround',   event = { "BufReadPost", "BufNewFile" } },
    { 'tpope/vim-unimpaired', event = { "BufReadPost", "BufNewFile" } },
    {
        'tpope/vim-sleuth',
        dependencies = { 'sheerun/vim-polyglot' },
        event = { "BufReadPost", "BufNewFile" }
    },
    { 'christoomey/vim-sort-motion', event = { "BufReadPost", "BufNewFile" }
    },
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
        event = { "BufReadPost", "BufNewFile" }
    },
    {
        'windwp/nvim-autopairs',
        opts = {},
        event = { "BufReadPost", "BufNewFile" }
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
        event = { "BufReadPost", "BufNewFile" }
    },
    {
        'numToStr/Comment.nvim',
        opts = {},
        event = { "BufReadPost", "BufNewFile" }
    },
    {
        'tommcdo/vim-lion',
        init = function()
            vim.g.lion_create_maps    = 1
            vim.g.lion_squeeze_spaces = 1
            vim.g.lion_map_right      = 'ga'
            vim.g.lion_map_left       = 'gA'
        end,
        event = "VeryLazy"
    },
    { 'wakatime/vim-wakatime',       event = "VeryLazy" },
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
        event = { "BufReadPost", "BufNewFile" }
    },
}
