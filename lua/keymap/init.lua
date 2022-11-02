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
  -- buffer jump
  { ';s', cmd('e #'), opts(noremap, silent) },
  { ';t', cmd('lua require("telescope-tabs").go_to_previous()'), opts(noremap, silent) },
  { ';f', cmd('Telescope find_files'), opts(noremap, silent) },
  { ';r', cmd("lua require('modules.tools.fancy_telescope').findRecentFiles()"), opts(noremap, silent) },
  { ';b', cmd("lua require('modules.tools.fancy_telescope').selectBuffers()"), opts(noremap, silent) },
  { ';g', cmd('Telescope git_status'), opts(noremap, silent) },

  -- toggleterm
  { '<M-i>', cmd('ToggleTerm direction=float'), opts(noremap, silent) },
  { '<M-h>', cmd('ToggleTerm size=10  direction=horizontal'), opts(noremap, silent) },
  { '<M-v>', cmd('ToggleTerm size=80  direction=vertical'), opts(noremap, silent) },

  -- gitsign
  { '[g', cmd('lua require "gitsigns".prev_hunk()'), opts(noremap, silent) },
  { ']g', cmd('lua require "gitsigns".next_hunk()'), opts(noremap, silent) },
  { 'gp', cmd('lua require "gitsigns".preview_hunk()'), opts(noremap, silent) },

  -- todo-comment
  { '[t', cmd('lua require("todo-comments").jump_prev()'), opts(noremap, silent) },
  { ']t', cmd('lua require("todo-comments").jump_next()'), opts(noremap, silent) },

  -- Vistitlink like vscode style
  { 'gx', cmd('VisitLinkUnderCursor'), opts(noremap, silent) },

  -- Smart dd
  { 'dd', _G.smart_dd, opts(noremap, silent, expr) },

  -- comment.nvim
  { '<C-_>', '<Plug>(comment_toggle_linewise_current)', opts(noremap, silent) },
})

imap({
  -- smart ctrl
  { '<C-j>', _G.smart_C_j, opts(expr, silent, remap) },
  { '<C-k>', _G.smart_C_k, opts(expr, silent, remap) },
  { '<C-l>', _G.smart_C_l, opts(expr, silent, remap) },

  -- comment.nvim
  { '<C-_>', '<Esc><Plug>(comment_toggle_linewise_current)xi', opts(noremap, silent) },
})

smap({
  { '<C-j>', _G.smart_C_j, opts(expr, silent, remap) },
  { '<C-k>', _G.smart_C_k, opts(expr, silent, remap) },
})

-- luasnip
vim.cmd([[
  snoremap <BS> <C-O>s
]])
