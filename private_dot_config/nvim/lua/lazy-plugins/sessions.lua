local Path = require('plenary.path')
return {
  {
    'Shatur/neovim-session-manager',
    event = "VeryLazy",
    dependencies = {
      { 'nvim-lua/plenary.nvim', },
    },
    opts = function()
      return {
        sessions_dir = Path:new(vim.fn.stdpath('data'), 'sessions'),             -- The directory where the session files will be saved.
        path_replacer = '__',                                                    -- The character to which the path separator will be replaced for session files.
        colon_replacer = '++',                                                   -- The character to which the colon symbol will be replaced for session files.
        autoload_mode = require('session_manager.config').AutoloadMode.Disabled, -- Define what to do when Neovim is started without arguments. Possible values: Disabled, CurrentDir, LastSession
        autosave_last_session = true,                                            -- Automatically save last session on exit and on session switch.
        autosave_ignore_not_normal = true,                                       -- Plugin will not save a session when no buffers are opened, or all of them aren't writable or listed.
        autosave_ignore_dirs = {},                                               -- A list of directories where the session will not be autosaved.
        autosave_ignore_filetypes = {                                            -- All buffers of these file types will be closed before the session is saved.
          'gitcommit',
        },
        autosave_ignore_buftypes = {},    -- All buffers of these bufer types will be closed before the session is saved.
        autosave_only_in_session = false, -- Always autosaves session. If true, only autosaves after a session is active.
        max_path_length = 80,             -- Shorten the display path if length exceeds this threshold. Use 0 if don't want to shorten the path at all.
      }
    end,
    config = function(_, opts)
      require("session_manager").setup(opts)

      local prefix = ':SessionManager '
      local d_pre = ""
      local commands = {
        { ":SessionLoad",     prefix .. 'load_session',      description = d_pre .. 'Load Session', },
        { ":SessionLoadLast", prefix .. 'load_last_session', description = d_pre .. 'Load Last Session', },
        { ":SessionLoadDir", prefix .. 'load_current_dir_session', description = d_pre .. 'Load Curr. Dir Session', },
        { ":SessionSave",   prefix .. 'save_session',   description = d_pre .. 'Save Session', },
        { ":SessionDelete", prefix .. 'delete_session', description = d_pre .. 'Delete Session', },
      }
      require("legendary").commands(commands)

      vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
        callback = function()
          if vim.bo.filetype ~= 'git'
              and not vim.bo.filetype ~= 'gitcommit'
          then
            require("session_manager").autosave_session()
          end
        end
      })
    end
  }
}
