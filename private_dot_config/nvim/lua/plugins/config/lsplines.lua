require("lsp_lines").setup()
vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = false,
})

vim.keymap.set(
    "",
    "<Leader>x",
    require("lsp_lines").toggle,
    { desc = "Toggle lsp_lines" }
)
