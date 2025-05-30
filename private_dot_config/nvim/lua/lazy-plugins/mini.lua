local function indent_scope_opts()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = require("lazy-plugins.opts.coding-shared").no_indent_filetypes,
    callback = function()
      vim.b.miniindentscope_disable = true
    end,
  })

  return {
    symbol = "│",
    options = { try_as_border = true },
    draw = {
      animation = require("mini.indentscope").gen_animation.none(),
    },
  }
end

local function trailspace_mappings()
  local mappings = {
    {
      "<leader>/",
      "<cmd>lua MiniTrailspace.trim()<cr>",
      description = "Trim trailing whitespace",
    },
  }
  require("legendary").keymaps(mappings)
end

local function minimap_config()
  local map = require("mini.map")

  return {
    integrations = {
      map.gen_integration.builtin_search(),
      map.gen_integration.gitsigns(),
      map.gen_integration.diagnostic(),
    },
    window = { show_integration_count = false },
    symbols = {
      encode = map.gen_encode_symbols.dot("4x2"),
    },
  }
end

local function splitjoin_config()
  return {
    mappings = {
      toggle = "<leader>s",
      split = "",
      join = "",
    },
  }
end

local function get_header()
  local is_work_config = require("config_flags").work_config
  if is_work_config then
    return require("headers.entelios")
  end
  return require("headers.neovim")
end

local function starter_config()
  local starter = require("mini.starter")
  return {
    header = function()
      return get_header()
    end,
    footer = require("random-quote"),
    items = {
      starter.sections.sessions(4, true),
      starter.sections.recent_files(6, true, false),
      { action = "Telescope find_files", name = "Find file",       section = "Quick Actions" },
      { action = "Telescope projects",   name = "Recent Projects", section = "Quick Actions" },
      { action = "Legendary",            name = "Command palette", section = "Quick Actions" },
      { action = "Mason",                name = "Mason",           section = "Quick Actions" },
      { action = "Lazy",                 name = "Lazy",            section = "Quick Actions" },
    },
  }
end

local function session_config()
  local commands = {
    {
      ":SessionSave {name}",
      function(input)
        if input.fargs and input.fargs[1] then
          local trimmed = string.gsub(input.fargs[1], "^%s*(.-)%s*$", "%1")
          require("mini.sessions").write(trimmed)
        else
          require("mini.sessions").write(nil)
        end
      end,
      description = "Session: Save (custom name).",
      unfinished = true,
      opts = { nargs = "?" },
    },
    {
      ":SessionDelete [name]",
      function(input)
        if input.fargs and input.fargs[1] then
          local trimmed = string.gsub(input.fargs[1], "^%s*(.-)%s*$", "%1")
          require("mini.sessions").delete(trimmed, { force = true })
        else
          require("mini.sessions").delete(nil, { force = true })
        end
      end,
      description = "Session: Delete (name).",
      unfinished = true,
      opts = { nargs = "?" },
    },
    {
      ":SessionRename {name}",
      function(input)
        require("mini.sessions").delete(nil, { force = true })

        if input.fargs and input.fargs[1] then
          require("mini.sessions").write(input.fargs[1])
        else
          local cwd = vim.fn.getcwd()
          cwd = string.gsub(cwd, "/", "__")
          require("mini.sessions").write(cwd)
        end
      end,
      description = "Session: Rename.",
      unfinished = true,
      opts = { nargs = "?" },
    },
  }
  require("legendary").commands(commands)

  return {
    directory = vim.fn.stdpath("data") .. "/sessions",
    autowrite = true,
    hooks = {
      pre = {
        write = function()
          vim.cmd([[:Neotree close]])
        end,
      },
    },
  }
end

local minimap_prefix = "<leader>m"
local minimap_d_prefix = "MiniMap: "

return {
  {
    "echasnovski/mini.nvim",
    version = "*",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function(_, _)
      require("mini.icons").setup()
      require("mini.icons").mock_nvim_web_devicons()
      require("mini.comment").setup()
      require("mini.indentscope").setup(indent_scope_opts())
      require("mini.pairs").setup()
      require("mini.trailspace").setup()
      trailspace_mappings()
      require("mini.surround").setup()
      require("mini.bracketed").setup()
      require("mini.sessions").setup(session_config())
      require("mini.ai").setup()
      require("mini.align").setup()
      require("mini.splitjoin").setup(splitjoin_config())
      require("mini.starter").setup(starter_config())
      require("mini.move").setup()
      require("mini.map").setup(minimap_config())
      require("mini.files").setup()
    end,
    keys = {
      { "<leader>s",  desc = "Toggle split to multiple lines" },
      { "<leader>em", "<cmd>lua MiniFiles.open()<cr>",        desc = "mini.nvim: open files." },
      {
        minimap_prefix .. "c",
        "<cmd>lua MiniMap.close()<cr>",
        desc = minimap_d_prefix .. "Close",
      },
      {
        minimap_prefix .. "f",
        "<cmd>lua MiniMap.toggle_focus()<cr>",
        desc = minimap_d_prefix .. "Toggle Focus",
      },
      {
        minimap_prefix .. "o",
        "<cmd>lua MiniMap.open()<cr>",
        desc = minimap_d_prefix .. "Open",
      },
      {
        minimap_prefix .. "r",
        "<cmd>lua MiniMap.refresh()<cr>",
        desc = minimap_d_prefix .. "Refresh",
      },
      {
        minimap_prefix .. "s",
        "<cmd>lua MiniMap.toggle_side()<cr>",
        desc = minimap_d_prefix .. "Toggle Side",
      },
      {
        minimap_prefix .. "t",
        "<cmd>lua MiniMap.toggle()<cr>",
        desc = minimap_d_prefix .. "Toggle",
      },
    }
  },
}
