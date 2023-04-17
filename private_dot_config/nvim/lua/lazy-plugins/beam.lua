local on_d9 = require("config_flags").on_d9

if on_d9 then
    return {
        'vim-erlang/vim-erlang-runtime'
    }
else
    return {
        "elixir-tools/elixir-tools.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        opts = {}
    }
end
