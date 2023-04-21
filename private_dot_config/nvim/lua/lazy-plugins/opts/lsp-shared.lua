local M = {}

local on_attach_keymap = function(bufnr)
  local k_opts = { silent = true, noremap = true, buffer = bufnr }

  return {
    {
      '<M-C-]>',
      '<cmd>lua vim.lsp.buf.definition()<CR>',
      description = 'LSP: Go to definition',
      opts =
          k_opts
    },
    {
      'K',
      '<cmd>lua vim.lsp.buf.hover()<CR>',
      description = 'LSP: Hover',
      opts =
          k_opts
    },
    {
      '<space>gi',
      '<cmd>lua vim.lsp.buf.implementation()<CR>',
      description = 'LSP: Go to Implementation',
      opts =
          k_opts
    },
    {
      'C-k',
      '<cmd>lua vim.lsp.buf.signature_help()<CR>',
      description = 'LSP: Signature Help',
      opts =
          k_opts
    },
    {
      '<space>D',
      '<cmd>lua vim.lsp.buf.type_definition()<CR>',
      description = 'LSP: Type Definition',
      opts =
          k_opts
    },
    {
      '<space>rn',
      '<cmd>lua vim.lsp.buf.rename()<CR>',
      description = 'LSP: Rename',
      opts =
          k_opts
    },
    {
      '<space>gr',
      '<cmd>lua vim.lsp.buf.references()<CR>',
      description = 'LSP: References',
      opts =
          k_opts
    },
    {
      '<space>r',
      '<cmd>lia vim.lsp.codelens.run',
      description = 'LSP: Codelens',
      opts =
          k_opts
    },
    {
      '<space>s',
      '<cmd>Telescope lsp_document_symbols ',
      description = 'LSP: Document Sumbols',
      opts =
          k_opts
    },
    {
      '<space>e',
      '<cmd>lua vim.diagnostic.open_float()<CR>',
      description = "LSP: Open Diagnostics",
      opts =
          k_opts
    },
    {
      '[d',
      '<cmd>lua vim.diagnostic.goto_prev()<CR>',
      description = "LSP: Goto Previous Diagnostic",
      opts =
          k_opts
    },
    {
      ']d',
      '<cmd>lua vim.diagnostic.goto_next()<CR>',
      description = "LSP: Goto Next Diagnostic",
      opts =
          k_opts
    },
    {
      '<space>q',
      '<cmd>lua vim.diagnostic.setloclist()<CR>',
      description = "LSP: Set Diagnostics Location List",
      opts =
          k_opts
    },
    {
      '<space>f',
      '<cmd>lua vim.lsp.buf.format()<CR>',
      description = "LSP: Format Buffer",
      opts =
          k_opts
    },
    {
      '<space>ca',
      '<cmd>lua vim.lsp.buf.code_action()<CR>',
      description = "LSP: Code Actions",
      opts =
          k_opts
    },
    {
      '<leader>x',
      '<cmd>lua require("lsp_lines").toggle()<cr>',
      description = "LSP: Toggle LSP Lines",
      opts =
          k_opts
    },
  }
end

M.on_attach = function(client, bufnr)
  local navic = require("nvim-navic")
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  local keymaps = on_attach_keymap(bufnr)
  require('legendary').keymaps(keymaps)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}

M.capabilities = capabilities

return M
