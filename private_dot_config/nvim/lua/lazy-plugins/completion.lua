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

  completion = {
    keyword = { range = "full" },
    menu = {
      auto_show = true,
      draw = {
        components = {
          label = {
            text = function(ctx)
              -- Fix for weird rendering in ElixirLS structs/behaviours etc
              -- structs, behaviours and others have a label_detail emitted
              -- by ElixirLS, and it looks bad when there's no space between
              -- the module label and the label_detail.
              --
              -- The label_detail has no space because it is normally meant
              -- for function signatures, e.g. `my_function(arg1, arg2)` -
              -- this case the label is `my_function` and the label_detail
              -- is `(arg1, arg2)`.
              --
              -- In an ideal world ElixirLS would not emit them for these
              -- types - these belong in `kind` only.
              if ctx.item.client_name == 'ElixirLS' and ctx.kind ~= 'Function' and ctx.kind ~= 'Macro' then
                return ctx.label
              end

              return ctx.label .. ctx.label_detail
            end,
          },
        },
        columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'source_id' } },
      },
    },
    -- Show documentation when selecting a completion item
    documentation = { auto_show = true, auto_show_delay_ms = 700 },

    -- Display a preview of the selected item on the current line
    ghost_text = { enabled = false },
  },

  -- Default list of enabled providers defined so that you can extend it
  -- elsewhere in your config, without redefining it, due to `opts_extend`
  sources = {
    -- default = { 'git', 'lsp', 'path', 'snippets', 'buffer' },
    default = function(_)
      local success, node = pcall(vim.treesitter.get_node)
      if success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
        return { 'buffer' }
      elseif vim.bo.filetype == 'lua' then
        return { 'lsp', 'path' }
      else
        return { 'lsp', 'snippets', 'path', 'buffer', 'git' }
      end
    end,
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
