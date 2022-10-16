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
  { 's', '<leader>' },
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
  { '<M-Up>', ':m .-2<CR>==', opts(noremap) },
  { '<M-Down>', ':m .+1<CR>==', opts(noremap) },
})

xmap({
  -- I hate click this key
  { '<', '<gv', opts(noremap) },
  { '>', '>gv', opts(noremap) },
  { 'H', '^', opts(noremap) },
  { 'L', '$', opts(noremap) },

  -- move line up/down like vscode
  { 'J', ":move '>+1<CR>gv-gv", opts(noremap) },
  { 'K', ":move '<-2<CR>gv-gv", opts(noremap) },
  { '<M-Down>', ":move '>+1<CR>gv-gv", opts(noremap) },
  { '<M-Up>', ":move '<-2<CR>gv-gv", opts(noremap) },

  -- 防止剪贴版被复制内容给替代
  { 'p', '"_dP', opts(noremap) },

  -- comment.nvim
  { '<C-_>', '<Plug>(comment_toggle_linewise_visual)', opts(noremap, silent) },
})

imap({
  { '<C-s>', cmd('write'), opts(noremap) },

  -- use C-v to paste text
  { '<C-V>', '<Esc>pA', opts(noremap) },

  -- move line up/down vscode
  { '<M-Up>', '<Esc>:m .-2<CR>==gi', opts(noremap) },
  { '<M-Down>', '<Esc>:m .+1<CR>==gi', opts(noremap) },

  -- emacs keybinding
  -- reference: https://unix.stackexchange.com/questions/49203/vim-customized-with-emacs-commands-insert-mode-only
  -- deleate a word befor
  { '<C-w>', '<C-[>diwa', opts(noremap) },
  { '<C-h>', '<Bs>', opts(noremap) },
  { '<C-d>', '<Del>', opts(noremap) },
  { '<C-u>', '<C-G>u<C-u>', opts(noremap) },
  { '<C-p>', '<Up>', opts(noremap) },
  { '<C-n>', '<Down>', opts(noremap) },
  { '<C-b>', '<Left>', opts(noremap) },
  { '<C-f>', '<Right>', opts(noremap) },
  { '<C-a>', '<Esc>^i', opts(noremap) },
  { '<C-e>', '<End>', opts(noremap) },
  { '<M-f>', '<C-Right>', opts(noremap) },
  { '<M-b>', '<C-Left>', opts(noremap) },
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

-- reference: https://github.com/glepnir/nvim/blob/main/lua/keymap/init.lua
_G.smart_C_j = function()
  local ls = require('luasnip')
  if ls.expand_or_jumpable() then
    return "<cmd>lua require('luasnip').jump(1)<cr>"
  else
    return '<ESC>o'
  end
end

_G.smart_C_k = function()
  local ls = require('luasnip')
  if ls.jumpable(-1) then
    return "<cmd>lua require('luasnip').jump(-1)<cr>"
  else
    return '<ESC>lDa'
  end
end

_G.smart_C_l = function()
  local ls = require('luasnip')
  if ls.choice_active() then
    return '<Plug>luasnip-next-choice'
  else
    return '<Tab>'
  end
end

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
