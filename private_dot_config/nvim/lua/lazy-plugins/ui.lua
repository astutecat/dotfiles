local e = require("startup_events")

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
  { 'kshenoy/vim-signature',             event = e.buf_read_or_new },
  { 'jeffkreeftmeijer/vim-numbertoggle', event = e.buf_read_or_new },

  {
    'lukas-reineke/indent-blankline.nvim',
    opts = {
      space_char_blankline = " ",
      char = "│",
      filetype_exclude = require("lazy-plugins.opts.coding-shared").no_indent_filetypes,
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
    event = e.buf_read_or_new
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
        sources = {
          { source = "filesystem", display_name = "  󰉓  " },
          { source = "buffers", display_name = "  󱔘  " },
          { source = "git_status", display_name = " 󰊢  " },
        },
      },
      window = {
        width = 30
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
      document_symbols = {
        kinds = {
          File = { icon = "󰈙", hl = "Tag" },
          Namespace = { icon = "󰌗", hl = "Include" },
          Package = { icon = "󰏖", hl = "Label" },
          Class = { icon = "󰌗", hl = "Include" },
          Property = { icon = "󰆧", hl = "@property" },
          Enum = { icon = "󰒻", hl = "@number" },
          Function = { icon = "󰊕", hl = "Function" },
          String = { icon = "󰀬", hl = "String" },
          Number = { icon = "󰎠", hl = "Number" },
          Array = { icon = "󰅪", hl = "Type" },
          Object = { icon = "󰅩", hl = "Type" },
          Key = { icon = "󰌋", hl = "" },
          Struct = { icon = "󰌗", hl = "Type" },
          Operator = { icon = "󰆕", hl = "Operator" },
          TypeParameter = { icon = "󰊄", hl = "Type" },
          StaticMethod = { icon = '󰠄 ', hl = 'Function' },
        }
      },
      default_component_configs = {
        icon = {
          folder_empty = "󰜌",
          folder_empty_open = "󰜌",
          default = '',
        },
        git_status = {
          symbols = {
            renamed  = "󰁕",
            unstaged = "󰄱",
          },
        },
        modified = {
          symbol = '',
        }
      },
      event_handlers = {
        {
          event = "neo_tree_window_after_open",
          handler = function(_)
            pcall(vim.cmd [[wincmd =]])
          end
        },
        {
          event = "neo_tree_window_after_close",
          handler = function(_)
            pcall(vim.cmd [[wincmd =]])
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
    event = e.buf_read_or_new
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
    event = e.buf_read_or_new
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
    event = e.buf_read_or_new
  },

  {
    'lewis6991/gitsigns.nvim',
    opts = require("lazy-plugins.opts.gitsigns"),
  },

  {
    "luukvbaal/statuscol.nvim",
    event = 'BufEnter',
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        segments = {
          { text = { "%s" },                  click = "v:lua.ScSa" },
          {
            text = { builtin.lnumfunc, " " },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
          },
          { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
        },
      })
    end
  },

  {
    'NvChad/nvim-colorizer.lua',
    opts = {
      user_default_options = {
        names = false,
        mode = "virtualtext"
      }
    },
    event = e.buf_read_or_new
  }

}
