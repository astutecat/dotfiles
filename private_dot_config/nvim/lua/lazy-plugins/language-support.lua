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
        "tlaplus",
        "awk",
        "haskell",
        "ssh_config"
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = {
          "markdown"
        },
        disable = { "latex" },
      },
      indent = {
        enable = true,
      },
    },
    build = ":TSUpdate",
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
    event = e.buf_read_or_new
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
    'preservim/vim-markdown',
    dependencies = {
      { 'godlygeek/tabular' }
    },
    ft = "markdown"
  },
  {
    'alker0/chezmoi.vim',
    event = "VeryLazy"
  },
  {
    'simrat39/rust-tools.nvim',
    dependencies = {
      { 'neovim/nvim-lspconfig' }
    },
    opts = {
      server = {
        on_attach = function(client, bufnr)
          require("lazy-plugins.opts.lsp-shared").on_attach(client, bufnr)

          local rt = require("rust-tools")
          -- Hover actions
          vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
          -- Code action groups
          vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
        end,
      },
    },
    ft = "rust"
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
    -- ft = { "tla" }
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
