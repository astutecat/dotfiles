local cs_opts = {
  style = "night",
  light_style = "day",
  transparent = false,
  terminal_colors = true,
  styles = {
    comments = { italic = true },
    keywords = { italic = true },
    functions = { },
    variables = {},
    sidebars = "dark",
    floats = "dark",
  },
  sidebars = { "qf", "help", "lazy" },
  day_brightness = 0.3,
  hide_inactive_statusline = false,
  dim_inactive = true, -- dims inactive windows
  lualine_bold = false,
  on_colors = function (colors)
    colors.border = "#565f89"
  end,
  cache = true,
  plugins = {
    auto = true
  }
}

return {
  {
    "folke/tokyonight.nvim",
    version = "*",
    lazy = false,
    opts = cs_opts,
    config = function(_, opts)
      require("tokyonight").setup(opts)
      vim.cmd("colorscheme tokyonight-night")
    end,
    priority = 1000,
  },
  -- {
  --   "EdenEast/nightfox.nvim",
  --   lazy = false,
  --   opts = {
  --     options = {
  --       styles = {
  --         comments = "italic",
  --         keywords = "italic",
  --         types = "NONE",
  --       }
  --     }
  --   },
  --   config = function(_, opts)
  --     require("nightfox").setup(opts)
  --     vim.cmd("colorscheme carbonfox")
  --   end,
  --   priority = 1000
  -- }
}
