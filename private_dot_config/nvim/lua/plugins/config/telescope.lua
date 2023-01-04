local telescope = require("telescope")
local actions = require("telescope.actions")
local previewer = require("telescope.previewers")

telescope.setup{
  defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
    mappings = {
      i = {
        ["<esc>"] = actions.close
      },
    },
    file_ignore_patterns = {
      "node_modules",
      ".git",
      ".hg"
    },
  },

  pickers = {
  },

  extensions = {
    -- frecency = {
    --   default_workspace = 'CWD',
    --   ignore_patterns = {"*.git/", "*/tmp/*", "*.hg/*"}
    -- },
  }
}

local opts = { noremap=true }
vim.api.nvim_set_keymap('n', '<C-P>','<cmd>Telescope find_files hidden=true no_ignore=false<cr>', opts)
vim.api.nvim_set_keymap('n', '<silent>', '<leader>t <cmd>Telescope current_buffer_tags<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fgt', '<cmd>Telescope tags<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fl', '<cmd>Telescope current_buffer_fuzzy_find<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fm', '<cmd>Telescope marks<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>ft', '<cmd>Telescope current_buffer_tags<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fr', '<cmd>Telescope resume<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fy', '<cmd>Telescope filetypes<cr>', opts)
vim.api.nvim_set_keymap('n', '<leader>fp', '<cmd>Telescope projects<cr>', opts)

