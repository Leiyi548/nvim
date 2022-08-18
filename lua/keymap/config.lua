-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT
-- recommend some vim mode key defines in this file

local keymap = require('core.keymap')
---@diagnostic disable-next-line: unused-local
local nmap, imap, cmap, xmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.xmap
---@diagnostic disable-next-line: unused-local
local silent, noremap = keymap.silent, keymap.noremap
local opts = keymap.new_opts
local cmd = keymap.cmd

-- Use space as leader key
vim.g.mapleader = ' '

-- leaderkey
nmap({ ' ', '', opts(noremap) })
xmap({ ' ', '', opts(noremap) })

-- usage example
nmap({
  -- noremal remap
  -- close buffer
  -- { 'x', cmd('bdelete!'), opts(noremap, silent) },
  { '<C-s>', cmd('write'), opts(noremap) },
  -- yank
  { 'Y', 'y$', opts(noremap) },
  { '<leader>y', '"+y', opts(noremap) },
  { '<leader>p', '"+p', opts(noremap) },
  { '<leader>P', '"+P', opts(noremap) },
  -- I hate click this key
  { 'H', '^', opts(noremap) },
  { 'L', '$', opts(noremap) },
  { '<', '<<', opts(noremap) },
  { '>', '>>', opts(noremap) },
  -- buffer jump
  { '[[', cmd('bp'), opts(noremap) },
  { ']]', cmd('bn'), opts(noremap) },
  -- window jump
  { '<C-h>', '<C-w>h', opts(noremap) },
  { '<C-l>', '<C-w>l', opts(noremap) },
  { '<C-j>', '<C-w>j', opts(noremap) },
  { '<C-k>', '<C-w>k', opts(noremap) },
  -- split windows
  -- { 'sv', cmd('vsplit'), opts(noremap) },
  -- { 'sg', cmd('split'), opts(noremap) },
  -- { 'sc', '<C-w>c', opts(noremap) },
  -- like vscode move line
  { '<M-Up>', ':m .-2<CR>==', opts(noremap) },
  { '<M-Down>', ':m .+1<CR>==', opts(noremap) },
})

xmap({
  -- I hate click this key
  { '<', '<gv', opts(noremap) },
  { '>', '>gv', opts(noremap) },
  { 'H', '^', opts(noremap) },
  { 'L', '$', opts(noremap) },
  -- move line like vscode
  -- { 'J', ":move '>+1<CR>gv-gv", opts(noremap) },
  -- { 'K', ":move '<-2<CR>gv-gv", opts(noremap) },
  { '<M-Up>', ':m .-2<CR>==', opts(noremap) },
  { '<M-Down>', ':m .+1<CR>==', opts(noremap) },
  -- yank
  { '<leader>y', '"+y', opts(noremap) },
  { '<leader>p', '"+p', opts(noremap) },
  { '<leader>P', '"+P', opts(noremap) },
})

imap({
  -- insert mode
  { '<C-s>', cmd('write'), opts(noremap) },
  { '<M-Up>', '<Esc>:m .-2<CR>==gi', opts(noremap) },
  { '<M-Down>', '<Esc>:m .+1<CR>==gi', opts(noremap) },
})

-- commandline remap
-- cmap({ '<C-b>', '<Left>', opts(noremap) })
