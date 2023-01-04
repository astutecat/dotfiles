require("scrollbar.handlers.search").setup()

local kopts = {noremap = true, silent = true}

vim.api.nvim_set_keymap('n', 'n',
    [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)
vim.api.nvim_set_keymap('n', 'N',
    [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
    kopts)

local mappings = {
    {
        "*",
        [[*<Cmd>lua require('hlslens').start()<CR>]],
        "Search word under cursor backward",
        opts = { silent = true }
    },
    {
        "#",
        [[#<Cmd>lua require('hlslens').start()<CR>]],
        "Search word under cursor forward",
        opts = { silent = true }
    },
    {
        "g*",
        [[g*<Cmd>lua require('hlslens').start()<CR>]],
        "Search word under cursor backward globally",
        opts = { silent = true }
    },
    {
        "g#",
        [[g#<Cmd>lua require('hlslens').start()<CR>]],
        "Search word under cursor forward globally",
        opts = { silent = true }
    },
}
require('legendary').keymaps(mappings)
