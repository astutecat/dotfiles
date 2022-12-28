vim.g.nclipper_nomap = 1

local opts = { noremap=true }
vim.api.nvim_set_keymap('v', '<M-y>','<Plug>(nclipper)', opts)
vim.api.nvim_set_keymap('v', '<C-y>','<Plug>(nclipper-with-filename)', opts)

