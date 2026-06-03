local flags = require("config_flags")

local mappings = {}

if flags.work_config then
  mappings = {
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

return {
  "rgroli/other.nvim",
  opts = {
    mappings = mappings,
  },
  keys = {
    "<Leader>o",
    "<cmd>Other",
    desc = "Open Other",
  },
}
