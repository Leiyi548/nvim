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
local expr = keymap.expr

-- Use space as leader key
vim.g.mapleader = ' '

-- leaderkey
nmap({ ' ', '', opts(noremap) })
xmap({ ' ', '', opts(noremap) })

-- usage example
nmap({
  -- noremal remap
  { '<C-s>', cmd('write'), opts(noremap) },

  -- yank paste
  { 'Y', 'y$', opts(noremap) },

  -- I hate click this key
  { 'H', '^', opts(noremap) },
  { 'L', '$', opts(noremap) },
  { '<', '<<', opts(noremap) },
  { '>', '>>', opts(noremap) },

  -- buffer jump
  { ']b', cmd('bn'), opts(noremap) },
  { '[b', cmd('bp'), opts(noremap) },

  -- window jump
  { '<C-h>', '<C-w>h', opts(noremap) },
  { '<C-l>', '<C-w>l', opts(noremap) },
  { '<C-j>', '<C-w>j', opts(noremap) },
  { '<C-k>', '<C-w>k', opts(noremap) },

  -- spliw window
  { 'sg', cmd('split'), opts(noremap) },
  { 'sv', cmd('vsplit'), opts(noremap) },

  -- close window
  { 'sc', cmd('close'), opts(noremap) },

  -- resize window
  { '<M-[>', cmd('vertical resize -5'), opts(noremap, silent) },
  { '<M-]>', cmd('resize +5'), opts(noremap, silent) },
  { '<M-,>', cmd('resize -5'), opts(noremap, silent) },
  { '<M-.>', cmd('resize +5'), opts(noremap, silent) },

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
  -- yank paste
  -- { '<leader>y', '"+y', opts(noremap) },
  -- { '<leader>p', '"+p', opts(noremap) },
  -- { '<leader>P', '"+P', opts(noremap) },
})

imap({
  -- insert mode
  { '<C-s>', cmd('write'), opts(noremap) },
  -- vscode move line
  { '<M-Up>', '<Esc>:m .-2<CR>==gi', opts(noremap) },
  { '<M-Down>', '<Esc>:m .+1<CR>==gi', opts(noremap) },
  -- emacs keybinding
  -- deleate a word before
  { '<C-w>', '<C-[>diwa', opts(noremap) },
  { '<C-h>', '<Bs>', opts(noremap) },
  { '<C-d>', '<Del>', opts(noremap) },
  -- redo like nomal mode u
  { '<C-u>', '<C-G>u<C-u>', opts(noremap) },
  { '<C-p>', '<Up>', opts(noremap) },
  { '<C-n>', '<Down>', opts(noremap) },
  { '<C-b>', '<Left>', opts(noremap) },
  { '<C-f>', '<Right>', opts(noremap) },
  { '<C-a>', '<Esc>^i', opts(noremap) },
  { '<C-e>', '<End>', opts(noremap) },
})

-- commandline remap (emacs keybinding)
cmap({
  { '<C-b>', '<Left>', opts(noremap) },
  { '<C-f>', '<Right>', opts(noremap) },
  { '<C-a>', '<Home>', opts(noremap) },
  { '<C-e>', '<End>', opts(noremap) },
  { '<C-d>', '<Del>', opts(noremap) },
  { '<C-h>', '<BS>', opts(noremap) },
})

_G.smart_C_j = function()
  local ls = require('luasnip')
  if ls.expand_or_jumpable() then
    return "<cmd>lua require('luasnip').jump(1)<cr>"
  else
    return '<Down>'
  end
end

_G.smart_C_k = function()
  local ls = require('luasnip')
  if ls.expand_or_jumpable() then
    return "<cmd>lua require('luasnip').jump(-1)<cr>"
  else
    return '<Up>'
  end
end

_G.smart_C_h = function()
  local ls = require('luasnip')
  if ls.expand_or_jumpable() then
    return "<cmd>lua require('luasnip').jump(-1)<cr>"
  else
    return '<Left>'
  end
end

_G.smart_C_l = function()
  local ls = require('luasnip')
  if ls.expand_or_jumpable() then
    return "<cmd>lua require('luasnip').jump(-1)<cr>"
  else
    return '<Right>'
  end
end
