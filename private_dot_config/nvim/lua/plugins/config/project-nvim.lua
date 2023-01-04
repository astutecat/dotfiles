require("project_nvim").setup {
    patterns = {
        ".git",
        "_darcs",
        ".hg",
        ".bzr",
        ".svn",
        "Makefile",
        "package.json",
        ".tex.latexmain",
        "justfile",
        "Justfile",
        "rebar.config",
        "mix.exs"
    },
    manual_mode = true,
}

require("telescope").load_extension('projects')
