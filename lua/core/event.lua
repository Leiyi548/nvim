-- author: Leiyi548 https://github.com/Leiyi548
-- date: 2022-07-18
-- License: MIT
-- create autocmd for neovim
-- more information please see https://github.com/ayamir/nvimdots/blob/main/lua/core/init.lua

local vim = vim
local autocmd = {}

function autocmd.nvim_create_augroups(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command('augroup ' .. group_name)
    vim.api.nvim_command('autocmd!')
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten({ 'autocmd', def }), ' ')
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command('augroup END')
  end
end

function autocmd.load_autocmds()
  local definitions = {
    packer = {},
    bufs = {
      -- auto place to last edit
      {
        'BufReadPost',
        '*',
        [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g'\"" | endif]],
      },
      -- format on save
      {
        'BufWritePost',
        '*',
        'lua vim.lsp.buf.format{async = true}',
      },
    },
    wins = {
      -- Highlight current line only on focused window
      {
        'WinEnter,BufEnter,InsertLeave',
        '*',
        [[if ! &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal cursorline | endif]],
      },
      {
        'WinLeave,BufLeave,InsertEnter',
        '*',
        [[if &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal nocursorline | endif]],
      },
      -- Force write shada on leaving nvim
      {
        'VimLeave',
        '*',
        [[if has('nvim') | wshada! | else | wviminfo! | endif]],
      },
      -- Check if file changed when its window is focus, more eager than 'autoread'
      { 'FocusGained', '* checktime' },
      -- Equalize window dimensions when resizing vim window
      { 'VimResized', '*', [[tabdo wincmd =]] },
    },
    ft = {
      -- { "FileType", "alpha", "set showtabline=0" },
      { 'FileType', 'markdown', 'set wrap' },
      { 'FileType', 'make', 'set noexpandtab shiftwidth=8 softtabstop=0' },
      {
        'FileType',
        'sagahover,qf,help,quicklist,floaterm,null-ls-info,alpha,startuptime,structrue-go,spectre_panel,lspinfo,dashboard,lspsagaoutline',
        'nnoremap <silent> <buffer> q :q<cr>',
      },
      {
        'FileType',
        'DiffviewFileHistory,DiffviewFiles',
        'nnoremap <silent> <buffer> q :DiffviewClose<cr>',
      },
      {
        'FileType',
        'toggleterm',
        'nnoremap <silent> <buffer> q :hide<cr>',
      },
      { 'FileType', 'alpha', 'set nocursorline' },
      { 'FileType', '*', [[setlocal formatoptions-=cro]] },
      { 'TermOpen', 'term://*', 'nnoremap <silent><buffer>q :bdelete<cr>' },
    },
    -- highlight yank
    yank = {
      {
        'TextYankPost',
        '*',
        [[silent! lua vim.highlight.on_yank({higroup="IncSearch", timeout=300})]],
      },
    },
  }

  autocmd.nvim_create_augroups(definitions)
end

if vim.fn.has('nvim-0.8') == 1 then
  vim.api.nvim_create_autocmd(
    { 'CursorMoved', 'CursorHold', 'BufWinEnter', 'BufFilePost', 'InsertEnter', 'BufWritePost', 'TabClosed' },
    {
      callback = function()
        require('modules.ui.winbar').get_winbar()
      end,
    }
  )
end

-- 解决 cmp 乱跳
function G_leave_snippet()
  if
    ((vim.v.event.old_mode == 's' and vim.v.event.new_mode == 'n') or vim.v.event.old_mode == 'i')
    and require('luasnip').session.current_nodes[vim.api.nvim_get_current_buf()]
    and not require('luasnip').session.jump_active
  then
    require('luasnip').unlink_current()
  end
end

-- stop snippets when you leave to normal mode
vim.api.nvim_command([[
    autocmd ModeChanged * lua G_leave_snippet()
]])

autocmd.load_autocmds()
