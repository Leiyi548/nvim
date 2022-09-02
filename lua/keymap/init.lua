-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT
-- recommend plugins key defines in this file

require('keymap.config')
local key = require('core.keymap')
local nmap = key.nmap
-- local imap = key.imap
local silent, noremap = key.silent, key.noremap
local opts = key.new_opts
local cmd = key.cmd

-- usage of plugins
nmap({
  -- hop
  { 'ss', cmd('HopChar2'), opts(noremap, silent) },
  { 'sw', cmd('HopWord'), opts(noremap, silent) },
  { 'S', cmd('HopWord'), opts(noremap, silent) },
  { 'sl', cmd('HopLine'), opts(noremap, silent) },

  -- telescope
  { ';v', '<cmd>Telescope registers<cr>', opts(noremap) },
  { ';r', cmd('lua require("modules.tools.fancy_telescope").findRecentFiles()'), opts(noremap, silent) },
  { ';s', cmd("lua require('modules.tools.fancy_telescope').selectBuffers()"), opts(noremap, silent) },
  { ';f', cmd("lua require('modules.tools.fancy_telescope').findFiles()"), opts(noremap, silent) },

  -- nvim-tree
  { '<C-n>', cmd('NvimTreeToggle'), opts(noremap, silent) },

  -- toggleterm
  { '<M-i>', cmd('ToggleTerm direction=float'), opts(noremap, silent) },
  { '<M-h>', cmd('ToggleTerm size=10  direction=horizontal'), opts(noremap, silent) },
  { '<M-v>', cmd('ToggleTerm size=80  direction=vertical'), opts(noremap, silent) },

  -- gitsign
  { '[d', cmd('lua require "gitsigns".prev_hunk()'), opts(noremap, silent) },
  { ']d', cmd('lua require "gitsigns".next_hunk()'), opts(noremap, silent) },
  { 'gp', cmd('lua require "gitsigns".preview_hunk()'), opts(noremap, silent) },

  -- Vistitlink like vscode style
  { 'gx', cmd('VisitLinkUnderCursor'), opts(noremap, silent) },
})

-- luasnip jump
-- imap({
--   { '<C-j>', cmd("lua require('luasnip').jump(1)"), opts(noremap, silent) },
--   { '<C-k>', cmd("lua require('luasnip').jump(-1)"), opts(noremap, silent) },
-- })

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
