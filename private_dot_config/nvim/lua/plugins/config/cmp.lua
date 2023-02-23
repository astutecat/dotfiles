local cmp = require 'cmp'
local lspkind = require('lspkind')

local symbols = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "ﰠ",
    Variable = "",
    Class = '',
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = ' ',
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = '',
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = '  ',
    Event = "",
    Operator = ' ',
    TypeParameter = '',
}

cmp.setup({
    completion = {
        keyword_length = 1
    },
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
            maxwidth = 50, -- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)

            -- The function below will be called before any actual modifications from lspkind
            -- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
            before = function(entry, vim_item)
                vim_item.dup = ({
                    buffer = 0,
                    tags = 0
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
        { name = 'vsnip', priority = 5 },
        { name = 'nvim_lsp', max_item_count = 8, priority = 4 },
        { name = 'buffer', max_item_count = 5, priority = 3 },
        { name = 'tags', keyword_length = 3, max_item_count = 5, priority = 2 },
        { name = 'latex_symbols', keyword_length = 4, max_item_count = 5, priority = 1 }
    },
    sorting = {
        comparators = {
            cmp.config.compare.score,
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.recently_used,
            cmp.config.compare.kind,
            cmp.config.compare.locality,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
        },
    },
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
        { name = 'git' },
    }, {
        { name = 'buffer' },
    })
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' }
    }
})

cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = 'path' }
    }, {
        { name = 'cmdline' }
    })
})
