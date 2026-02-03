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
        severity_sort = true,
      })
    end,
  }
end

local function conform_opts()
  local prettier = { "prettierd", "prettier", stop_after_first = true }

  return {
    -- Define your formatters
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = prettier,
      typescript = prettier,
      javascriptreact = prettier,
      typescriptreact = prettier,
      svelte = prettier,
      css = prettier,
      html = prettier,
      json = prettier,
      markdown = prettier,
      graphql = prettier,
      yaml = { "yamlfmt", "prettierd", "prettier", stop_after_first = true },
      zsh = { "beautysh" },
      toml = { "tombi", "taplo", stop_after_first = true },
      sql = { "sqlfmt", "sql-formatter", stop_after_first = true },
      sh = { "beautysh", "shellharden" },
      bash = { "beautysh", "shellharden" },
      elixir = { "mix" },
      rust = { "rustfmt" },
      gleam = { "gleam" },
      erlang = { "erlfmt", "efmt", stop_after_first = true },
      dockerfile = { "dockerfmt" },
    },
    -- Set default options
    default_format_opts = {
      lsp_format = "fallback",
    },
    -- Set up format-on-save
    format_on_save = function(bufnr)
      -- Disable with a global or buffer-local variable
      if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
        return
      end
      return { timeout_ms = 500, lsp_format = "fallback" }
    end,
    -- Customize formatters
    formatters = {
      shfmt = {
        append_args = { "-i", "2" },
      },
    },
  }
end

return {
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        -- Customize or remove this keymap to your liking
        "<leader>lf",
        function()
          require("conform").format({ async = true })
        end,
        mode = "",
        desc = "Conform: Format buffer",
      },
    },
    opts = conform_opts(),
    init = function()
      -- If you want the formatexpr, here is the place to set it
      vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

      vim.api.nvim_create_user_command("FormatDisable", function(args)
        if args.bang then
          -- FormatDisable! will disable formatting just for this buffer
          vim.b.disable_autoformat = true
        else
          vim.g.disable_autoformat = true
        end
      end, {
        desc = "Disable autoformat-on-save",
        bang = true,
      })
      vim.api.nvim_create_user_command("FormatEnable", function()
        vim.b.disable_autoformat = false
        vim.g.disable_autoformat = false
      end, {
        desc = "Re-enable autoformat-on-save",
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = {
      "BufReadPre",
      "BufNewFile",
    },
    config = function()
      local lint = require("lint")

      lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        svelte = { "eslint_d" },
        python = { "pylint" },
        yaml = { "yamllint" },
        gitcommit = { "gitlint" },
        sh = { "shellcheck" },
        bash = { "shellcheck" },
        toml = { "tombi" },
      }

      local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

      vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  {
    "nvim-lua/lsp-status.nvim",
    event = e.lsp_a,
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
        "prettierd",
        "luacheck",
        "black",
        "pylint",
        "lua-language-server",
        "bash-language-server",
        "yamllint",
        "yamlfmt",
        "json-lsp",
        "gitlint",
        "beautysh",
        "tombi",
        "hadolint",
        "expert",
        "sqlls",
        "ols",
        "sqlfmt",
        "isort",
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
      vim.lsp.enable("taplo")

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
  trouble_entry(),
}
