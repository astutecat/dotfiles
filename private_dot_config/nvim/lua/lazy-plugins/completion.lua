return {
    {
        'hrsh7th/cmp-vsnip',
        dependencies = { "hrsh7th/vim-vsnip" },
        event = "VeryLazy"
    },

    {
        "petertriho/cmp-git",
        dependencies = "nvim-lua/plenary.nvim",
        event = "VeryLazy"
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
            { 'kdheepak/cmp-latex-symbols' },
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
                    completeopt = "menu,menuone,noinsert",
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
                    { name = 'vsnip',         max_item_count = 3 },
                    { name = 'nvim_lsp',      max_item_count = 7 },
                    { name = 'buffer',        max_item_count = 5, keyword_length = 3 },
                    { name = 'tags',          max_item_count = 5, priority = 1,      keyword_length = 3 },
                    { name = 'latex_symbols', max_item_count = 4 }
                },
                performance = {
                    debounce = 300,
                    throttle = 60,
                    fetching_timeout = 200,
                },
            }
            -- Set configuration for specific filetype.
            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'cmp_git' },
                }, {
                    { name = 'buffer' },
                })
            })

            cmp.setup.cmdline({ '/', '?' }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer', max_item_count = 10 }
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
        end
    },



}
