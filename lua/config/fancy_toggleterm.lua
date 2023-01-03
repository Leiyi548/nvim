local M = {}
local Terminal = require('toggleterm.terminal').Terminal

local lazygit = Terminal:new({
  cmd = 'lazygit',
  hidden = true,
  direction = 'float',
  on_open = function(term)
    vim.cmd('startinsert!')
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', '<cmd>close<CR>', { silent = false, noremap = true })
    if vim.fn.mapcheck('<esc>', 't') ~= '' then
      vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<esc>')
    end
  end,
})
function M.lazygit_toggle()
  lazygit:toggle()
end

local lazygit_log = Terminal:new({
  cmd = 'lazygit log',
  hidden = true,
  direction = 'float',
  on_open = function(term)
    vim.cmd('startinsert!')
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', '<cmd>close<CR>', { silent = false, noremap = true })
    if vim.fn.mapcheck('<esc>', 't') ~= '' then
      vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<esc>')
    end
  end,
})
function M.lazygit_log_toggle()
  lazygit_log:toggle()
end

return M
