vim.cmd([[
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath = &runtimepath
  source ~/.vim/vimrc
]])

local hotpot_path = vim.fn.stdpath('config') .. '/pack/plugin/start/hotpot.nvim'

if vim.fn.empty(vim.fn.glob(hotpot_path .. '/plugin')) > 0 then
  print('warn: missing submodules')
  return
end

require('hotpot')
require('userspace')
