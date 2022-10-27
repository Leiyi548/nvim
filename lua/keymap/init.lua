-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT
-- recommend plugins key defines in this file

require('keymap.config')
local keymap = require('core.keymap')
local nmap = keymap.nmap
local imap = keymap.imap
local smap = keymap.smap
local remap = keymap.remap
local silent, noremap, expr = keymap.silent, keymap.noremap, keymap.expr
local opts = keymap.new_opts
local cmd = keymap.cmd

-- usage of plugins
nmap({
  -- toggleterm
  { '<M-i>', cmd('ToggleTerm direction=float'), opts(noremap, silent) },
  { '<M-h>', cmd('ToggleTerm size=10  direction=horizontal'), opts(noremap, silent) },
  { '<M-v>', cmd('ToggleTerm size=80  direction=vertical'), opts(noremap, silent) },

  -- gitsign
  { '[g', cmd('lua require "gitsigns".prev_hunk()'), opts(noremap, silent) },
  { ']g', cmd('lua require "gitsigns".next_hunk()'), opts(noremap, silent) },
  { 'gp', cmd('lua require "gitsigns".preview_hunk()'), opts(noremap, silent) },

  -- Vistitlink like vscode style
  { 'gx', cmd('VisitLinkUnderCursor'), opts(noremap, silent) },

  -- Smart dd
  { 'dd', _G.smart_dd, opts(noremap, silent, expr) },

  -- comment.nvim Ctrl+/
  { '<C-_>', '<Plug>(comment_toggle_linewise_current)', opts(noremap, silent) },

  -- hop.nvim
})

imap({
  -- smart ctrl
  { '<C-j>', _G.smart_C_j, opts(expr, silent, remap) },
  { '<C-k>', _G.smart_C_k, opts(expr, silent, remap) },
  { '<C-l>', _G.smart_C_l, opts(expr, silent, remap) },

  -- comment.nvim
  { '<C-_>', '<Esc><Plug>(comment_toggle_linewise_current)A', opts(noremap, silent) },
})

smap({
  { '<C-j>', _G.smart_C_j, opts(expr, silent, remap) },
  { '<C-k>', _G.smart_C_k, opts(expr, silent, remap) },
})
