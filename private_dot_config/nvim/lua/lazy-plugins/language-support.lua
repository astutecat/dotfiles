return {
    {
        'nvim-treesitter/nvim-treesitter',
        opts = {
            ensure_installed = {
                "nix",
                "python",
                "bash",
                "elixir",
                "erlang",
                "lua",
                "rust",
                "yaml",
                "css",
                "html",
                "json",
                "vim",
                "hcl",
                "toml",
                "make",
                "regex",
                "ocaml",
                "r",
                "cpp",
                "javascript",
                "julia",
                "zig",
                "markdown"
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = {
                    "markdown",
                    "erlang",
                },
                disable = { "latex" },
            },
            indent = {
                enable = true,
            },
        },
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end,
    },
    {
        'RRethy/nvim-treesitter-endwise',
        dependencies = { 'nvim-treesitter' },
        opts = {
            endwise = {
                enable = true,
            },
        },
        config = function(_, opts)
            require('nvim-treesitter.configs').setup(opts)
        end
    },
    {
        'sheerun/vim-polyglot',
        opts = {},
        config = function(_, _)
            vim.g.ployglot_disabled = "autoindent"
        end
    },
    {
        'preservim/vim-markdown',
        dependencies = {
            { 'godlygeek/tabular' }
        }
    },
    {
        'alker0/chezmoi.vim'
    },

    {
        'simrat39/rust-tools.nvim',
        dependencies = {
            { 'mfussenegger/nvim-dap' },
            { 'neovim/nvim-lspconfig' }
        },
        opts = {
            server = {
                on_attach = function(_, bufnr)
                    local rt = require("rust-tools")
                    -- Hover actions
                    vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
                    -- Code action groups
                    vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
                end,
            },
        }
    },
    {
        'lervag/vimtex',
        config = function(...)
            vim.cmd([[
              if executable('zathura')
                let g:vimtex_view_method = 'zathura'
              elseif executable('skimpdf')
                let g:vimtex_view_method = 'skim'
                let g:vimtex_view_skim_sync = 1
              endif

              let g:vimtex_compiler_latexmk = {
                      \ 'executable' : 'latexmk',
                      \ 'options' : [
                      \   '-xelatex',
                      \   '-file-line-error',
                      \   '-synctex=1',
                      \   '-interaction=nonstopmode',
                      \ ],
                      \}

              let g:vimtex_quickfix_ignore_filters = [
                        \ 'Overfull \\vbox',
                        \]

              augroup vimtex_config
                au!
                au User VimtexEventQuit call vimtex#compiler#clean(0)
              augroup END
            ]])
        end,
        ft = { 'tex' }
    }


}
