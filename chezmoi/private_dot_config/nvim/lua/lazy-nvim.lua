local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local opts = {
  install = {
  },
  defaults = {
  },
  checker = {
    -- automatically check for plugin updates
    enabled = true,
    concurrency = vim.loop.available_parallelism() * 2, ---@type number? set to 1 to check for updates very slowly
    notify = false,   -- get a notification when new updates are found
    frequency = 3600, -- check for updates every hour
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = true,
    notify = false, -- get a notification when changes are found
  },
  debug = false
}

require("lazy").setup("lazy-plugins", opts)
