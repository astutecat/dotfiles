return {
  'mhartington/formatter.nvim',
  opts = {},
  config = function()
    local opts = {
      filetype = {
        ["*"] = {
          require("formatter.filetypes.any").remove_trailing_whitespace
        },
        elixir = require("formatter.filetypes.elixir").mixformat,
        awk = require("formatter.filetypes.awk").prettierd,
        html = require("formatter.filetypes.html").prettierd,
        markdown = require("formatter.filetypes.markdown").prettierd,
        terraform = require("formatter.filetypes.terraform").terraformfmt,
        yaml = require("formatter.filetypes.yaml").yamlfmt
      }
    }
    require("formatter").setup(opts)
    local k_opts = { silent = true, noremap = true }
    local keymaps = {
      {
        '<space>f',
        '<cmd>Format',
        description = "Formatter: Format",
        opts = k_opts
      },
    }
    require('legendary').keymaps(keymaps)
  end
}
