local e = require("startup_events")
local lsp_lines_source = "https://git.sr.ht/~whynothugo/lsp_lines.nvim"
local shared_config = require("lazy-plugins.opts.lsp-shared")

local function trouble_entry()
  local key_prefix = "<leader>r"
  local function key(k)
    return key_prefix .. k
  end
  local function cmd(x)
    return "<cmd> Trouble " .. x .. "<cr>"
  end
  local function desc(x)
    return "Trouble: " .. x
  end

  return {
    "folke/trouble.nvim",
    dependencies = {
      "folke/todo-comments.nvim",
    },
    opts = {
      warn_no_results = false,
      open_no_results = true,
      auto_preview = false,
      preview = {
        scratch = false,
      },
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
        desc = desc("Toggle Telescope"),
      },
      {
        key("o"),
        cmd("todo toggle"),
        desc = desc("Toggle Todo"),
      },
      {
        key("s"),
        cmd("symbols toggle focus=false"),
        desc = desc("Symbols Toggle"),
      },
      {
        key("l"),
        cmd("lsp toggle focus=false win.position=right"),
        desc = desc("LSP"),
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
        function()
          require("trouble").close()
        end,
        desc = desc("Close"),
      },
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

      vim.diagnostic.config({
        signs = {
          text = {
            [vim.diagnostic.severity.ERROR] = "",
            [vim.diagnostic.severity.WARN] = "",
            [vim.diagnostic.severity.INFO] = "",
            [vim.diagnostic.severity.HINT] = "󰌵",
          },
        },
      })
    end,
  }
end

local function linter(name)
  return require("efmls-configs.linters." .. name)
end
local function formatter(name)
  return require("efmls-configs.formatters." .. name)
end

local function efm_config()
  local shellcheck = linter("shellcheck")
  local beautysh = formatter("beautysh")
  local prettier_d = formatter("prettier_d")
  local shellharden = formatter("shellharden")

  local languages = require("efmls-configs.defaults").languages()
  languages = vim.tbl_extend("force", languages, {
    sh = { shellcheck, beautysh, shellharden },
    bash = { shellcheck, beautysh, shellharden },
    yaml = { linter("yamllint"), prettier_d },
    css = { prettier_d },
    html = { prettier_d },
    typescript = { prettier_d },
    javascript = { linter("eslint"), prettier_d },
    python = { formatter("black"), linter("pylint") },
    gitcommit = { linter("gitlint") },
    zsh = { beautysh },
    toml = { formatter("taplo") },
    lua = {},
    markdown = { prettier_d },
    sql = { formatter("sql-formatter") },
  })

  return {
    filetypes = vim.tbl_keys(languages),
    settings = {
      rootMarkers = {
        ".git/",
        "mix.exs",
        "justfile",
        "Makefile",
        "cargo.toml",
      },
      languages = languages,
    },
    init_options = {
      documentFormatting = true,
      documentRangeFormatting = true,
    },
  }
end

return {
  {
    "nvim-lua/lsp-status.nvim",
    event = e.lsp_a,
  },
  {
    "lukas-reineke/lsp-format.nvim",
    opts = {},
    event = e.vl,
  },
  {
    "mason-org/mason.nvim",
    opts = {},
    version = "*",
    event = e.vl,
  },
  {
    "mason-org/mason-lspconfig.nvim",
    version = "*",
    dependencies = {
      "mason.nvim",
    },
    opts = {
      automatic_enable = {
        exclude = {
          "rust_analyzer",
        },
      },
    },
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
        "expert",
        "sql-formatter",
        "sqlls",
        "ols",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-lspconfig.nvim",
      {
        "hasansujon786/nvim-navbuddy",
        dependencies = {
          "neovim/nvim-lspconfig",
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
    opts = {
      document_highlight = {
        enabled = false,
      },
    },
    config = function(_, _)
      vim.lsp.config("*", {
        capabilities = shared_config.capabilities,
        on_attach = shared_config.on_attach,
      })
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { enable = true },
            format = { enable = true, defaultConfig = { indent_style = "space", indent_size = 2 } },
          },
        },
      })
      vim.lsp.config("yamlls", {
        settings = {
          yaml = {
            keyOrdering = false,
            schemaStore = { enable = false, url = "" },
            schemas = require("schemastore").yaml.schemas(),
          },
        },
      })
      vim.lsp.config("jsonls", {
        settings = {
          json = {
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      })
      vim.lsp.config("typos_lsp", {
        cmd_env = { RUST_LOG = "error" },
        init_options = {
          -- Custom config. Used together with a config file found in the workspace or its parents,
          -- taking precedence for settings declared in both.
          -- Equivalent to the typos `--config` cli argument.
          -- config = '~/.config/typos.toml',
          -- How typos are rendered in the editor, can be one of an Error, Warning, Info or Hint.
          -- Defaults to error.
          diagnosticSeverity = "Hint",
        },
      })
      vim.lsp.enable("typos_lsp")

      vim.lsp.config("efm", efm_config())

      local commands = {
        { ":LspRestart", description = "LSP: Restart" },
        { ":LspStart", description = "LSP: Start" },
        { ":LspStop", description = "LSP: Stop" },
        { ":LspInfo", description = "LSP: Show Info" },
        { ":Mason", description = "Show Mason" },
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
        underline = false,
      })
    end,
    event = e.lsp_a,
  },
  {
    "elixir-tools/elixir-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      nextls = {
        enable = false,
      },
      elixirls = {
        enable = false,
      },
      projectionist = {
        enable = true,
      },
    },
  },
  {
    "creativenull/efmls-configs-nvim",
    version = "*", -- tag is optional
    dependencies = { "neovim/nvim-lspconfig" },
  },
  trouble_entry(),
}
