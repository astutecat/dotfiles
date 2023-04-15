-- TODO: legendary.keymaps(require("legendary_keymaps.telescope")
return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            {'nvim-lua/plenary.nvim',},
            {'nvim-telescope/telescope-fzy-native.nvim'}
        },
        opts = {
            require("lazy-plugins.opts.telescope")
        }
    },
    {
        'ahmedkhalf/project.nvim',
        dependencies = { "nvim-telescope/telescope.nvim" },
        opts = {
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
        },
        config = function (_, opts)
            require("project_nvim").setup(opts)
            require("telescope").load_extension('projects')
        end
    },
    { 'nvim-telescope/telescope-fzy-native.nvim',
        dependencies = { "telescope.nvim" },
        config = function(_, _)
            require('telescope').load_extension('fzy_native')
        end
    }
}