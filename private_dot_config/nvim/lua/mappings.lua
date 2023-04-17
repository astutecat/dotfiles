vim.cmd([[
  nnoremap <leader>zz :let &scrolloff=25-&scrolloff<CR><cmd>echo "Scrolloff is now: ".&scrolloff<CR>
  nnoremap <Leader>0 :cd ~/repos/dotfiles<CR>
]])

if require("config_flags").work_config then
vim.cmd([[
  nnoremap <Leader>` :e ~/dev/useful-commands.erl<CR>
  nnoremap <Leader>1 :cd ~/repos/RTS<CR>
  nnoremap <Leader>2 :cd ~/repos/sentinel<CR>
  nnoremap <Leader>3 :cd ~/repos/Zebra<CR>
]])
end

