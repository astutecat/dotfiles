require'nvim-treesitter.configs'.setup {
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
    "julia"
  },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "markdown" },
    disable = { "latex" },
  },
 -- indent = {
 --   enable = true,
 -- },
}

