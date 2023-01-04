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

local mappings = {
    {
        '<leader>ttl',
        '<cmd>TodoLocList<CR>',
        description = "TODO Comments: Show in Location List",
        opts = kopts
    },
    {
        '<leader>ttq',
        '<cmd>TodoQuickFix<CR>',
        description = "TODO Comments: Show in QuickFix List",
        opts = kopts
    },
    {
        '<leader>fd',
        '<cmd>TodoTelescope<CR>',
        description = "Telescope Show TODO Comments",
        opts = kopts
    },
}
require('legendary').keymaps(mappings)
