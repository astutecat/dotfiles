return {
  {
    'monaqa/dial.nvim',
    event = "VeryLazy",
    opts = {},
    version = false,
    config = function()
      local augend = require("dial.augend")

      require("dial.config").augends:register_group {
        default = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y-%m-%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver
        },
      }

      require("dial.config").augends:on_filetype {
        markdown = {
          augend.integer.alias.decimal,
          augend.misc.alias.markdown_header,
          augend.date.alias["%Y-%m-%d"],
          augend.semver.alias.semver,
        },
        elixir = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.constant.alias.bool,
          augend.semver.alias.semver,
          augend.constant.new { elements = { "def", "defp" } },
        },
        erlang = {
          augend.integer.alias.decimal,
          augend.integer.alias.hex,
          augend.date.alias["%Y/%m/%d"],
          augend.date.alias["%Y-%m-%d"],
          augend.constant.alias.bool,
          augend.semver.alias.semver,
        },
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
    end
  }
}
