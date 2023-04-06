local null_ls = require("null-ls")
local builtins = null_ls.builtins
null_ls.setup({
    sources = {
      builtins.diagnostics.trail_space,
      builtins.code_actions.gitsigns,
      builtins.formatting.yamlfmt,
      builtins.diagnostics.yamllint,
      null_ls.builtins.diagnostics.zsh
    },
  })
