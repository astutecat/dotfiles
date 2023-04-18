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
      ".git",
      ".hg"
    },
  },

  pickers = {
  },

  extensions = {
    frecency = {
      default_workspace = 'CWD',
      ignore_patterns = {"*.git/*", "*/tmp/*", "*.hg/*"}
    },
  }
}
