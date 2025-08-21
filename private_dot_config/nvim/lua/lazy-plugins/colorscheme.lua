return {
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    enabled = false,
    config = function()
      require('onedark').setup {
        style = 'cool',
        transparent = false,
        compile = true,

        lualine = {
          transparent = true, -- lualine center bar transparency
        },
      }
      -- Enable theme
      require('onedark').load()
      vim.cmd([[
      hi LspReferenceRead guibg=NONE
      hi LspReferenceText guibg=NONE
      hi LspReferenceWrite guibg=NONE
      hi LspSignatureActiveParameter gui=NONE guibg=NONE
      ]])
    end
  },
  {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    enabled = true,
    opts = {
      options = {
        terminal_colors = true,
        styles = {
          comments = "italic",
          types = "italic",
        }
      }
    },
    init = function()
      vim.cmd([[
        colorscheme nightfox
        ]])
      vim.api.nvim_set_hl(0, '@markup.strikethrough', {
        strikethrough = false,
        force = true,
      })
    end
  }
}

-- local cs_opts = {
--   style = "night",
--   light_style = "day",
--   transparent = false,
--   terminal_colors = true,
--   styles = {
--     comments = { italic = true },
--     keywords = { italic = true },
--     functions = {},
--     variables = {},
--     sidebars = "dark",
--     floats = "dark",
--   },
--   sidebars = { "qf", "help", "lazy" },
--   day_brightness = 0.3,
--   hide_inactive_statusline = false,
--   dim_inactive = true, -- dims inactive windows
--   lualine_bold = false,
--   on_colors = function(colors)
--     colors.border = "#565f89"
--   end,
--   cache = true,
--   plugins = {
--     auto = true
--   }
-- }
-- return {
--   {
--     "folke/tokyonight.nvim",
--     version = "*",
--     lazy = false,
--     opts = cs_opts,
--     config = function(_, opts)
--       require("tokyonight").setup(opts)
--       vim.cmd("colorscheme tokyonight-night")
--       vim.cmd([[
--       hi LspReferenceRead guibg=NONE
--       hi LspReferenceText guibg=NONE
--       hi LspReferenceWrite guibg=NONE
--       hi LspSignatureActiveParameter gui=bold guibg=NONE
--       ]])
--     end,
--     priority = 1000,
--   },
-- }
