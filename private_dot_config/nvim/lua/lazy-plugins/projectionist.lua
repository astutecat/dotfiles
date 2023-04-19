return {
    {
        'tpope/vim-projectionist',
        init = function()
            local heuristics = {}

            heuristics["lib/*.ex"] = {
                alternate = "test/{}_test.exs",
                type = "source",
                template = {
                    "defmodule {camelcase|capitalize|dot} do",
                    "end"
                }
            }

            heuristics["test/*_test.exs"] = {
                alternate = "lib/{}.ex",
                type = "test",
                template = {
                    "defmodule {camelcase|capitalize|dot}Test do",
                    "  use ExUnit.Case, async: true",
                    "",
                    "  alias {camelcase|capitalize|dot}",
                    "end"
                }
            }
            vim.g.projectionist_heuristics = heuristics
        end,
        event = "VeryLazy"
    },
}
