local shared_config = require("lazy-plugins.opts.lsp-shared")
local mason_path = vim.fn.stdpath('data') .. "/mason/bin/"

return {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup {
      on_attach = shared_config.on_attach,
      capabilities = shared_config.capabilities,
      flags = {
        debounce_text_changes = 150,
      }
    }
  end,
  ["erlangls"] = function()
    local beam_utils = require("beam_utils")
    local flag = require("config_flags")
    if flag.on_d9 and beam_utils.erl_version() < 22 then return end
    require("lspconfig")["erlangls"].setup {
      on_attach = shared_config.on_attach,
      capabilities = shared_config.capabilities,
      flags = {
        debounce_text_changes = 150,
      },
      cmd = { mason_path .. "erlang_ls" }
    }
  end,
  ["elixirls"] = function()
    local has_elixir, _ = pcall(require, "elixir")
    if not has_elixir then
      require 'lspconfig'.elixirls.setup {
        on_attach = shared_config.on_attach,
        capabilities = shared_config.capabilities,
        flags = { debounce_text_changes = 150 },
        cmd = { mason_path .. "elixir-ls" }
      }
    end
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  ["lua_ls"] = function()
    require 'lspconfig'.lua_ls.setup {
      on_attach = shared_config.on_attach,
      capabilities = shared_config.capabilities,
      flags = { debounce_text_changes = 150 },
      settings = {
        Lua = {
          diagnostics = { enable = false },
          format = {
            enable = true,
            defaultConfig = {
              indent_style = "space",
              indent_size = 2
            }
          }
        }
      }
    }
  end,
  ["yamlls"] = function()
    require 'lspconfig'.yamlls.setup {
      on_attach = shared_config.on_attach,
      capabilities = shared_config.capabilities,
      flags = { debounce_text_changes = 150 },
      settings = {
        yaml = {
          keyOrdering = false
        }
      }
    }
  end,
  ["tailwindcss"] = function()
    require 'lspconfig'.tailwindcss.setup({
      capabilities = shared_config.capabilities,
      filetypes = { "html", "elixir", "eelixir", "heex" },
      init_options = {
        userLanguages = {
          elixir = "html-eex",
          eelixir = "html-eex",
          heex = "html-eex",
        },
      },
      settings = {
        tailwindCSS = {
          experimental = {
            classRegex = {
              'class[:]\\s*"([^"]*)"',
            },
          },
        },
      },
    })
    end,
   ["emmet_ls"] = function ()
     require 'lspconfig'.emmet_ls.setup({
  capabilities = shared_config.capabilities,
  filetypes = { "html", "css", "elixir", "eelixir", "heex" },
})
  end
}
