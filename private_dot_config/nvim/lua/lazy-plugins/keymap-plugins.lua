local legendary_extension_config = {
  lazy_nvim = true,
  which_key = {
    -- Automatically add which-key tables to legendary
    -- see ./doc/WHICH_KEY.md for more details
    auto_register = true,
    -- you can put which-key.nvim tables here,
    -- or alternatively have them auto-register,
    -- see ./doc/WHICH_KEY.md
    mappings = {},
    opts = {},
    -- controls whether legendary.nvim actually binds they keymaps,
    -- or if you want to let which-key.nvim handle the bindings.
    -- if not passed, true by default
    do_binding = true,
  }
}

local legendary_keys = {
    {
      "<C-P>",
      '<cmd>Legendary<cr>',
      desc = "Show Commands (Legendary)"
    },
    {
      '<cr>',
      '<cmd>nohlsearch<cr><cr>'
    },
    {
      "<leader>tr",
      '<cmd> set relativenumber!<cr>',
      desc = "Toggle relative line numbering"
    },
    {
      "<leader>w",
      '<cmd> set wrap!<cr>',
      desc = "Toggle line wrapping"
    },
    {
      "<leader>bd",
      '<cmd>Bclose<cr>',
      desc = "Buffer: Close"
    },
    {
      "<leader>bn",
      '<cmd>bn<cr>',
      desc = "Buffer: Next"
    },
    {
      "<leader>bp",
      '<cmd>bp<cr>',
      desc = "Buffer: Previous"
    },
    {
      '<M-C-]>',
      ':tselect <C-R><C-W><CR>',
      desc = 'Tag Select',
    },
  }


local legendary_config = {
  extensions = legendary_extension_config,
  -- Initial keymaps to bind
  keymaps = {},
  -- Initial commands to bind
  commands = {
    { ':Lazy', description = "Show lazy.nvim" },
  },
  -- Initial augroups/autocmds to bind
  autocmds = {
    {
      'VimResized',
      ':wincmd =',
    },
  },
  -- Initial functions to bind
  funcs = {},
  -- Initial item groups to bind,
  -- note that item groups can also
  -- be under keymaps, commands, autocmds, or funcs
  itemgroups = {},
  -- default opts to merge with the `opts` table
  -- of each individual item
  default_opts = {
    keymaps = { noremap = true },
    commands = {},
    autocmds = {},
  },
  select_prompt = ' legendary.nvim ',
  col_separator_char = '│',
  default_item_formatter = nil,
  include_builtin = true,
  include_legendary_cmds = true,
  sort = {
    most_recent_first = true,
    user_items_first = true,
    item_type_bias = nil,
    frecency = {
      db_root = string.format('%s/legendary/', vim.fn.stdpath('data')),
      max_timestamps = 10,
    },
  },
  scratchpad = {
    view = 'float',
    results_view = 'float',
    float_border = 'rounded',
    keep_contents = true,
  },
  cache_path = string.format('%s/legendary/', vim.fn.stdpath('cache')),
  log_level = 'info',
}


return {
  {
    'folke/which-key.nvim',
    opts = {
      preset = "helix"
    },
    version = "*"
  },
  {
    'mrjones2014/legendary.nvim',
    version = "*",
    dependencies = {
      'kkharji/sqlite.lua',
      'nvim-telescope/telescope.nvim',
      'folke/which-key.nvim',
    },
    opts = legendary_config,
    keys = legendary_keys
  }
}
