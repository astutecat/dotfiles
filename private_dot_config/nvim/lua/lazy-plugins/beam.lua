local on_d9 = require("config_flags").on_d9

return {
    -- {
    --     'vim-erlang/vim-erlang-runtime',
    --     cond = on_d9,
    -- },
    {
        "elixir-tools/elixir-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {},
        cond = not on_d9
    }
}
