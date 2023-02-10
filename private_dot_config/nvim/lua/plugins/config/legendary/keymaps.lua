return {
    {
        "<C-a>",
        "<Plug>(dial-increment)",
        mode = { 'n', 'v' },
        description = "Increment"
    },
    {
        "<C-x>",
        '<Plug>(dial-decrement)',
        mode = { 'n', 'v' },
        description = "Decrement"
    },
    {
        "g<C-a>",
        "g<Plug>(dial-increment)",
        mode = { 'n', 'v' },
        description = "Increment (g)"
    },
    {
        "g<C-x>",
        'g<Plug>(dial-decrement)',
        mode = { 'n', 'v' },
        description = "Decrement (g)"
    },
    {
        "<C-P>",
        '<cmd>Legendary<cr>',
        description = "Show Commands (Legendary)"
    },
    -- Telescope START
    {
        "<leader>ff",
        '<cmd>Telescope find_files hidden=true no_ignore=false<cr>',
        description = "Telescope Find Files"
    },
    {
        "<leader>fe",
        '<cmd>Telescope frecency workspace=CWD<cr>',
        description = "Telescope Frecency"
    },
    {
        "<leader>ft",
        '<cmd>Telescope current_buffer_tags<cr>',
        description = "Telescope Current Buffer Tags"
    },
    {
        "<leader>fgt",
        '<cmd>Telescope tags<cr>',
        description = "Telescope Global Tags"
    },
    {
        "<leader>fb",
        '<cmd>Telescope buffers<cr>',
        description = "Telescope Buffers"
    },
    {
        "<leader>fh",
        '<cmd>Telescope help_tags<cr>',
        description = "Telescope Help Tags"
    },
    {
        "<leader>fm",
        '<cmd>Telescope marks<cr>',
        description = "Telescope Marks"
    },
    {
        "<leader>fy",
        '<cmd>Telescope filetypes<cr>',
        description = "Telescope Filetypes"
    },
    {
        "<leader>fp",
        '<cmd>Telescope projects<cr>',
        description = "Telescope Projects"
    },
    {
        "<leader>fr",
        '<cmd>Telescope resume<cr>',
        description = "Telescope Resume"
    },
    -- Telescope END
    -- hlslens START
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
    -- hlslens END
    -- lsp start
    {
        '<space>e',
        '<cmd>lua vim.diagnostic.open_float()<CR>',
        description = "LSP: Open Diagnostics",
        opts = { silent = true }
    },
    {
        '[d',
        '<cmd>lua vim.diagnostic.goto_prev()<CR>',
        description = "LSP: Goto Previous Diagnostic",
        opts = { silent = true }
    },
    {
        ']d',
        '<cmd>lua vim.diagnostic.goto_next()<CR>',
        description = "LSP: Goto Next Diagnostic",
        opts = { silent = true }
    },
    {
        '<space>q',
        '<cmd>lua vim.diagnostic.setloclist()<CR>',
        description = "LSP: Set Diagnostics Location List",
        opts = { silent = true }
    },
    {
        '<space>f',
        '<cmd>lua vim.lsp.buf.format()<CR>',
        description = "LSP: Format Buffer",
        opts = { silent = true }
    },
    {
        '<space>ca',
        '<cmd>lua vim.lsp.buf.code_actions()<CR>',
        description = "LSP: Code Actions",
        opts = { silent = true }
    },
    {
        '<leader>x',
       '<cmd>lua require("lsp_lines").toggle()<cr>',
       description = "LSP: Toggle LSP Lines"
    },
    -- lsp END
    {
        '<leader>/',
        '<cmd>TrimWhitespace<cr>'
    },
    {
        '<cr>',
        '<cmd>nohlsearch<cr><cr>'
    },
    {
        "<leader>r",
        '<cmd> set relativenumber!<cr>',
        description = "Toggle relative line numbering"
    },
    {
        "<leader>w",
        '<cmd> set wrap!<cr>',
        description = "Toggle line wrapping"
    },
}
