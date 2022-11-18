-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT
-- recommend plugins key defines in this file

require('keymap.config')
local keymap = require('core.keymap')
local nmap = keymap.nmap
local imap = keymap.imap
local omap = keymap.omap
local xmap = keymap.xmap
local silent, noremap, expr = keymap.silent, keymap.noremap, keymap.expr
local opts = keymap.new_opts
local cmd = keymap.cmd

-- usage of plugins
nmap({
  -- hop
  { 's', cmd('HopChar2'), opts(noremap, silent) },
  { 'S', cmd('HopWord'), opts(noremap, silent) },
  {
    'f',
    cmd(
      "lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })"
    ),
    opts(noremap, silent),
  },
  {
    'F',
    cmd(
      "lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })"
    ),
    opts(noremap, silent),
  },
  {
    't',
    cmd(
      "lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })"
    ),
    opts(noremap, silent),
  },
  {
    'T',
    cmd(
      "lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })"
    ),
    opts(noremap, silent),
  },

  -- neo-tree
  { '<C-w>e', cmd('NeoTreeFloatToggle'), opts(noremap, silent) },

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

  { '<leader>s', ':s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>', opts(noremap, silent) },
  { '<leader>x', cmd('!chmod +x %'), opts(noremap, silent) },
})

imap({
  -- comment.nvim
  { '<C-_>', '<Esc><Plug>(comment_toggle_linewise_current)A', opts(noremap, silent) },
})

omap({
  {
    'f',
    cmd(
      "lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })"
    ),
    opts(noremap, silent),
  },
  {
    'F',
    cmd(
      "lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })"
    ),
    opts(noremap, silent),
  },
  {
    't',
    cmd(
      "lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })"
    ),
    opts(noremap, silent),
  },
  {
    'T',
    cmd(
      "lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })"
    ),
    opts(noremap, silent),
  },
})

xmap({
  { 's', cmd('HopChar2'), opts(noremap, silent) },
  { 'S', cmd('HopWord'), opts(noremap, silent) },
  {
    'f',
    cmd(
      "lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })"
    ),
    opts(noremap, silent),
  },
  {
    'F',
    cmd(
      "lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })"
    ),
    opts(noremap, silent),
  },
  {
    't',
    cmd(
      "lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })"
    ),
    opts(noremap, silent),
  },
  {
    'T',
    cmd(
      "lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })"
    ),
    opts(noremap, silent),
  },
})
