-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT
-- recommend plugins key defines in this file

require('keymap.config')
local key = require('core.keymap')
local nmap = key.nmap
local imap = key.imap
local silent, noremap = key.silent, key.noremap
local opts = key.new_opts
local cmd = key.cmd

-- usage of plugins
nmap({
  -- hop
  { 'E', cmd('HopChar1'), opts(noremap, silent) },
  { 'sw', cmd('HopWord'), opts(noremap, silent) },
  { 'sl', cmd('HopLineStart'), opts(noremap, silent) },
  { 'ss', cmd('HopChar2'), opts(noremap, silent) },

  -- telescope
  { '<C-P>', cmd('Telescope find_files'), opts(noremap, silent) },

  -- toggleterm
  { '<M-i>', cmd('ToggleTerm direction=float'), opts(noremap, silent) },
  { '<M-h>', cmd('ToggleTerm size=10  direction=horizontal'), opts(noremap, silent) },
  { '<M-v>', cmd('ToggleTerm size=80  direction=vertical'), opts(noremap, silent) },

  -- gitsign
  { '[g', cmd('lua require "gitsigns".prev_hunk()<cr>'), opts(noremap, silent) },
  { ']g', cmd('lua require "gitsigns".next_hunk()<cr>'), opts(noremap, silent) },
})

-- luasnip jump
imap({
  { '<C-j>', cmd("lua require('luasnip').jump(1)"), opts(noremap, silent) },
  { '<C-k>', cmd("lua require('luasnip').jump(-1)"), opts(noremap, silent) },
})

-- luasnip
vim.api.nvim_set_keymap('i', '<C-l>', '<Plug>luasnip-next-choice', {})
vim.api.nvim_set_keymap('s', '<C-l>', '<Plug>luasnip-next-choice', {})

-- smart_dd
-- smart deletion, dd
-- It solves the issue, where you want to delete empty line, but dd will override you last yank.
-- Code above will check if u are deleting empty line, if so - use black hole register.
-- [src: https://www.reddit.com/r/neovim/comments/w0jzzv/comment/igfjx5y/?utm_source=share&utm_medium=web2x&context=3]
local function smart_dd()
  if vim.api.nvim_get_current_line():match('^%s*$') then
    return '"_dd'
  else
    return 'dd'
  end
end

vim.keymap.set('n', 'dd', smart_dd, { noremap = true, expr = true })
