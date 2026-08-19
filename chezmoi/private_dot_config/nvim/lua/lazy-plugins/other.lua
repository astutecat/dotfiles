local flags = require("config_flags")
local e = require("startup_events")
local custom_mappings = {}

if flags.work_config then
  custom_mappings = {
    {
      pattern = "src/(.*).erl$",
      target = "test/%1_SUITE.erl",
      context = "ct test file",
    },
    {
      pattern = "test/(.*)_SUITE.erl$",
      target = "src/%1.erl",
      context = "implementation file",
    },
    {
      pattern = "src/(.*).erl$",
      target = "test/_eunit/%1_tests.erl",
      context = "eunit test file",
    },
    {
      pattern = "test/_eunit/(.*)_tests.erl$",
      target = "src/%1.erl",
      context = "implementation file",
    },
  }
end

local commands = {
  { ":Other", description = "Other: open other file picker" },
  { ":OtherSplit", description = "Other: open other file in a split" },
  { ":OtherVSplit", description = "Other: open other file in a vertical split" },
}

return {
  "rgroli/other.nvim",
  keys = {
    { "<leader>o", "<cmd>Other<cr>", desc = "Other", silent = true },
  },
  event = e.vl,
  init = function()
    require("legendary").commands(commands)
    require("other-nvim").setup({
      mappings = {
        "livewire",
        "angular",
        "laravel",
        "rails",
        "golang",
        "python",
        "react",
        "rust",
        "elixir",
        "clojure",
        custom_mappings,
      },
    })
  end,
}
