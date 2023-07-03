local e = require("startup_events")

return {
  {
    'tpope/vim-sleuth',
    dependencies = { 'sheerun/vim-polyglot' },
    event = e.vl
  },
  { 'fidian/hexmode',               event = e.vl },
  { 'christoomey/vim-sort-motion',  event = e.vl },
  { 'ludovicchabant/vim-gutentags', event = e.vl },
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
  { 'wakatime/vim-wakatime', event = e.vl },
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
    'lambdalisue/suda.vim',
    version = '^0.4',
    event = e.vl,
  }
}
