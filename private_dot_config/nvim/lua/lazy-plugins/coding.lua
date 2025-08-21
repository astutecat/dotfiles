local e = require("startup_events")

return {
  {
    "sheerun/vim-polyglot",
    opts = {},
    config = function(_, _)
      vim.g.ployglot_disabled = { "autoindent" }
    end,
    event = e.buf_read_or_new,
  },
  {
    'vidocqh/auto-indent.nvim',
    opts = {
      indentexpr = function(lnum)
        return require("nvim-treesitter.indent").get_indent(lnum)
      end
    },
  },
  {
    "tpope/vim-sleuth",
    dependencies = { "sheerun/vim-polyglot" },
    event = e.buf_read_pre_or_new,
  },
  {
    "lukas-reineke/virt-column.nvim",
    dependencies = { "tpope/vim-sleuth" },
    opts = {
      char = "┆",
    },
    event = e.buf_read_pre_or_new,
  },
  { "christoomey/vim-sort-motion" },
  { "ludovicchabant/vim-gutentags" },
  {
    "machakann/vim-swap",
    init = function()
      vim.g.swap_no_default_key_mappings = 1
    end,
    opts = {},
    keys = {
      {
        "g<",
        "<Plug>(swap-prev)",
        desc = "nvim-swap: Swap with previous item",
      },
      {
        "g>",
        "<Plug>(swap-next)",
        desc = "nvim-swap: Swap with next item",
      },
    },
    config = function(_, _)
      vim.cmd([[
        nmap gS <Plug>(swap-interactive)
        xmap gS <Plug>(swap-interactive)
      ]])
    end,
    event = e.vl,
  },
  { "wakatime/vim-wakatime", event = e.vl },
  {
    "astutecat/nclipper.vim",
    init = function()
      vim.g.nclipper_nomap = 1
    end,
    keys = {
      {
        "<M-y>",
        "<Plug>(nclipper)",
        desc = "NClipper: Context Copy (No Filename)",
        mode = { "v" },
        noremap = true,
      },
      {
        "<C-y>",
        "<Plug>(nclipper-with-filename)",
        desc = "NClipper: Context Copy",
        mode = { "v" },
        noremap = true,
      },
    },
    event = e.vl,
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        search = {
          enabled = true,
        },
        char = {
          jump_labels = true,
        },
      },
    },
    -- stylua: ignore
    keys = {
      { "<c-s>", mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  },
}
