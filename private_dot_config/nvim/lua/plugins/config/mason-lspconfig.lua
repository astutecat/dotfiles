require("mason-lspconfig").setup({
  automatic_installation = { exclude = { "erlangls", "elixir_ls" } }
})
