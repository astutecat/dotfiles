require'nvim-treesitter.configs'.setup {
  -- ensure_installed = {
  --   "nix",
  --   "python",
  --   "bash",
  --   "elixir",
  --   "erlang",
  --   "lua",
  --   "rust",
  --   "yaml",
  --   "css",
  --   "html",
  --   "json",
  --   "vim",
  --   "hcl",
  --   "toml",
  --   "make",
  --   "regex",
  --   "ocaml",
  --   "r",
  --   "cpp",
  --   "javascript",
  --   "julia",
  --   "zig",
  --   "markdown"
  -- },
  --
  ensure_installed = "all",

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "markdown", "erlang" },
    disable = { "latex" },
  },
 indent = {
   enable = true,
 },
}

