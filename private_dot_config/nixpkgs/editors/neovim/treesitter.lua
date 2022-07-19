require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { "erlang", "markdown" },
    disable = { "latex", "erlang" },
  },
 -- indent = {
 --   enable = true,
 -- },
}

