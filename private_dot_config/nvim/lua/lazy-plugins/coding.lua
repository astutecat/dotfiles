local e = require("startup_events")

return {
  {
    'sheerun/vim-polyglot',
    opts = {},
    config = function(_, _)
      vim.g.ployglot_disabled = { "autoindent" }
    end,
    event = e.buf_read_or_new
  },
  {
    'tpope/vim-sleuth',
    dependencies = { 'sheerun/vim-polyglot' },
    event = e.buf_read_pre_or_new
  },
  { 'christoomey/vim-sort-motion' },
  { 'ludovicchabant/vim-gutentags' },
  {
    'machakann/vim-swap',
    init = function()
      vim.g.swap_no_default_key_mappings = 1
    end,
    opts = {},
    config = function(_, _)
      local mappings = {
        {
          'g<',
          '<Plug>(swap-prev)',
          description = "nvim-swap: Swap with previous item",
        },
        {
          'g>',
          '<Plug>(swap-next)',
          description = "nvim-swap: Swap with next item",
        },
      }
      require('legendary').keymaps(mappings)
      vim.cmd [[
        nmap gS <Plug>(swap-interactive)
        xmap gS <Plug>(swap-interactive)
      ]]
    end,
    event = e.vl
  },
  { 'wakatime/vim-wakatime',      event = e.vl },
  {
    'astutecat/nclipper.vim',
    init = function()
      vim.g.nclipper_nomap = 1
    end,
    config = function()
      local opts = { noremap = true }
      local mappings = {
        {
          '<M-y>',
          '<Plug>(nclipper)',
          description = "NClipper: Context Copy (No Filename)",
          mode = { 'v' },
          opts = opts
        },
        {
          '<C-y>',
          '<Plug>(nclipper-with-filename)',
          description = "NClipper: Context Copy",
          mode = { 'v' },
          opts = opts
        },
      }
      require('legendary').keymaps(mappings)
    end,
    event = e.vl
  },
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      modes = {
        search = {
          enabled = true
        }
      }
    },
    -- stylua: ignore
    keys = {
      { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
      { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
      { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
      { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
      { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
    },
  }
}
