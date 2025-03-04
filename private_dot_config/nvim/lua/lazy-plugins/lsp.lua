local e = require("startup_events")
local lsp_lines_source = "https://git.sr.ht/~whynothugo/lsp_lines.nvim"

local function trouble_entry()
  local key_prefix = "<leader>r"
  local function key(k) return key_prefix .. k end
  local function cmd(x) return "<cmd> Trouble " .. x .. "<cr>" end
  local function desc(x) return "Trouble: " .. x end

  return {
    "folke/trouble.nvim",
    dependencies = {
      "folke/todo-comments.nvim"
    },
    opts = {
      warn_no_results = false,
      open_no_results = true,
      auto_preview = false,
      preview = {
        scratch = false
      }
    },
    cmd = "Trouble",
    keys = {
      {
        key("xx"),
        cmd("diagnostics toggle"),
        desc = desc("Toggle Diagnostics"),
      },
      {
        key("xf"),
        cmd("diagnostics toggle filter.buf=0"),
        desc = desc("Toggle Diagnostics (Buffer)"),
      },
      {
        key("tt"),
        cmd("telescope toggle"),
        desc = desc("Toggle Telescope")
      },
      {
        key("o"),
        cmd("todo toggle"),
        desc = desc("Toggle Todo")
      },
      {
        key("s"),
        cmd("symbols toggle focus=false"),
        desc = desc("Symbols Toggle")
      },
      {
        key("l"),
        cmd("lsp toggle focus=false win.position=right"),
        desc = desc("LSP")
      },
      {
        key("L"),
        cmd("loclist toggle"),
        desc = desc("Location List Toggle"),
      },
      {
        key("q"),
        cmd("qflist toggle"),
        desc = desc("Quickfix List"),
      },
      {
        key("r"),
        function() require("trouble").close() end,
        desc = desc("Close")
      }
    },
    config = function(_, opts)
      require("trouble").setup(opts)
      vim.api.nvim_create_autocmd("QuickFixCmdPost", {
        callback = function()
          vim.cmd([[Trouble qflist open]])
        end,
      })
      local wk = require("which-key")
      wk.add({ key_prefix, group = "trouble" })
      wk.add({ key_prefix .. "t", group = "telescope" })
      wk.add({ key_prefix .. "x", group = "diagnostics" })
    end
  }
end

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
        "julials",
        "typos-lsp"
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
    cmd = { "OutputPanel" },
    version = "*",
    opts = {
      max_buffer_size = 5000
    },
    config = function(_, opts)
      require("output_panel").setup(opts)
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
  trouble_entry()
}
