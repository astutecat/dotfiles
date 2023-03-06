vim.g.nclipper_nomap = 1

local opts = { noremap=true }

local mappings = {
    {
        '<M-y>',
        '<Plug>(nclipper)',
        description = "NClipper: Context Copy (No Filename)",
        mode = { 'v' },
        opts = opts
    },
    {
        '<C-y>',
        '<Plug>(nclipper)',
        description = "NClipper: Context Copy",
        mode = { 'v' },
        opts = opts
    },
}
require('legendary').keymaps(mappings)
