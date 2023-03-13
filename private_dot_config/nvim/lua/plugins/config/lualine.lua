local function multiple_tabs_exist()
  return vim.fn.tabpagenr("$") > 1
end

local function custom_location()
  local line = vim.fn.line('.')
  local col = vim.fn.virtcol('.')
  local total = vim.fn.line('$')
  return string.format('%3d:%-2d/ %-d', line, col, total)
end

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'tokyonight',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
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
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
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
        lualine_c = {'filename'},
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
          separator = ' ',
          symbols = {
            modified = ' ●',      -- Text to show when the buffer is modified
            alternate_file = '藍', -- Text to show to identify the alternate file
            directory =  ' ',     -- Text to show when the buffer is a directory
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
          cond = multiple_tabs_exist
        }
      },
    },
    winbar = {},
  inactive_winbar = {
  },
  extensions = {
      'neo-tree',
      'fugitive'
    }
}

