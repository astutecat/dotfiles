local augend = require("dial.augend")

require("dial.config").augends:register_group{
    default = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%Y-%m-%d"],
        augend.date.alias["%m/%d"],
        augend.date.alias["%H:%M"],
        augend.constant.alias.bool,
        augend.semver.alias.semver,
    },
    elixir = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%Y-%m-%d"],
        augend.date.alias["%m/%d"],
        augend.date.alias["%H:%M"],
        augend.constant.alias.bool,
        augend.semver.alias.semver,
        augend.constant.new{ elements = {",", ".", ";"} },
        augend.constant.new{ elements = {"def", "defp"} },
    },
    erlang = {
        augend.integer.alias.decimal,
        augend.integer.alias.hex,
        augend.date.alias["%Y/%m/%d"],
        augend.date.alias["%Y-%m-%d"],
        augend.date.alias["%m/%d"],
        augend.date.alias["%H:%M"],
        augend.constant.alias.bool,
        augend.semver.alias.semver,
        augend.constant.new{ elements = {",", ".", ";"} },
    }

}

local mappings = {
       {
        "<C-a>",
        "<Plug>(dial-increment)",
        mode = { 'n', 'v' },
        description = "Increment"
    },
    {
        "<C-x>",
        '<Plug>(dial-decrement)',
        mode = { 'n', 'v' },
        description = "Decrement"
    },
    {
        "g<C-a>",
        "g<Plug>(dial-increment)",
        mode = { 'n', 'v' },
        description = "Increment (g)"
    },
    {
        "g<C-x>",
        'g<Plug>(dial-decrement)',
        mode = { 'n', 'v' },
        description = "Decrement (g)"
    },
}

require('legendary').keymaps(mappings)
vim.cmd[[
autocmd FileType elixir lua vim.api.nvim_buf_set_keymap(0, "n", "<C-a>", require("dial.map").inc_normal("elixir"), {noremap = true})
autocmd FileType elixir lua vim.api.nvim_buf_set_keymap(0, "n", "<C-x>", require("dial.map").dec_normal("elixir"), {noremap = true})
autocmd FileType erlang lua vim.api.nvim_buf_set_keymap(0, "n", "<C-a>", require("dial.map").inc_normal("erlang"), {noremap = true})
autocmd FileType erlang lua vim.api.nvim_buf_set_keymap(0, "n", "<C-x>", require("dial.map").dec_normal("erlang"), {noremap = true})
]]

