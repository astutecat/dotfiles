local git_prefix = "<leader>g"
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
  end,
  update_debounce = 100,
  attach_to_untracked = false,
}

local gitsigns_cmd = function(cmd) return ":Gitsigns " .. cmd .. "<cr>" end
local desc = function(suffix) return "Git: " .. suffix end

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
    lazy = false,
    keys = {
      {
        git_prefix .. "hs",
        gitsigns_cmd("stage_hunk"),
        desc("stage hunk"),
        mode = { "n", "v" }
      },
      {
        git_prefix .. "hr",
        gitsigns_cmd("reset_hunk"),
        desc("reset hunt")
      },
      {
        "ih",
        ":<C-U>Gitsigns select_hunk<cr>",
        desc("hunk"),
        mode = { "o", "x" }
      },
      {
        git_prefix .. "hS",
        gitsigns_cmd("stage_buffer"),
        desc("stage buffer")
      },
      {
        git_prefix .. "hu",
        gitsigns_cmd("undo_stage_hunk"),
        desc("undo stage hunk")
      },
      {
        git_prefix .. "hR",
        gitsigns_cmd("reset_buffer"),
        desc("reset buffer")
      },
      {
        git_prefix .. "hp",
        gitsigns_cmd("preview_hunk"),
        desc("preview hunk")
      },
      {
        git_prefix .. "l",
        gitsigns_cmd("toggle_current_line_blame"),
        desc("toggle current line blame")
      },
      {
        git_prefix .. "hd",
        gitsigns_cmd("diffthis"),
        desc("diff this")
      },
      {
        git_prefix .. "td",
        gitsigns_cmd("toggle_deleted"),
        desc("toggle deleted")
      },
    }
  },
  {
    "FabijanZulj/blame.nvim",
    lazy = false,
    config = function()
      require('blame').setup {}
      local wk = require("which-key")
      wk.add({ git_prefix, group = "git" })
    end,
    keys = {
      {
        git_prefix .. "b",
        ":BlameToggle virtual<cr>",
        desc = desc("blame"),
      },
    },
  }
}
