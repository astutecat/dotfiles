local e = require("startup_events")
local lsp_lines_source = "https://git.sr.ht/~whynothugo/lsp_lines.nvim"

return {
  { "nvim-lua/lsp-status.nvim", event = e.lsp_a },
  {
    "williamboman/mason.nvim",
    opts = {},
    version = false,
    event = e.vl,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "mason.nvim",
    },
    opts = {},
    event = e.vl,
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason.nvim" },
    event = e.vl,
    opts = {
      ensure_installed = {
        "efm",
        "prettierd",
        "luacheck",
        "stylua",
        "black",
        "shellcheck",
        "pylint",
        "lua-language-server",
        "bash-language-server",
        "yamllint",
        "yamlfmt",
        "shellharden",
        "json-lsp",
        "gitlint",
        "beautysh",
        "taplo",
        "hadolint",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      {
        "SmiteshP/nvim-navbuddy",
        dependencies = {
          "SmiteshP/nvim-navic",
          "MunifTanjim/nui.nvim",
        },
        opts = {
          lsp = {
            auto_attach = false,
          },
        },
      },
    },
    version = false,
    opts = require("lazy-plugins.opts.lsp"),
    config = function(_, opts)
      local shared_config = require("lazy-plugins.opts.lsp-shared")
      require("mason-lspconfig").setup_handlers(opts)
      require("lspconfig").gleam.setup({
        on_attach = shared_config.on_attach,
        capabilities = shared_config.capabilities,
      })
      local commands = {
        { ":LspRestart", description = "LSP: Restart" },
        { ":LspStart",   description = "LSP: Start" },
        { ":LspStop",    description = "LSP: Stop" },
        { ":LspInfo",    description = "LSP: Show Info" },
        { ":Mason",      description = "Show Mason" },
      }
      local kopts = { noremap = true, silent = true }
      local keymaps = {
        {
          "<leader>fn",
          "<cmd>Navbuddy<CR>",
          description = "Open Navbuddy",
          opts = kopts,
        },
      }
      require("legendary").commands(commands)
      require("legendary").keymaps(keymaps)
    end,
    event = e.vl,
  },
  {
    lsp_lines_source,
    dependencies = { "nvim-lspconfig" },
    version = false,
    opts = {},
    config = function(_, _)
      require("lsp_lines").setup()
      vim.diagnostic.config({
        virtual_text = false,
        virtual_lines = false,
      })
    end,
    event = e.lsp_a,
  },
  {
    "mhanberg/output-panel.nvim",
    event = e.vl,
    config = function()
      require("output_panel").setup()
      local commands = {
        {
          ":OutputPanel",
          description = "LSP: Show Output Panel",
        },
      }
      require("legendary").commands(commands)
    end,
  },
  {
    "creativenull/efmls-configs-nvim",
    version = "*", -- tag is optional
    dependencies = { "neovim/nvim-lspconfig" },
  },
  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>lt",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
    config = function(_, opts)
      require("trouble").setup(opts)
      vim.api.nvim_create_autocmd("QuickFixCmdPost", {
        callback = function()
          vim.cmd([[Trouble qflist open]])
        end,
      })
    end
  }
}
