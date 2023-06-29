local function mappings(bufnr)
  local k_opts = { silent = true, noremap = true, buffer = bufnr }
  return {
    {
      '<space>fp',
      '<cmd>ElixirFromPipe<CR>',
      description = "Elixir: from pipe",
      opts = k_opts
    },
    {
      '<space>tp',
      '<cmd>ElixirToPipe<CR>',
      description = "Elixir: to pipe",
      opts = k_opts
    },
    {
      '<space>em',
      '<cmd>ElixirExpandMacro<CR>',
      description = "Elixir: expand macro",
      opts = k_opts
    },
  }
end

return {
  {
    "elixir-tools/elixir-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      'hrsh7th/cmp-nvim-lsp',
    },
    ft = { "elixir", "eex", "heex", "surface" },
    opts = {},
    config = function()
      local beam_utils = require("beam_utils")
      local flags = require("config_flags")
      if flags.on_d9 and not beam_utils.elixir_ls_usable() then return end
      local shared_config = require("lazy-plugins.opts.lsp-shared")
      local elixirls = require("elixir.elixirls")
      require("elixir").setup {
        credo = {
        },
        elixirls = {
          on_attach = function(client, bufnr)
            require('legendary').keymaps(mappings(bufnr))
            shared_config.on_attach(client, bufnr)
          end,
          capabilities = shared_config.capabilities,
          -- cmd = { vim.fn.stdpath('data') .. "/mason/bin/elixir-ls" },
          settings = elixirls.settings({
            dialyzerEnabled = true,
            fetchDeps = false,
            enableTestLenses = false,
            suggestSpecs = true,
          }),
        }
      }
    end,
  }
}
