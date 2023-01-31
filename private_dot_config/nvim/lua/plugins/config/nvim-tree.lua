-- following options are the default
-- each of these are documented in `:help nvim-tree.OPTION_NAME`
require'nvim-tree'.setup {
  disable_netrw       = true,
  hijack_netrw        = true,
  open_on_setup       = false,
  ignore_ft_on_setup  = {},
  open_on_tab         = true,
  hijack_cursor       = true,
  update_cwd          = true,
  renderer = {
    add_trailing = true,
    highlight_opened_files = "none",
    group_empty = true,
    icons = {
      show = {
        git = false,
        folder = false,
        file = true,
        folder_arrow = true,
      },
    },
    special_files = {
      "rebar.config",
      "Makefile",
      "mix.exs",
      "Cargo.toml",
      "shell.nix",
      "default.nix",
      "justfile",
      "Justfile",
      ".justfile",
      "Procfile"
    },
  },
  diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
  },
  update_focused_file = {
    enable      = false,
    update_cwd  = true,
    ignore_list = {}
  },
  system_open = {
    cmd  = nil,
    args = {}
  },
  filters = {
    dotfiles = false,
    custom = {
      "^.git$",
      "^.hg$"
    }
  },
  view = {
    width = 30,
    hide_root_folder = true,
    side = 'left',
    mappings = {
      custom_only = false,
      list = {}
    }
  }
}

local opts = { noremap=true, silent=false }
local api = vim.api
api.nvim_set_keymap('n', '<leader>ee', '<cmd>NvimTreeFindFileToggle<cr>', opts)
api.nvim_set_keymap('n', '<leader>ef', '<cmd>NvimTreeFindFile<cr>', opts)
api.nvim_set_keymap('n', '<leader>er', '<cmd>NvimTreeRefresh<cr>', opts)
api.nvim_set_keymap('n', '<leader>ec', '<cmd>NvimTreeCollapse<cr>', opts)

