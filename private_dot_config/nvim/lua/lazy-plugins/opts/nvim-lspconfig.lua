local k_opts = { noremap = true, silent = true }

local on_attach_keymap = {
    { '<C-]>',     '<cmd>lua vim.lsp.buf.definition()<CR>',      'LSP: Go to Definition',     opts = k_opts },
    { '<M-C-]>',   '<cmd>lua vim.lsp.buf.definition()<CR>',      'Tag Jump',                  opts = k_opts },
    { 'K',         '<cmd>lua vim.lsp.buf.hover()<CR>',           'LSP: Hover',                opts = k_opts },
    { '<space>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>',  'LSP: Go to Implementation', opts = k_opts },
    { 'C-k',       '<cmd>lua vim.lsp.buf.signature_help()<CR>',  'LSP: Signature Help',       opts = k_opts },
    { '<space>D',  '<cmd>lua vim.lsp.buf.type_definition()<CR>', 'LSP: Type Definition',      opts = k_opts },
    { '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>',          'LSP: Rename',               opts = k_opts },
    { '<space>gr', '<cmd>lua vim.lsp.buf.references()<CR>',      'LSP: References',           opts = k_opts },
    { '<space>r',  '<cmd>lia vim.lsp.codelens.run',              'LSP: Codelens',             opts = k_opts },
    { '<space>s',  '<cmd>Telescope lsp_document_symbols ',       'LSP: Document Sumbols',     opts = k_opts }
}

local on_attach = function(client, bufnr)
    local navic = require("nvim-navic")
    if client.server_capabilities.documentSymbolProvider then
        navic.attach(client, bufnr)
    end
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    -- Enable completion triggered by <c-x><c-o>
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', k_opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', k_opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', k_opts)
    require('legendary').keymaps(on_attach_keymap)
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
}


return {
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
        local has_elixir, elixir = pcall(require, "elixir")
        if has_elixir then
            local elixirls = require("elixir.elixirls")
            elixir.setup {
                elixirls = {
                    on_attach = on_attach,
                    capabilities = capabilities,
                    cmd = { vim.fn.stdpath('data') .. "/mason/bin/elixir-ls" },
                    settings = elixirls.settings({
                        dialyzerEnabled = true,
                        fetchDeps = false,
                        enableTestLenses = false,
                        suggestSpecs = true,
                    }),
                }
            }
        else
            require 'lspconfig'.elixirls.setup {
                on_attach = on_attach,
                capabilities = capabilities,
                flags = { debounce_text_changes = 150 },
                cmd = { vim.fn.stdpath('data') .. "/mason/bin/elixir-ls" }
            }
        end
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
    end,
    ["yamlls"] = function()
        require 'lspconfig'.yamlls.setup {
            on_attach = on_attach,
            capabilities = capabilities,
            flags = { debounce_text_changes = 150 },
            settings = {
                yaml = {
                    keyOrdering = false
                }
            }
        }
    end
}