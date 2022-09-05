-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT
-- recommend plugins key defines in this file

require('keymap.config')
local keymap = require('core.keymap')
local nmap = keymap.nmap
local imap = keymap.imap
local smap = keymap.smap
local xmap = keymap.xmap
local remap = keymap.remap
local silent, noremap, expr = keymap.silent, keymap.noremap, keymap.expr
local opts = keymap.new_opts
local cmd = keymap.cmd

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

  -- Smart dd
  { 'dd', _G.smart_dd, opts(noremap, silent, expr) },
})

imap({
  -- smart ctrl
  { '<C-j>', _G.smart_C_j, opts(expr, silent, remap) },
  { '<C-k>', _G.smart_C_k, opts(expr, silent, remap) },
  { '<C-l>', _G.smart_C_l, opts(expr, silent, remap) },
})

smap({
  { '<C-j>', _G.smart_C_j, opts(expr, silent, remap) },
  { '<C-k>', _G.smart_C_k, opts(expr, silent, remap) },
})

xmap({
  -- 防止剪贴版被复制内容给替代
  { 'p', '"_dP', opts(expr, silent, remap) },
})
