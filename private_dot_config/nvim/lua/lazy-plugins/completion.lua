return {
  {
    'hrsh7th/cmp-vsnip',
    dependencies = { "hrsh7th/vim-vsnip" },
    event = "VeryLazy"
  },

  {
    "petertriho/cmp-git",
    dependencies = "nvim-lua/plenary.nvim",
    event = "VeryLazy",
    opts = {

    }
  },

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      "vim-vsnip",
      'onsails/lspkind.nvim',
      'hrsh7th/cmp-vsnip',
      'quangnguyen30192/cmp-nvim-tags',
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-nvim-lsp' },
      'MeanderingProgrammer/render-markdown.nvim',
      "petertriho/cmp-git",
    },
    opts = {},
    event = "VeryLazy",
    config = function(_, _)
      local lspkind = require('lspkind')
      local symbols = require("type-icons")
      local cmp = require 'cmp'
      cmp.setup {
        completion = {
          --completeopt = "menu,menuone,noinsert",
          keyword_length = 2
        },
        preselect = cmp.PreselectMode.None,
        formatting = {
          window = {
            completion = {
              winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
              col_offset = -3,
              side_padding = 0,
            },
          },
          format = lspkind.cmp_format({
            mode = 'symbol', -- do not show text alongside icons
            menu = ({
              buffer = "[buffer]",
              nvim_lsp = "[lsp]",
              vsnip = "[vsnip]",
              tags = "[tags]",
            }),
            preset = 'default',
            symbol_map = symbols,
            maxwidth = 60, -- prevent the popup from showing more than provided characters (e.g 50 characters)
            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization.
            -- (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
              vim_item.dup = ({
                buffer = 0,
                tags = 0,
                cmdline = 0
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
          { name = 'vsnip',    keyword_length = 1 },
          { name = 'nvim_lsp', keyword_length = 1 },
          { name = 'render-markdown' },
          { name = 'buffer',   keyword_length = 3 },
          { name = 'tags',     keyword_length = 4 },
        },
        performance = {
          debounce = 200,
          -- throttle = 60,
          -- fetching_timeout = 200,
          max_view_entries = 30
        },
      }
      -- Set configuration for specific filetype.
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' },
        }, {
          { name = 'buffer' },
        })
      })

      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer', max_item_count = 10 }
        },
      })

      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'cmdline' }
        }, {
          { name = 'path', max_item_count = 10 }
        })
      })
    end
  },



}
