return {
  -- {
  --   'rafamadriz/friendly-snippets',
  --   event = "VeryLazy"
  -- },
  {
    'hrsh7th/vim-vsnip',
    event = "VeryLazy",
    config = function(_, _)
      vim.cmd([[
        " Expand
        imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
        smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

        " Expand or jump
        imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
        smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'

        " Jump forward or backward
        imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
        smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
        imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
        smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'

        let g:vsnip_snippet_dir = '~/.config/nvim/snippets'
        ]])
    end
  },
  {
    'hrsh7th/vim-vsnip-integ',
    dependencies = { 'vim-vsnip' },
    event = "VeryLazy"
  },
  {
    "chrisgrieser/nvim-scissors",
    dependencies = "nvim-telescope/telescope.nvim", -- optional
    opts = {
      snippetDir = "~/.config/nvim/snippets",
    },
    keys = {
      {
        "<Leader>ne",
        function() require("scissors").editSnippet() end,
        desc = "Snippets: edit"
      },
      {
        "<Leader>na",
        function() require("scissors").addNewSnippet() end,
        desc = "Snippets: add",
        mode = {"n", "x"}
      },
    },
    init = function ()
      local wk = require("which-key")
      wk.add({ "<Leader>n", group = "snippets" })
    end
  },

}
