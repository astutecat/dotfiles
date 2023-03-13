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
        "Justfile"
    },
    manual_mode = true,
}

require("telescope").load_extension('projects')
