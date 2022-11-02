-- author: Leiyi548 https://github.com/Leiyi548
-- date: 2022-07-18
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

function _G_jump_next_header()
  local headersRegexp = '\v^(#|.+\n(=+|-+)$)'
  if vim.fn.search('#', 'W') == 0 then
    vim.cmd('normal! G')
    vim.notify('no next header', vim.log.levels.WARN, { title = 'markdown_jump' })
  end
end

function _G_jump_prev_header()
  local headersRegexp = '\v^(#|.+\n(=+|-+)$)'
  if vim.fn.search('#', 'Wb') == 0 then
    vim.cmd('normal! G')
    vim.notify('no next header', vim.log.levels.WARN, { title = 'markdown_jump' })
  end
end

local opts = { noremap = true, silent = true }
local edit_group = vim.api.nvim_create_augroup('edit_settings', { clear = false })
vim.api.nvim_create_autocmd('TextYankPost', {
  group = edit_group,
  pattern = '*',
  desc = 'markdown keymap',
  callback = function()
    vim.cmd([[

    ]])
  end,
})
vim.api.nvim_buf_set_keymap(0, 'n', '<cr>', '<cmd>lua _G_toggle_checkbox()<cr> ', opts)
-- vim.api.nvim_set_keymap('n', '<cr>', '<cmd>lua _G_toggle_checkbox()<cr> ', opts)

-- venn.nvim: enable or disable keymappings
function _G.Toggle_venn()
  local venn_enabled = vim.inspect(vim.b.venn_enabled)
  if venn_enabled == 'nil' then
    vim.b.venn_enabled = true
    vim.cmd([[setlocal ve=all]])
    -- draw a line on HJKL keystokes
    vim.api.nvim_buf_set_keymap(0, 'n', 'J', '<C-v>j:VBox<CR>', { noremap = true })
    vim.api.nvim_buf_set_keymap(0, 'n', 'K', '<C-v>k:VBox<CR>', { noremap = true })
    vim.api.nvim_buf_set_keymap(0, 'n', 'L', '<C-v>l:VBox<CR>', { noremap = true })
    vim.api.nvim_buf_set_keymap(0, 'n', 'H', '<C-v>h:VBox<CR>', { noremap = true })
    -- draw a box by pressing "f" with visual selection
    vim.api.nvim_buf_set_keymap(0, 'v', 'f', ':VBox<CR>', { noremap = true })
  else
    vim.cmd([[setlocal ve=]])
    vim.cmd([[mapclear <buffer>]])
    vim.b.venn_enabled = nil
  end
end

-- toggle keymappings for venn using <leader>v
vim.api.nvim_set_keymap('n', '<leader>v', ':lua Toggle_venn()<CR>', { noremap = true })
vim.api.nvim_set_keymap('v', '<leader>v', ':lua Toggle_venn()<CR>', { noremap = true })
