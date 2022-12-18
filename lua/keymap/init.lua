-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT
-- recommend plugins key defines in this file

require('keymap.config')
local keymap = require('core.keymap')
local nmap = keymap.nmap
local imap = keymap.imap
local silent, noremap, expr = keymap.silent, keymap.noremap, keymap.expr
local opts = keymap.new_opts
local cmd = keymap.cmd

-- usage of plugins
nmap({
  -- neo-tree
  { '<C-w>e', cmd('NeoTreeFloatToggle'), opts(noremap, silent) },

  -- toggleterm
  -- { '<M-i>', cmd('ToggleTerm direction=float'), opts(noremap, silent) },
  -- { '<M-h>', cmd('ToggleTerm size=10  direction=horizontal'), opts(noremap, silent) },
  -- { '<M-v>', cmd('ToggleTerm size=80  direction=vertical'), opts(noremap, silent) },

  -- gitsign
  { '[g', cmd('lua require "gitsigns".prev_hunk()'), opts(noremap, silent) },
  { ']g', cmd('lua require "gitsigns".next_hunk()'), opts(noremap, silent) },
  { 'gp', cmd('lua require "gitsigns".preview_hunk()'), opts(noremap, silent) },

  -- Vistitlink like vscode style
  { 'gx', cmd('VisitLinkUnderCursor'), opts(noremap, silent) },

  -- smart dd
  { 'dd', _G.smart_dd, opts(noremap, silent, expr) },

  -- smart_quit
  { 'Q', cmd('lua require("utils.function").smart_quit()'), opts(noremap, silent, expr) },

  -- comment.nvim Ctrl+/
  { '<C-_>', '<Plug>(comment_toggle_linewise_current)', opts(noremap, silent) },

  { '<leader>sw', ':s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', opts(noremap, silent) },
  { '<leader>x', cmd('!chmod +x %'), opts(noremap, silent) },
})

imap({
  -- comment.nvim
  { '<C-_>', '<Esc><Plug>(comment_toggle_linewise_current)A', opts(noremap, silent) },
})

vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
