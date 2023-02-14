local on_attach = function(client, bufnr)
    local navic = require("nvim-navic")
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    -- Mappings.
    local opts = { noremap = true, silent = true }

    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions

    buf_set_keymap('n', '<C-]>', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', '<M-C-]>', '<cmd>tjump<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', '<space>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}

require("mason-lspconfig").setup_handlers {
    -- The first entry (without a key) will be the default handler
    -- and will be called for each installed server that doesn't have
    -- a dedicated handler.
    function(server_name) -- default handler (optional)
        require("lspconfig")[server_name].setup {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 150,
            }
        }
    end,
    ["elixirls"] = function()
        require 'lspconfig'.elixirls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = { debounce_text_changes = 150 },
            cmd = { vim.fn.stdpath('data') .. "/mason/bin/elixir-ls" }
        }
    end,
    -- Next, you can provide a dedicated handler for specific servers.
    -- For example, a handler override for the `rust_analyzer`:
    ["lua_ls"] = function()
        require 'lspconfig'.lua_ls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = { debounce_text_changes = 150 },
            settings = {
                Lua = {
                    diagnostics = { globals = { 'vim' } },
                    format = {
                        enable = true,
                        defaultConfig = {
                            indent_style = "space",
                        }
                    }
                }
            }
        }
    end
}

local mappings = {
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
}
require('legendary').keymaps(mappings)
