local shared_config = require("lazy-plugins.opts.lsp-shared")
local mason_path = vim.fn.stdpath('data') .. "/mason/bin/"
local lspconfig = require('lspconfig')

local function linter(name)
  return require("efmls-configs.linters."..name)
end
local function formatter(name)
  return require("efmls-configs.formatters."..name)
end

return {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    lspconfig[server_name].setup {
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
    lspconfig["erlangls"].setup {
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
      lspconfig.elixirls.setup {
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
    lspconfig.lua_ls.setup {
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
    lspconfig.yamlls.setup {
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
    lspconfig.tailwindcss.setup({
      capabilities = shared_config.capabilities,
      filetypes = { "html", "elixir", "eelixir", "heex" },
      root_dir = lspconfig.util.root_pattern(
        'tailwind.config.js',
        'tailwind.config.ts',
        'postcss.config.js',
        'postcss.config.ts',
        'package.json',
        'node_modules',
        '.git',
        'mix.exs'
      ),
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
  ["emmet_ls"] = function()
    lspconfig.emmet_ls.setup({
      capabilities = shared_config.capabilities,
      filetypes = { "html", "css", "elixir", "eelixir", "heex" },
    })
  end,
  ["efm"] = function()
    local efmls = require 'efmls-configs'
    efmls.init {
      on_attach = shared_config.on_attach,
      capabilities = shared_config.capabilities,
      init_options = {
        documentFormatting = true,
      },
      default_config = true,
    }
    local shellcheck = linter("shellcheck")
    local shfmt = formatter("shfmt")
    local prettier_d = formatter("prettier_d")
    efmls.setup {
      sh = {
        linter = shellcheck,
        formatter = shfmt
      },
      bash = {
        linter = shellcheck,
        formatter = shfmt
      },
      lua = {
        linter = linter("luacheck"),
        formatter = formatter("lua_format")
      },
      yaml = {
        linter = linter("yamllint"),
        formatter = prettier_d
      },
      css = {
        formatter = prettier_d
      },
      html = {
        formatter = prettier_d
      },
      typescript = {
        formatter = prettier_d
      },
      javascript = {
        formatter = prettier_d
      },
      python = {
        formatter = formatter("black"),
        linter = linter("pylint")
      }
    }
  end
}
