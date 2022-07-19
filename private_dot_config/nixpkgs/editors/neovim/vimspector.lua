vim.g.vimspector_sidebar_width = 85
vim.g.vimspector_bottombar_height = 15
vim.g.vimspector_terminal_maxwidth = 70
vim.g.vimspector_base_dir = "$HOME/.config/nvim.d/vimspector"
-- vim.g.vimspector_enable_mappings = 'VISUAL_STUDIO'
local opts = { noremap=true, silent=true }
local nvim_set_keymap = vim.api.nvim_set_keymap;

nvim_set_keymap('n', '<leader>db', '<cmd>call vimspector#ToggleBreakpoint()<CR>', opts)
nvim_set_keymap('n', '<leader>dw', '<cmd>call vimspector#AddWatch()<CR>', opts)
nvim_set_keymap('n', '<leader>de', '<cmd>call vimspector#Evaluate()<CR>', opts)
nvim_set_keymap('n', '<leader>dso', '<cmd>call vimspector#StepOver()<CR>', opts)
nvim_set_keymap('n', '<leader>dsi', '<cmd>call vimspector#StepInto()<CR>', opts)
nvim_set_keymap('n', '<leader>dsu', '<cmd>call vimspector#StepOut()<CR>', opts)
nvim_set_keymap('n', '<leader>dl', '<cmd>call vimspector#Launch()<CR>', opts)
nvim_set_keymap('n', '<leader>dr', '<cmd>call vimspector#Reset()<CR>', opts)
nvim_set_keymap('n', '<leader>dc', '<cmd>call vimspector#RunToCursor()<CR>', opts)
nvim_set_keymap('n', '<leader>djp', '<cmd>call vimspector#JumpToNextBreakpoint()<CR>', opts)
nvim_set_keymap('n', '<leader>djn', '<cmd>call vimspector#JumpToPreviousBreakpoint()<CR>', opts)
nvim_set_keymap('n', '<leader>di', '<Plug>VimspectorBalloonEval', opts)
nvim_set_keymap('x', '<leader>di', '<Plug>VimspectorBalloonEval', opts)

