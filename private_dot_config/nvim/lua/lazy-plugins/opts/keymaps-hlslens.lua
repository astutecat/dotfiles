return {
    {
        "*",
        [[*<Cmd>lua require('hlslens').start()<CR>]],
        "Search word under cursor backward",
        opts = { silent = true }
    },
    {
        "#",
        [[#<Cmd>lua require('hlslens').start()<CR>]],
        "Search word under cursor forward",
        opts = { silent = true }
    },
    {
        "g*",
        [[g*<Cmd>lua require('hlslens').start()<CR>]],
        "Search word under cursor backward globally",
        opts = { silent = true }
    },
    {
        "g#",
        [[g#<Cmd>lua require('hlslens').start()<CR>]],
        "Search word under cursor forward globally",
        opts = { silent = true }
    },
}

