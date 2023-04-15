return {
    { 'vim-scripts/BufOnly.vim' },
    { 'rbgrouleff/bclose.vim' },
    { 'rbong/vim-buffest' },

    {
        'milkypostman/vim-togglelist',
        opt = {},
        config = function(_, _)
            vim.g.toggle_list_no_mappings = true
            local opts = { silent = true }
            local mappings = {
                {
                    '<leader>tq',
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
                    '<leader>tl',
                    '<cmd>call ToggleLocationList()<CR>',
                    description = "Toggle Location List",
                    opts = opts
                },
            }
            require('legendary').keymaps(mappings)
        end
    },
    {
        'kevinhwang91/nvim-ufo',
        dependencies = 'kevinhwang91/promise-async',
        event = 'BufEnter',
        opts = require("lazy-plugins.opts.nvim-ufo"),
        config = function(_, opts)
            vim.o.foldcolumn = '0' -- '0' is not bad
            vim.o.foldnestmax = 3
            vim.o.foldlevel = 99   -- Using ufo provider need a large value, feel free to decrease the value
            vim.o.foldlevelstart = 99
            vim.o.foldenable = true
            vim.opt.fillchars = { foldopen = '▾', foldclose = '▸' }

            -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
            vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
            vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

            require("ufo").setup(opts)
        end
    },

}