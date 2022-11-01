-- author: Leiyi548 https://github.com/Leiyi548
-- created: 2022-11-01
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
    require('vim.highlight').on_yank({ higroup = 'Search', timeout = 40 })
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
    'lspinfo',
    'spectre_panel',
    'null-ls-info',
    'dashboard',
    'tsplayground',
    'lspsagaoutline',
  },
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :q<cr>
      set nobuflisted
    ]])
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = filetype_group,
  pattern = { 'DiffviewFileHistory', 'DiffviewFiles' },
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :DiffviewClose<cr>
      set nobuflisted
    ]])
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  group = terminal_group,
  pattern = '*',
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :bdelete<cr>
      set nobuflisted
    ]])
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  group = terminal_group,
  pattern = 'toggleterm',
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<cr>
      set nobuflisted
    ]])
  end,
})

if vim.fn.has('nvim-0.8') == 1 then
  vim.api.nvim_create_autocmd(
    { 'BufWinEnter', 'BufWritePost', 'CursorMoved', 'CursorMovedI', 'TextChanged', 'TextChangedI' },
    {
      callback = function()
        require('modules.ui.winbar').get_winbar()
      end,
    }
  )
end

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
