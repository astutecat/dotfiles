local function telescope_opts()
  local actions = require("telescope.actions")
  return {
    defaults = {
      -- Default configuration for telescope goes here:
      -- config_key = value,
      mappings = {
        i = {
          ["<esc>"] = actions.close
        },
      },
      file_ignore_patterns = {
        "node_modules",
        "\\.git",
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

local function keymaps()
  local function desc(d)
    return "Telescope: " .. d
  end
  local function cmd(c)
    return "<cmd>Telescope " .. c .. "<cr>"
  end
  local find_files_command = cmd('find_files hidden=true no_ignore=false')
  return {
    { "<leader>ff",  find_files_command,         desc = desc('Find Files') },
    { "<leader>ftt", cmd('current_buffer_tags'), desc = desc('Current Buffer Tags') },
    { "<leader>fts", cmd('treesitter'),          desc = desc('Treesitter') },
    { "<leader>ftg", cmd('tags'),                desc = desc('Global Tags') },
    { "<leader>fb",  cmd('buffers'),             desc = desc('Buffers') },
    { "<leader>fh",  cmd('help_tags'),           desc = desc('Help Tags') },
    { "<leader>fm",  cmd('marks'),               desc = desc('Marks') },
    { "<leader>fy",  cmd('filetypes'),           desc = desc('Filetypes') },
    { "<leader>fp",  cmd('projects'),            desc = desc('Projects') },
    { "<leader>fr",  cmd('resume'),              desc = desc('Resume') },
    { "<leader>fo",  cmd('oldfiles'),            desc = desc('Recent Files') },
    { "<leader>fgb", cmd('git_branches'),        desc = desc('Git Branches') },
    { "<leader>fgc", cmd('git_bcommits'),        desc = desc('Git Commits (Buffer)') },
    { "<leader>fgs", cmd('git_stash'),           desc = desc("Git Stash") },
  }
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { 'nvim-lua/plenary.nvim', },
      { 'nvim-telescope/telescope-fzy-native.nvim' },
      { 'rcarriga/nvim-notify' }

    },
    opts = telescope_opts(),
    keys = keymaps(),
    version = "*"
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
