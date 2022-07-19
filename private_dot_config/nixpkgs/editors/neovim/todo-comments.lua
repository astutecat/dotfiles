require("todo-comments").setup {
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
}

local kopts = {noremap = true, silent = true}
vim.api.nvim_set_keymap('n', '<leader>tl', '<cmd>TodoLocList<CR>',kopts)
vim.api.nvim_set_keymap('n', '<leader>tt', '<cmd>TodoTelescope<CR>',kopts)
vim.api.nvim_set_keymap('n', '<leader>tq', '<cmd>TodoQuickFix<CR>',kopts)
