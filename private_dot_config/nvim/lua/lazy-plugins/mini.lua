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
  local prefix = "<leader>m"
  local d_prefix = "MiniMap: "
  local mappings = {
    {
      prefix .. "c",
      "<cmd>lua MiniMap.close()<cr>",
      description = d_prefix .. "Close",
    },
    {
      prefix .. "f",
      "<cmd>lua MiniMap.toggle_focus()<cr>",
      description = d_prefix .. "Toggle Focus",
    },
    {
      prefix .. "o",
      "<cmd>lua MiniMap.open()<cr>",
      description = d_prefix .. "Open",
    },
    {
      prefix .. "r",
      "<cmd>lua MiniMap.refresh()<cr>",
      description = d_prefix .. "Refresh",
    },
    {
      prefix .. "s",
      "<cmd>lua MiniMap.toggle_side()<cr>",
      description = d_prefix .. "Toggle Side",
    },
    {
      prefix .. "t",
      "<cmd>lua MiniMap.toggle()<cr>",
      description = d_prefix .. "Toggle",
    },
  }

  require("legendary").keymaps(mappings)
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
  local mappings = {
    {
      "<leader>s",
      description = "Toggle split to multiple lines",
    },
  }
  require("legendary").keymaps(mappings)

  return {
    mappings = {
      toggle = "<leader>s",
      split = "",
      join = "",
    },
  }
end

local function files_config()
  local mappings = {
    {
      "<leader>em",
      "<cmd>lua MiniFiles.open()<cr>",
      description = "mini.nvim: open files.",
    },
  }
  require("legendary").keymaps(mappings)
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
      { action = "Legendary",            name = "Command pallete", section = "Quick Actions" },
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

local function cursorword_config()
  return {
    delay = 200,
  }
end

local function post_config()
  vim.cmd([[
  :hi clear MiniCursorword
  :hi MiniCursorword gui=bold cterm=bold
  :hi! MiniCursorwordCurrent guifg=NONE guibg=NONE gui=NONE cterm=NONE
  ]])
end

return {
  {
    "echasnovski/mini.nvim",
    version = "*",
    config = function(_, _)
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
      require("mini.cursorword").setup(cursorword_config())
      require("mini.starter").setup(starter_config())
      require("mini.move").setup()
      require("mini.map").setup(minimap_config())
      require("mini.files").setup()
      files_config()
      post_config()
    end,
  },
}
