local e = require("startup_events")

return {
  { 'vim-scripts/BufOnly.vim', event = e.vl },
  { 'rbgrouleff/bclose.vim',   event = e.vl },
  { 'rbong/vim-buffest',       event = e.vl },
  {
    'milkypostman/vim-togglelist',
    event = e.vl,
    init = function()
      vim.g.toggle_list_no_mappings = 1
    end,
    opts = {},
    keys = {
      {
        '<leader>tq',
        '<cmd>call ToggleQuickfixList()<cr>',
        desc = "Toggle Quickfix List",
        silent = true
      },
      {
        '<leader>qn',
        '<cmd>cn<cr>',
        silent = true
      },
      {
        '<leader>qp',
        '<cmd>cp<cr>',
        silent = true
      },
      {
        '<leader>tl',
        '<cmd>call ToggleLocationList()<CR>',
        desc = "Toggle Location List",
        silent = true
      },
    },
    config = function(_, _) end
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = 'kevinhwang91/promise-async',
    event = e.vl,
    opts = require("lazy-plugins.opts.nvim-ufo"),
    init = function ()
      vim.o.foldcolumn = "1" -- '0' is not bad
      vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
      vim.o.foldlevelstart = 99
      vim.o.foldenable = true
      vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
    end,
    config = function(_, opts)
      -- UFO folding
      -- TODO: Switch to using legendary.
      -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

      require("ufo").setup(opts)
    end
  },

}
