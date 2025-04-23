local function telescope_opts()
  local actions = require("telescope.actions")
  local open_with_trouble = require("trouble.sources.telescope").open
  local add_to_trouble = require("trouble.sources.telescope").add
  return {
    defaults = {
      -- Default configuration for telescope goes here:
      -- config_key = value,
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<c-t>"] = open_with_trouble,
          ["<c-a-t>"] = add_to_trouble,
          ["<C-q>"] = actions.smart_send_to_qflist,
          ["<M-q>"] = actions.nop,
        },
        n = {
          ["<c-t>"] = open_with_trouble,
          ["<c-a-t>"] = add_to_trouble,
          ["<C-q>"] = actions.smart_send_to_qflist,
          ["<M-q>"] = actions.nop,
        }
      },
      file_ignore_patterns = {
        "node_modules",
        ".git/",
      },
    },
    pickers = {
    },
    extensions = {
      frecency = {
        default_workspace = 'CWD',
        ignore_patterns = { "*.git/*", "*/tmp/*", "*.hg/*" }
      },
    }
  }
end

local prefix = "<leader>f"

local function keymaps()
  local function desc(d)
    return "Telescope: " .. d
  end
  local function cmd(c)
    return "<cmd>Telescope " .. c .. "<cr>"
  end
  local find_files_command = cmd('find_files hidden=true no_ignore=false')
  return {
    { prefix .. "f",  find_files_command,         desc = desc('Find Files') },
    { prefix .. "tt", cmd('current_buffer_tags'), desc = desc('Current Buffer Tags') },
    { prefix .. "ts", cmd('treesitter'),          desc = desc('Treesitter') },
    { prefix .. "tg", cmd('tags'),                desc = desc('Global Tags') },
    { prefix .. "l",  cmd('live_grep'),           desc = desc('Live Grep') },
    { prefix .. "b",  cmd('buffers'),             desc = desc('Buffers') },
    { prefix .. "h",  cmd('help_tags'),           desc = desc('Help Tags') },
    { prefix .. "m",  cmd('marks'),               desc = desc('Marks') },
    { prefix .. "y",  cmd('filetypes'),           desc = desc('Filetypes') },
    { prefix .. "p",  cmd('projects'),            desc = desc('Projects') },
    { prefix .. "r",  cmd('resume'),              desc = desc('Resume') },
    { prefix .. "o",  cmd('oldfiles'),            desc = desc('Recent Files') },
    { prefix .. "gb", cmd('git_branches'),        desc = desc('Git Branches') },
    { prefix .. "gc", cmd('git_bcommits'),        desc = desc('Git Commits (Buffer)') },
    { prefix .. "gs", cmd('git_stash'),           desc = desc("Git Stash") },
  }
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { 'nvim-lua/plenary.nvim', },
      { 'nvim-telescope/telescope-fzy-native.nvim' },
      { 'rcarriga/nvim-notify' },
      { 'folke/trouble.nvim' }
    },
    opts = telescope_opts(),
    keys = keymaps(),
    version = "*",
    config = function(_, opts)
      require("telescope").setup(opts)
      local wk = require("which-key")
      wk.add({ prefix, group = "telescope" })
      wk.add({ prefix .. "g", group = "git" })
      wk.add({ prefix .. "t", group = "tags" })
    end
  },

  {
    'ahmedkhalf/project.nvim',
    dependencies = { "nvim-telescope/telescope.nvim" },
    opts = {
      patterns = {
        ".git",
        "_darcs",
        ".hg",
        ".bzr",
        ".svn",
        "Makefile",
        "package.json",
        ".tex.latexmain",
        "justfile",
        "Justfile",
        "rebar.config",
        "mix.exs"
      },
      manual_mode = true,
      detection_methods = {
        "lsp", "pattern"
      }
    },
    config = function(_, opts)
      require("project_nvim").setup(opts)
      require("telescope").load_extension('projects')
    end,
    version = false
  },
  {
    'nvim-telescope/telescope-fzy-native.nvim',
    dependencies = { "telescope.nvim" },
    config = function(_, _)
      require('telescope').load_extension('fzy_native')
    end
  }
}
