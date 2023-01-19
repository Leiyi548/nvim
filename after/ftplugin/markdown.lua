-- author: Leiyi548 https://github.com/Leiyi548
-- date: 2023-01-19
-- License: MIT

function _G_toggle_checkbox()
  local r = vim.api.nvim_win_get_cursor(0)
  local line = vim.fn.getline('.')
  local line_number = vim.fn.line('.')
  local col_number = r[2]
  -- 先匹配掉最前面的空白符
  -- 然后匹配 - 或者 +
  -- 再匹配空白符
  -- 然后匹配 [x]
  local pattern = '^(%s*[%-%+]%s*%[([%sx%-]?)%])'
  local checkbox, state = line:match(pattern)
  if not checkbox then
    return
  end
  local new_val = vim.trim(state) == '' and '[x]' or '[ ]'
  checkbox = checkbox:gsub('%[[%sx%-]?%]$', new_val)
  local new_line = line:gsub(pattern, checkbox)
  vim.fn.setline('.', new_line)
  vim.fn.cursor(line_number, col_number)
end

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<cr>', '<cmd>lua _G_toggle_checkbox()<cr> ', opts)
