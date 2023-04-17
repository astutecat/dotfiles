local cs_opts = {
    style = "storm",
    light_style = "day",
    transparent = false,
    terminal_colors = true,
    styles = {
        comments = { italic = true },
        keywords = { italic = true },
        functions = {},
        variables = {},
        sidebars = "dark",
        floats = "dark",
    },
    sidebars = { "qf", "help", "lazy" },
    day_brightness = 0.3,
    hide_inactive_statusline = false,
    dim_inactive = false, -- dims inactive windows
    lualine_bold = false,
}

return {
    {
        "folke/tokyonight.nvim",
        lazy = false,
        opts = cs_opts,
        config = function(_, opts)
            require("tokyonight").setup(opts)
            vim.cmd("colorscheme tokyonight-night")
        end,
        priority = 1000,
    },
}
