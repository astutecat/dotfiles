return {
  'mfussenegger/nvim-lint',
  config = function()
    local lint = require("lint")
    lint.linters_by_ft = {
      lua = { 'luacheck', 'selene' },
      yaml = { 'yamllint' },
      python = { 'pylint' }
    }
    vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
      callback = function()
        lint.try_lint(nil, { ignore_errors = true })
      end,
    })
  end
}
