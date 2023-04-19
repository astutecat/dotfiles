local k_opts = { silent = true, buffer = true, noremap = true}

return {
    {
        '<space>fp',
        '<cmd>ElixirFromPipe<CR>',
        description = "Elixir: from pipe",
        opts = k_opts
    },
    {
        '<space>tp',
        '<cmd>ElixirToPipe<CR>',
        description = "Elixir: to pipe",
        opts = k_opts
    },
    {
        '<space>em',
        '<cmd>ElixirExpandMacro<CR>',
        description = "Elixir: expand macro",
        opts = k_opts
    },
}

