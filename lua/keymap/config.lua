-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT
-- recommend some vim mode key defines in this file

local keymap = require('core.keymap')
local nmap, imap, cmap, xmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.xmap
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
  { '<C-s>', cmd('write'), opts(noremap) },

  -- yank paste
  { 'Y', 'y$', opts(noremap) },

  -- I hate click this key
  { 'H', '^', opts(noremap) },
  { 'L', '$', opts(noremap) },

  -- buffer jump
  { ']b', cmd('bn'), opts(noremap) },
  { '[b', cmd('bp'), opts(noremap) },

  -- emacs change keybinding
  { '<Home>', '<C-a>', opts(noremap) },

  -- window jump
  { '<BS>', '<C-w>h', opts(noremap) },
  { '<C-l>', '<C-w>l', opts(noremap) },
  { '<C-j>', '<C-w>j', opts(noremap) },
  { '<C-k>', '<C-w>k', opts(noremap) },

  -- resize window
  { '<M-[>', cmd('vertical resize -5'), opts(noremap, silent) },
  { '<M-]>', cmd('resize +5'), opts(noremap, silent) },
  { '<M-,>', cmd('resize -5'), opts(noremap, silent) },
  { '<M-.>', cmd('resize +5'), opts(noremap, silent) },

  -- like vscode move line
  { '<M-j>', '<esc>:m .+1<cr>==gi', opts(noremap, silent) },
  { '<M-k>', '<esc>:m .-2<cr>==gi', opts(noremap, silent) },
})

xmap({
  -- I hate click this key
  { 'H', '^', opts(noremap) },
  { 'L', '$', opts(noremap) },

  -- move line up/down like vscode
  { 'J', ":move '>+1<cr>gv-gv", opts(noremap) },
  { 'K', ":move '<-2<cr>gv-gv", opts(noremap) },
  { '<M-j>', '<esc>:m .+1<cr>==gi', opts(noremap, silent) },
  { '<M-k>', '<esc>:m .-2<cr>==gi', opts(noremap, silent) },

  -- 防止剪贴版被复制内容给替代
  { 'p', '"_dP', opts(noremap) },

  { '<', '<gv', opts(noremap) },
  { '>', '>gv', opts(noremap) },

  -- comment.nvim like vscode behaviour
  { '<C-_>', '<Plug>(comment_toggle_linewise_visual)', opts(noremap, silent) },
})

imap({
  { '<C-s>', cmd('write'), opts(noremap) },

  -- use C-v to paste text
  -- { '<C-v>', '<esc>pA', opts(noremap) },

  -- move line up/down vscode
  { '<M-j>', '<esc>:m .+1<cr>==gi', opts(noremap, silent) },
  { '<M-k>', '<esc>:m .-2<cr>==gi', opts(noremap, silent) },

  -- comment.nvim
  { '<C-_>', '<esc><Plug>(comment_toggle_linewise_visual)', opts(noremap, silent) },
})

-- commandline remap (emacs keybinding)
cmap({
  { '<C-b>', '<Left>', opts(noremap) },
  { '<C-f>', '<Right>', opts(noremap) },
  { '<C-a>', '<Home>', opts(noremap) },
  { '<C-e>', '<End>', opts(noremap) },
  { '<C-d>', '<Del>', opts(noremap) },
  { '<C-h>', '<BS>', opts(noremap) },
  { '<M-f>', '<C-Right>', opts(noremap) },
  { '<M-b>', '<C-Left>', opts(noremap) },
})

-- smart_dd
-- smart deletion, dd
-- It solves the issue, where you want to delete empty line, but dd will override you last yank.
-- Code above will check if u are deleting empty line, if so - use black hole register.
-- [src: https://www.reddit.com/r/neovim/comments/w0jzzv/comment/igfjx5y/?utm_source=share&utm_medium=web2x&context=3]
_G.smart_dd = function()
  if vim.api.nvim_get_current_line():match('^%s*$') then
    return '"_dd'
  else
    return 'dd'
  end
end
