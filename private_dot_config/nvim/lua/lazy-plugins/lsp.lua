local e = require("startup_events")

return {
  { 'nvim-lua/lsp-status.nvim',  event = e.vl },
  {
    "williamboman/mason.nvim",
    opts = {},
    version = false,
    event = e.vl
  },
  { 'mhanberg/output-panel.nvim' },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { 'mason.nvim' },
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
    "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
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
    event = e.vl
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
          null_ls.builtins.diagnostics.selene
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
