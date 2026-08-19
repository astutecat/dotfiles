local kopts = { noremap = true, silent = true }
return {
  {
    '<leader>ttl',
    '<cmd>TodoLocList<CR>',
    description = "TODO Comments: Show in Location List",
    opts = kopts
  },
  {
    '<leader>ttq',
    '<cmd>TodoQuickFix<CR>',
    description = "TODO Comments: Show in QuickFix List",
    opts = kopts
  },
  {
    '<leader>fd',
    '<cmd>TodoTelescope<CR>',
    description = "Telescope Show TODO Comments",
    opts = kopts
  },
}
