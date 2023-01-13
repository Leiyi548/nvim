-- author: Leiyi548 https://github.com/Leiyi548
-- created: 2023-01-13
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
    'fzf',
    'coctree',
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
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<cr>
      set nobuflisted
    ]])
  end,
})

-- coc format on save
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
  pattern  = { "*.go", "*.lua" },
  callback = function()
    vim.cmd([[call CocAction('format')]])
  end,
})

-- winbar
vim.api.nvim_create_autocmd(
  { 'BufWinEnter', 'BufWritePost', 'CursorMoved', 'CursorMovedI', 'TextChanged', 'TextChangedI' },
  {
    callback = function()
      require('config.winbar').get_winbar()
    end,
  }
)
