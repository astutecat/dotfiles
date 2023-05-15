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
    opt = {},
    config = function(_, _)
      local opts = { silent = true }
      local mappings = {
        {
          '<leader>tq',
          '<cmd>call ToggleQuickfixList()<cr>',
          description = "Toggle Quickfix List",
          opts = opts
        },
        {
          '<leader>qn',
          '<cmd>cn<cr>',
          opts = opts
        },
        {
          '<leader>qp',
          '<cmd>cp<cr>',
          opts = opts
        },
        {
          '<leader>tl',
          '<cmd>call ToggleLocationList()<CR>',
          description = "Toggle Location List",
          opts = opts
        },
      }
      require('legendary').keymaps(mappings)
    end
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
