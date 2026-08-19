vim.cmd([[
  nnoremap <leader>zz :let &scrolloff=25-&scrolloff<CR><cmd>echo "Scrolloff is now: ".&scrolloff<CR>
]])

if require("config_flags").work_config then
  vim.cmd([[
  nnoremap <Leader>` :e ~/dev/useful-commands.erl<CR>
]])
end
