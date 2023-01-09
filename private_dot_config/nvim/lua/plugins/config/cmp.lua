local cmp = require 'cmp'
local lspkind = require('lspkind')

cmp.setup({
  completion = {
    keyword_length = 2
  },
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol', -- do not show text alongside icons
      menu = ({
        buffer = "[buffer]",
        nvim_lsp = "[lsp]",
        vsnip = "[vsnip]",
        tags = "[tags]",
      }),
      preset = 'default',
      symbol_map = {
        Text = "",
        Method = "",
        Function = "",
        Constructor = "",
        Field = "ﰠ",
        Variable = "",
        Class = "ﴯ",
        Interface = "",
        Module = "",
        Property = "ﰠ",
        Unit = "塞",
        Value = "",
        Enum = "",
        Keyword = "",
        Snippet = "",
        Color = "",
        File = "",
        Reference = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = "פּ",
        Event = "",
        Operator = "",
        TypeParameter = ""
      },
      maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

      -- The function below will be called before any actual modifications from lspkind
      -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
      before = function(entry, vim_item)
        vim_item.dup = ({
          vsnip = 0,
          nvim_lsp = 0
        })[entry.source.name] or 1
        return vim_item
      end
    })
  },
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
  }),
  sources = {
    { name = 'vsnip', keyword_length = 2, priority = 6 },
    { name = 'nvim_lsp', priority = 3 },
    { name = 'buffer', max_item_count = 5, priority = 7 },
    { name = 'tags', keyword_length = 3, max_item_count = 5, priority = 6 },
    { name = 'latex_symbols', keyword_length = 3, priority = 5, max_item_count = 5 },
    { name = 'nvim_lsp_signature_help', priority = 1 }
  },
  sorting = {
    comparators = {
      cmp.config.compare.offset,
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'nvim_lsp_document_symbol' }
  },
    {
      { name = 'buffer' }
    }
  )
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
