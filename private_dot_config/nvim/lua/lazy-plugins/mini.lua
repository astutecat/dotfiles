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
      animation = require('mini.indentscope').gen_animation.none()
    }
  }
end

local function trailspace_mappings()
  local mappings = {
    {
      "<leader>/",
      '<cmd>lua MiniTrailspace.trim()<cr>',
      description = "Trim trailing whitespace"
    },
  }
  require('legendary').keymaps(mappings)
end

local function splitjoin_config()
  local mappings = {
    {
      '<leader>s',
      description = "Toggle split to multiple lines",
    },
  }
  require('legendary').keymaps(mappings)

  return {
    mappings = {
      toggle = '<leader>s',
      split = '',
      join = '',
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
  local starter = require('mini.starter')
  return {
    header = function()
      return get_header()
    end,
    footer = "",
    items = {
      starter.sections.sessions(5, true),
      starter.sections.recent_files(8, true, false),
      { action = 'Telescope find_files', name = 'Find file',       section = 'Quick Actions' },
      { action = 'Legendary',            name = 'Command pallete', section = 'Quick Actions' },
      { action = 'Lazy',                 name = 'Lazy',            section = 'Quick Actions' },
      { action = 'Mason',                name = 'Mason',           section = 'Quick Actions' },
      { action = 'qa',                   name = 'Quit',            section = 'Quick Actions' },
    }
  }
end

local function session_config()
  local commands = {
    {
      ':SessionSave {name}',
      function(input)
        if input.fargs and input.fargs[1] then
          require("mini.sessions").write(input.fargs[1])
        else
          local cwd = vim.fn.getcwd()
          cwd = string.gsub(cwd, "/", "__")
          require("mini.sessions").write(cwd)
        end
      end,
      description = 'Session: Save (custom name).',
      unfinished = true,
      opts = { nargs = '?' },
    },
    {
      ':SessionSave',
      function()
        local cwd = vim.fn.getcwd()
        cwd = string.gsub(cwd, "/", "__")
        require("mini.sessions").write(cwd)
      end,
      description = 'Session: Save.'
    },
    {
      ':SessionDelete',
      function()
        require("mini.sessions").delete(nil, { force = true })
      end,
      description = 'Session: Delete current.'
    },
    {
      ':SessionRename {name}',
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
      description = 'Session: Rename current.'
    },

  }
  require("legendary").commands(commands)

  return {
    directory = vim.fn.stdpath('data') .. "/sessions",
    autowrite = true
  }
end

local function cursorword_config()
  return {
    delay = 200
  }
end

local function post_config()
  vim.cmd [[
  :hi clear MiniCursorword
  :hi MiniCursorword gui=bold cterm=bold
  :hi! MiniCursorwordCurrent guifg=NONE guibg=NONE gui=NONE cterm=NONE
  ]]
end

return {
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function(_, _)
      require('mini.comment').setup()
      require("mini.indentscope").setup(indent_scope_opts())
      require('mini.pairs').setup()
      require('mini.trailspace').setup()
      trailspace_mappings()
      require('mini.surround').setup()
      require('mini.bracketed').setup()
      require('mini.sessions').setup(session_config())
      require('mini.ai').setup()
      require('mini.align').setup()
      require('mini.splitjoin').setup(splitjoin_config())
      require('mini.cursorword').setup(cursorword_config())
      require('mini.starter').setup(starter_config())
      post_config()
    end
  }
}
