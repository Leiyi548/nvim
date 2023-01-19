-- author: Leiyi548 https://github.com/Leiyi548
-- created: 2023-01-19
-- License: MIT

local general_group = vim.api.nvim_create_augroup('terminal_settings', { clear = false })
local filetype_group = vim.api.nvim_create_augroup('filetype_settings', { clear = false })
local terminal_group = vim.api.nvim_create_augroup('terminal_settings', { clear = false })
local edit_group = vim.api.nvim_create_augroup('edit_settings', { clear = false })

vim.api.nvim_create_autocmd('TextYankPost', {
  group = general_group,
  pattern = '*',
  desc = 'Highlight text on yank',
  callback = function()
    require('vim.highlight').on_yank({ higroup = 'Search', timeout = 60 })
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = filetype_group,
  pattern = {
    'notify',
    'tsplayground',
    'sagahover',
    'qf',
    'help',
    'man',
    'quicklist',
    'floaterm',
    'spectre_panel',
    'dashboard',
    'tsplayground',
    'fugitive',
    'git',
    'fzf',
    'coctree',
  },
  desc = 'smart quick',
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :q<cr>
      set nobuflisted
    ]])
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = filetype_group,
  pattern = 'alpha',
  desc = 'use o to open button in buffer of alpha',
  callback = function()
    vim.keymap.set('n', 'o', function()
      require('alpha').press()
    end, { noremap = false, silent = true, buffer = 0 })
  end,
})

-- vim.api.nvim_create_autocmd('TermOpen', {
--   group = terminal_group,
--   pattern = '*',
--   callback = function()
--     vim.cmd([[
--       nnoremap <silent> <buffer> q :bdelete<cr>
--       set nobuflisted
--     ]])
--   end,
-- })

vim.api.nvim_create_autocmd('FileType', {
  group = terminal_group,
  pattern = 'toggleterm',
  desc = 'hidden toggleterm window',
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<cr>
      set nobuflisted
    ]])
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  group = terminal_group,
  pattern = 'term://*',
  desc = 'set terminal mode keymap',
  callback = function()
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<A-v>', '<cmd>ToggleTerm size=10 direction=vertical<cr>', opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<A-h>', '<cmd>ToggleTerm size=80 direction=horizontal<cr>', opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<A-i>', '<cmd>ToggleTerm direction=float<cr>', opts)
  end,
})

vim.api.nvim_create_autocmd('ModeChanged', {
  pattern = '*',
  group = edit_group,
  callback = function()
    if
      ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
      and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
      and not require('luasnip').session.jump_active
    then
      require('luasnip').unlink_current()
    end
  end,
})
