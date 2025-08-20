local blink_opts = {
  -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
  -- 'super-tab' for mappings similar to vscode (tab to accept)
  -- 'enter' for enter to accept
  -- 'none' for no mappings
  --
  -- All presets have the following mappings:
  -- C-space: Open menu or open docs if already open
  -- C-n/C-p or Up/Down: Select next/previous item
  -- C-e: Hide menu
  -- C-k: Toggle signature help (if signature.enabled = true)
  --
  -- See :h blink-cmp-config-keymap for defining your own keymap
  keymap = { preset = 'default' },

  appearance = {
    -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
    -- Adjusts spacing to ensure icons are aligned
    nerd_font_variant = 'normal'
  },

  -- (Default) Only show the documentation popup when manually triggered
  completion = {
    keyword = { range = "full" },
    menu = {
      auto_show = false,
      -- draw = {
      --   columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'source_id' } },
      -- },
      draw = {
        -- We don't need label_description now because label and label_description are already
        -- combined together in label by colorful-menu.nvim.
        columns = { { "kind_icon" }, { "label", gap = 1 }, { 'source_id' } },
        components = {
          label = {
            text = function(ctx)
              return require("colorful-menu").blink_components_text(ctx)
            end,
            highlight = function(ctx)
              return require("colorful-menu").blink_components_highlight(ctx)
            end,
          },
        },
      },
    },
    -- Show documentation when selecting a completion item
    documentation = { auto_show = true, auto_show_delay_ms = 500 },

    -- Display a preview of the selected item on the current line
    ghost_text = { enabled = true },
  },

  -- Default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, due to `opts_extend`
  sources = {
    default = { 'git', 'lsp', 'path', 'snippets', 'buffer' },
    providers = {
      git = {
        module = 'blink-cmp-git',
        name = 'Git',
        enabled = function()
          return vim.tbl_contains({ 'octo', 'gitcommit', 'markdown' }, vim.bo.filetype)
        end,
        opts = {},
      },
    },
  },

  fuzzy = {
    implementation = "prefer_rust",
    sorts = {
      'exact',
      -- defaults
      'score',
      'sort_text',
    },
  },


}

return {
  {
    'saghen/blink.cmp',
    dependencies = {
      -- 'rafamadriz/friendly-snippets',
      'Kaiser-Yang/blink-cmp-git',
      "xzbdmw/colorful-menu.nvim",
    },
    version = '1.*',
    opts = blink_opts,
    opts_extend = { "sources.default" }
  }
}
