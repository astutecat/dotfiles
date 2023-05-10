return {
  {
    'stevearc/dressing.nvim',
    lazy = true,
    init = function()
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.select = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.select(...)
      end
      ---@diagnostic disable-next-line: duplicate-set-field
      vim.ui.input = function(...)
        require("lazy").load({ plugins = { "dressing.nvim" } })
        return vim.ui.input(...)
      end
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true
  },
  { 'kshenoy/vim-signature',             event = { "BufReadPost", "BufNewFile" } },
  { 'jeffkreeftmeijer/vim-numbertoggle', event = { "BufReadPost", "BufNewFile" } },

  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      space_char_blankline = " ",
      char = "│",
      filetype_exclude = require("lazy-plugins.opts.coding-shared").no_indent_filetypes,
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
    event = { "BufReadPre", "BufNewFile" }
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    event = "BufEnter",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    opts = {
      source_selector = {
        winbar = true,
      },
      window = {
        width = 36
      },
      filesystem = {
        group_empty_dirs = true,
        use_libuv_file_watcher = true,
        filtered_items = {
          always_show = {
            ".gitignore",
            ".envrc",
          },
        }
      },
      buffers = {
        group_empty_dirs = true
      },
      default_component_configs = {
        icon = {
          default = '',
        },
        modified = {
          symbol = '',
        }
      },
      event_handlers = {
        {
          event = "neo_tree_window_after_open",
          handler = function(_)
            pcall(vim.cmd.AlphaRedraw)
          end
        },
        {
          event = "neo_tree_window_after_close",
          handler = function(_)
            pcall(vim.cmd.AlphaRedraw)
          end
        }
      }
    },
    config = function(_, opts)
      vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

      local mappings = {
        {
          "<leader>ee",
          "<cmd>Neotree toggle<cr>",
          mode = { 'n' },
          description = "Toggle Neotree"
        },
        {
          "<leader>er",
          "<cmd>NeoTreeReveal<cr>",
          mode = { 'n' },
          description = "Reveal File in Neotree"
        }

      }
      require('legendary').keymaps(mappings)

      vim.fn.sign_define("DiagnosticSignError",
        { text = " ", texthl = "DiagnosticSignError" })
      vim.fn.sign_define("DiagnosticSignWarn",
        { text = " ", texthl = "DiagnosticSignWarn" })
      vim.fn.sign_define("DiagnosticSignInfo",
        { text = " ", texthl = "DiagnosticSignInfo" })
      vim.fn.sign_define("DiagnosticSignHint",
        { text = "", texthl = "DiagnosticSignHint" })
      require("neo-tree").setup(opts)
    end
  },

  {
    'folke/todo-comments.nvim',
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      search = {
        comaand = "rg",
        args = {
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--glob=!node_modules",
          "--glob=!.git",
          "--glob=!.hg"
        },
        pattern = [[\b(KEYWORDS):]],
      },
    },
    config = function(_, opts)
      require("todo-comments").setup(opts)
      local mappings = require("lazy-plugins.keymaps.todo_comments")
      require('legendary').keymaps(mappings)
    end,
    event = { "BufReadPost", "BufNewFile" }
  },

  {
    'SmiteshP/nvim-navic',
    opts = {
      separator = '  ',
    }
  },

  {
    "utilyre/barbecue.nvim",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      theme = 'tokyonight',
    },
    event = { "BufReadPost", "BufNewFile" }
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'SmiteshP/nvim-navic' },
    opts = require("lazy-plugins.opts.lualine"),
  },

  {
    "petertriho/nvim-scrollbar",
    opts = {},
    config = function(_, opts)
      require("scrollbar").setup(opts)
      require("scrollbar.handlers.gitsigns").setup()
    end,
    dependencies = {
      { 'lewis6991/gitsigns.nvim' }
    }
  },

  {
    'kevinhwang91/nvim-hlslens',
    dependencies = { "nvim-scrollbar" },
    opts = {},
    config = function(_, _)
      require("scrollbar.handlers.search").setup()
      local kopts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap('n', 'n',
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts)
      vim.api.nvim_set_keymap('n', 'N',
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts)
      local mappings = require("lazy-plugins.keymaps.hlslens")
      require('legendary').keymaps(mappings)
    end,
    event = { "BufReadPost", "BufNewFile" }
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = require("lazy-plugins.opts.gitsigns"),
  },

}
