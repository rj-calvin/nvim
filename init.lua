vim.cmd([[
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath = &runtimepath
  source ~/.vim/vimrc
]])

local hotpot_path = vim.fn.stdpath('config') .. '/pack/plugin/start/hotpot.nvim'

if vim.fn.empty(vim.fn.glob(hotpot_path)) > 0 then
  print('fetching submodules...')
  vim.fn.system({ 'git', 'pull', '--recurse-submodules', '--rebase' })
  vim.cmd('helptags ' .. hotpot_path .. '/doc')
end

require('hotpot')
require('userspace')
