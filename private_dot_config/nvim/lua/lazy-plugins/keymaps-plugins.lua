return {
    {
        'folke/which-key.nvim',
        opts = {}
    },
    {
        'mrjones2014/legendary.nvim',
        dependencies = {
            'kkharji/sqlite.lua',
            'nvim-telescope/telescope.nvim',
            'folke/which-key.nvim',
        },
        opts = require('lazy-plugins.opts.legendary-nvim')
    }
}
