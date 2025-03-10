local gitsigns_config = {
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map("n", "]c", function()
      if vim.wo.diff then
        return "]c"
      end
      vim.schedule(function()
        gs.next_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    map("n", "[c", function()
      if vim.wo.diff then
        return "[c"
      end
      vim.schedule(function()
        gs.prev_hunk()
      end)
      return "<Ignore>"
    end, { expr = true })

    --TODO: Refactor this to use legendary.nvim

    -- Actions
    map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>")
    map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>")
    map("n", "<leader>hS", ":Gitsigns stage_buffer<cr>")
    map("n", "<leader>hu", ":Gitsigns undo_stage_hunk<cr>")
    map("n", "<leader>hR", ":Gitsigns reset_buffer<cr>")
    map("n", "<leader>hp", ":Gitsigns preview_hunk<cr>")
    map("n", "<leader>tb", ":Gitsigns toggle_current_line_blame<cr>")
    map("n", "<leader>hd", ":Gitsigns diffthis<cr>")
    map("n", "<leader>td", ":Gitsigns toggle_deleted<cr>")

    -- Text object
    map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
  end,
  update_debounce = 100,
  attach_to_untracked = false,
}

return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
      -- Only one of these is needed.
      "nvim-telescope/telescope.nvim", -- optional
    },
    config = true,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = gitsigns_config,
  },

  {
    "FabijanZulj/blame.nvim",
    opts = {},
  },
}
