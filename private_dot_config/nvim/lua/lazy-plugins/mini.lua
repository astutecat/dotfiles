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

local function starter_config()
  local header_content = require("headers.neovim")
  local is_work_config = require("config_flags").work_config
  if is_work_config then
    header_content = require("headers.entelios")
  end
  return {
    header = table.concat(header_content, "\n")
  }
end

local function session_config()
  local commands = {
    {
      ':SessionSave <CR>',
      function(input)
        if input.fargs and input.fargs[1] then
          require("mini.sessions").write(input.fargs[1])
        end
      end,
      description = 'Save (name) session.',
      unfinished = true,
      opts = { nargs = '?' },
    }
  }
  require("legendary").commands(commands)
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
      require('mini.sessions').setup()
      session_config()
      require('mini.ai').setup()
      require('mini.align').setup()
      require('mini.splitjoin').setup(splitjoin_config())
      require('mini.cursorword').setup()
      require('mini.starter').setup(starter_config())
    end
  }
}
