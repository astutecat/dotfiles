local function number_of_tabs()
  return vim.fn.tabpagenr("$")
end

local function tab_width()
  local tabs = number_of_tabs()
  return 20 + ((tabs - 1) * 4)
end

local function buffer_width()
  local cols = vim.o.columns
  return cols - tab_width()
end

local function custom_location()
  local line = vim.fn.line('.')
  local col = vim.fn.virtcol('.')
  local total = vim.fn.line('$')
  return string.format('%3d:%-2d/%-d', line, col, total)
end

return {
  options = {
    icons_enabled = true,
    theme = 'tokyonight',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = {
      'encoding',
      'fileformat',
      'filetype',
      {
        require("lazy.status").updates,
        cond = require("lazy.status").has_updates,
        color = { fg = "#ff9e64" },
      },
    },
    lualine_y = {
      { 'progress' }
    },
    lualine_z = {
      { custom_location }
    }
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { 'filename' },
    lualine_x = {
      { custom_location }
    },
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {
    lualine_a = {
      {
        'buffers',
        show_filename_only = false,
        use_mode_colors = true,
        max_length = buffer_width,
        separator = ' ',
        symbols = {
          modified = ' ●',              -- Text to show when the buffer is modified
          alternate_file = '󰐤 ',         -- Text to show to identify the alternate file
          directory = ' ',             -- Text to show when the buffer is a directory
        },
      }
    },
    lualine_b = {
    },
    lualine_c = {
    },
    lualine_x = {
    },
    lualine_z = {
      {
        'tabs',
        mode = 2,
        use_mode_colors = true,
        tab_max_length = 20,
        max_length = tab_width
      }
    },
  },
  winbar = {},
  inactive_winbar = {
  },
  extensions = {
    'neo-tree'
  }
}
