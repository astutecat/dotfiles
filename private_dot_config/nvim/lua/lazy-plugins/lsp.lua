local e = require("startup_events")
local flags = require("config_flags")
local lsp_lines_source = "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
--TODO: Remove this when no longer on d9.
if flags.on_d9 then
  lsp_lines_source = "git@github.com:astutecat/lsp_lines.nvim.git"
end

return {
  { 'nvim-lua/lsp-status.nvim', event = e.lsp_a },
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
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { 'mason.nvim' },
    event = e.vl,
    opts = {
      ensure_installed = {
        "efm",
        "prettierd",
        "luacheck",
        "black",
        "shellcheck",
        "shfmt",
        "pylint",
        "lua-language-server",
        "yamllint",
        "yamlfmt",
        "shellharden"
      }
    }
  },
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'mason-lspconfig.nvim',
      'nvim-navic',
      'hrsh7th/cmp-nvim-lsp',
    },
    version = false,
    opts = require("lazy-plugins.opts.lsp"),
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
        virtual_lines = { highlight_whole_line = false },
      })
    end,
    event = e.lsp_a
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
  },
  {
    'creativenull/efmls-configs-nvim',
    version = '*', -- tag is optional
    dependencies = { 'neovim/nvim-lspconfig' },
  }
}
