local e = require("startup_events")
return {
  {
    "nathom/filetype.nvim",
    opts = {
      overrides = {
        extensions = {
          tla = "tlaplus"
        }
      }
    },
    config = function(_, opts)
      require("filetype").setup(opts)
    end,
    priority = 1000,
  },
  {
    'nvim-treesitter/nvim-treesitter',
    opts = {
      ensure_installed = {
        "nix",
        "python",
        "bash",
        "elixir",
        "heex",
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
        "markdown",
        "markdown_inline",
        "tlaplus",
        "awk",
        "haskell",
        "ssh_config",
        "gleam",
        "latex",
        "sql"
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = {
           "latex"
        },
        disable = {
          "latex"
        },
      },
      indent = {
        enable = true,
      },
    },
    build = ":TSUpdate",
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
    branch = "master",
    lazy = false
  },
  {
    'b0o/schemastore.nvim',
    ft = { "json", "yaml" }
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
    end,
    event = e.buf_read_or_new
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'echasnovski/mini.nvim'
    },
    opts = {
      preset = "obsidian",
      heading = {
        atx = true,
        setext = true,
        sign = false,
        icons = {}
      }
    },

  },

  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
  },

  {
    'alker0/chezmoi.vim',
    event = "VeryLazy"
  },
  {
    'mrcjkb/rustaceanvim',
    version = '^6',
    lazy = false,
  },
  {
    'lervag/vimtex',
    config = function()
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
  },

  {
    'tlaplus-community/tlaplus-nvim-plugin',
  },

  {
    "susliko/tla.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function(_, _)
      require("tla").setup()
    end,
    ft = { "tla" }
  },

  {
    'purescript-contrib/purescript-vim',
    version = '*'
  }

}
