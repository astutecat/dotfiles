vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

local mappings = {
    {
        "<leader>ee",
        "<cmd>Neotree toggle<cr>",
        mode = { 'n' },
        description = "Toggle Neotree"
    }
}

require('legendary').keymaps(mappings)

vim.fn.sign_define("DiagnosticSignError",
    { text = " ", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn",
    { text = " ", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo",
    { text = " ", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint",
    { text = "", texthl = "DiagnosticSignHint" })

require("neo-tree").setup({
    source_selector = {
        winbar = true,
    },
    window = {
        width = 37
    },
    filesystem = {
        group_empty_dirs = true
    },
    buffers = {
        group_empty_dirs = true
    },
})
