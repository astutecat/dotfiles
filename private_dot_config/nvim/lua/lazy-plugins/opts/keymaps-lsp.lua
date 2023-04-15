return {
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
        '<cmd>lua vim.lsp.buf.code_action()<CR>',
        description = "LSP: Code Actions",
        opts = { silent = true }
    },
    {
        '<leader>x',
        '<cmd>lua require("lsp_lines").toggle()<cr>',
        description = "LSP: Toggle LSP Lines"
    },
}

