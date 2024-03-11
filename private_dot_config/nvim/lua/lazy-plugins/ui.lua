local e = require("startup_events")

return {
  {
    "stevearc/dressing.nvim",
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
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {},
  },
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
  { "chentoast/marks.nvim", event = e.buf_read_or_new },
  { "jeffkreeftmeijer/vim-numbertoggle", event = e.buf_read_or_new },
  {
    "folke/todo-comments.nvim",
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
          "--glob=!.hg",
        },
        pattern = [[\b(KEYWORDS):]],
      },
    },
    config = function(_, opts)
      require("todo-comments").setup(opts)
      local mappings = require("lazy-plugins.keymaps.todo_comments")
      require("legendary").keymaps(mappings)
    end,
    event = e.buf_read_or_new,
  },

  {
    "SmiteshP/nvim-navic",
    opts = {
      separator = "  ",
    },
  },

  {
    "utilyre/barbecue.nvim",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      theme = "tokyonight",
    },
    event = e.buf_read_or_new,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", "SmiteshP/nvim-navic" },
    opts = require("lazy-plugins.opts.lualine"),
  },

  -- {
  --   "petertriho/nvim-scrollbar",
  --   opts = {},
  --   config = function(_, opts)
  --     require("scrollbar").setup(opts)
  --     require("scrollbar.handlers.gitsigns").setup()
  --   end,
  --   dependencies = {
  --     { "lewis6991/gitsigns.nvim" },
  --   },
  -- },

  {
    "kevinhwang91/nvim-hlslens",
    dependencies = { "kevinhwang91/nvim-ufo" },
    opts = {
      auto_enable = true
    },
    config = function(_, opts)
      -- require("scrollbar.handlers.search").setup()
      require("hlslens").setup(opts)
      local kopts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap(
        "n",
        "n",
        [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      vim.api.nvim_set_keymap(
        "n",
        "N",
        [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
        kopts
      )
      local mappings = require("lazy-plugins.keymaps.hlslens")
      require("legendary").keymaps(mappings)
    end,
    event = e.vl,
  },

  {
    "luukvbaal/statuscol.nvim",
    event = e.buf_read_pre_or_new,
    config = function()
      local builtin = require("statuscol.builtin")
      require("statuscol").setup({
        segments = {
          -- { text = { builtin.foldfunc, " " }, click = "v:lua.ScFa" },
          {
            text = { builtin.lnumfunc, " " },
            condition = { true, builtin.not_empty },
            click = "v:lua.ScLa",
          },
          { text = { "%s" }, click = "v:lua.ScSa" },
        },
      })
    end,
  },

  {
    "NvChad/nvim-colorizer.lua",
    opts = {
      user_default_options = {
        names = false,
        mode = "virtualtext",
      },
    },
    event = e.buf_read_or_new,
  },
}
