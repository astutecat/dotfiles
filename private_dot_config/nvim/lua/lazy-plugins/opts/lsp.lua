local shared_config = require("lazy-plugins.opts.lsp-shared")
local mason_path = vim.fn.stdpath("data") .. "/mason/bin/"
local lspconfig = require("lspconfig")

local function linter(name)
  return require("efmls-configs.linters." .. name)
end
local function formatter(name)
  return require("efmls-configs.formatters." .. name)
end

return {
  -- The first entry (without a key) will be the default handler
  -- and will be called for each installed server that doesn't have
  -- a dedicated handler.
  function(server_name) -- default handler (optional)
    lspconfig[server_name].setup({
      on_attach = shared_config.on_attach,
      capabilities = shared_config.capabilities,
      flags = {
        debounce_text_changes = 150,
      },
    })
  end,
  ["erlangls"] = function()
    local flag = require("config_flags")
    if flag.on_d9 then
      return
    end
    lspconfig["erlangls"].setup({
      on_attach = shared_config.on_attach,
      capabilities = shared_config.capabilities,
      flags = {
        debounce_text_changes = 150,
      },
      cmd = { mason_path .. "erlang_ls" },
    })
  end,
  -- Next, you can provide a dedicated handler for specific servers.
  -- For example, a handler override for the `rust_analyzer`:
  ["lua_ls"] = function()
    lspconfig.lua_ls.setup({
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
              indent_size = 2,
            },
          },
        },
      },
    })
  end,
  ["yamlls"] = function()
    lspconfig.yamlls.setup({
      on_attach = shared_config.on_attach,
      capabilities = shared_config.capabilities,
      flags = { debounce_text_changes = 150 },
      settings = {
        yaml = {
          keyOrdering = false,
          schemaStore = {
            enable = false,
            url = "",
          },
          schemas = require("schemastore").yaml.schemas(),
        },
      },
    })
  end,
  ["jsonls"] = function()
    lspconfig.jsonls.setup({
      on_attach = shared_config.on_attach,
      capabilities = shared_config.capabilities,
      flags = { debounce_text_changes = 150 },
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })
  end,
  ["tailwindcss"] = function()
    lspconfig.tailwindcss.setup({
      capabilities = shared_config.capabilities,
      filetypes = { "html", "elixir", "eelixir", "heex" },
      root_dir = lspconfig.util.root_pattern(
        "tailwind.config.js",
        "tailwind.config.ts",
        "postcss.config.js",
        "postcss.config.ts",
        "package.json",
        "node_modules",
        ".git",
        "mix.exs"
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
  ["bashls"] = function()
    lspconfig.bashls.setup({
      on_attach = shared_config.on_attach,
      capabilities = shared_config.capabilities,
      settings = {
        bashIde = {
          shellcheckPath = "",
        },
      },
    })
  end,
  ["efm"] = function()
    local shellcheck = linter("shellcheck")
    local shfmt = formatter("shfmt")
    local prettier_d = formatter("prettier_d")
    local shellharden = formatter("shellharden")

    local languages = require("efmls-configs.defaults").languages()
    languages = vim.tbl_extend("force", languages, {
      sh = { shellcheck, shfmt, shellharden },
      bash = { shellcheck, shfmt, shellharden },
      yaml = { linter("yamllint"), prettier_d },
      css = { prettier_d },
      html = { prettier_d },
      typescript = { prettier_d },
      javascript = { linter("eslint"), prettier_d },
      python = { formatter("black"), linter("pylint") },
      gitcommit = { linter("gitlint") },
    })

    local efmls_config = {
      on_attach = shared_config.on_attach,
      capabilities = shared_config.capabilities,
      filetypes = vim.tbl_keys(languages),
      settings = {
        rootMarkers = { ".git/", "mix.exs", "justfile", "Makefile" },
        languages = languages,
      },
      init_options = {
        documentFormatting = true,
        documentRangeFormatting = true,
      },
    }

    lspconfig.efm.setup(efmls_config)
  end,
}
