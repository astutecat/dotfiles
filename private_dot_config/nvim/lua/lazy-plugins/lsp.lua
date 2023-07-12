local e = require("startup_events")
local flags = require("config_flags")
local lsp_lines_source = "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
--TODO: Remove this when no longer on d9.
if flags.on_d9 then
  lsp_lines_source = "git@github.com:astutecat/lsp_lines.nvim.git"
end

return {
  { 'nvim-lua/lsp-status.nvim',  event = e.lsp_a },
  {
    "williamboman/mason.nvim",
    opts = {},
    version = false,
    event = e.vl
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { 'mason.nvim' },
    opts = {},
    event = e.vl
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason-lspconfig.nvim',
      'nvim-navic',
      'hrsh7th/cmp-nvim-lsp',
    },
    version = false,
    opts = require("lazy-plugins.opts.nvim-lspconfig"),
    config = function(_, opts)
      require("mason-lspconfig").setup_handlers(opts)
      local commands = {
        { ':LspRestart', description = 'LSP: Restart', },
        { ':LspStart',   description = 'LSP: Start', },
        { ':LspStop',    description = 'LSP: Stop', },
        { ':LspInfo',    description = 'LSP: Show Info', },
        { ':Mason',      description = 'Show Mason', },
      }
      require("legendary").commands(commands)
    end,
    event = e.vl
  },
  {
    lsp_lines_source,
    dependencies = { 'nvim-lspconfig' },
    version = false,
    opts = {},
    config = function(_, _)
      require("lsp_lines").setup()
      vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = false,
      })
    end,
    event = e.lsp_a
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    opts = {},
    config = function(_, _)
      local null_ls = require("null-ls")
      local builtins = null_ls.builtins
      local shared_config = require("lazy-plugins.opts.lsp-shared")
      null_ls.setup({
        sources = {
          builtins.code_actions.gitsigns,
          builtins.diagnostics.trail_space.with({
            disabled_filetypes = { "lua", "python" },
          }),
          builtins.diagnostics.yamllint,
          builtins.formatting.yamlfmt,
          null_ls.builtins.diagnostics.zsh,
          null_ls.builtins.formatting.black,
          null_ls.builtins.diagnostics.pylint,
          null_ls.builtins.diagnostics.selene,
          null_ls.builtins.formatting.xmlformat,
          null_ls.builtins.formatting.latexindent
        },
        on_attach = shared_config.on_attach,
        debounce = 150
      })
    end,
    dependencies = {
      { 'lewis6991/gitsigns.nvim' }
    }
  },
  {
    "mhanberg/output-panel.nvim",
    event = e.vl,
    config = function()
      require("output_panel").setup()
      local commands = {
        {
          ':OutputPanel',
          description = "LSP: Show Output Panel",
        },
      }
      require("legendary").commands(commands)
    end,
  }
}
