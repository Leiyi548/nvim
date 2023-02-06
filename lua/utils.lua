local M = {}
local H = {}

H.buffer_diagnostic_state = {}

function M.toggle_diagnostic()
  local buf_id = vim.api.nvim_get_current_buf()
  local buf_state = H.buffer_diagnostic_state[buf_id]
  if buf_state == nil then
    buf_state = true
  end

  if buf_state then
    vim.diagnostic.disable(buf_id)
  else
    vim.diagnostic.enable(buf_id)
  end

  local new_buf_state = not buf_state
  H.buffer_diagnostic_state[buf_id] = new_buf_state

  return new_buf_state and 'enable diagnostic' or 'disabled diagnositc'
end

function M.rename_current_file()
  local Input = require('nui.input')
  local event = require('nui.utils.autocmd').event
  local NuiText = require('nui.text')

  local name = vim.fn.expand('%:t')
  local msg = string.format('Enter new name for "%s":', name)
  local width = string.len(msg) + 2

  local highlights = {
    TITLE_BAR = 'NeoTreeTitleBar',
    PROMPT = 'TelescopePromptPrefix',
    NORMAL = 'TelescopeNormal',
  }

  local blank = NuiText(' ', highlights.TITLE_BAR)
  local popup_border_text = NuiText(' ' .. msg .. ' ', highlights.TITLE_BAR)
  local input = Input({
    -- relative = "cursor",
    -- position = {
    -- 	row = 1,
    -- 	col = 0,
    -- },
    relative = 'editor',
    position = '50%',
    size = {
      width = width,
    },
    border = {
      style = { '▕', blank, '▏', '▏', ' ', '▔', ' ', '▕' },
      text = {
        top = popup_border_text,
        top_align = 'center',
      },
    },
    win_options = {
      winhighlight = 'Normal:Normal,FloatBorder:Normal',
    },
    buf_options = {
      bufhidden = 'delete',
      buflisted = false,
      filetype = 'rename-popup',
    },
  }, {
    prompt = NuiText('> ', highlights.PROMPT),
    default_value = name,
    on_close = function()
      -- print("Input Closed!")
    end,
    on_submit = function(value)
      vim.cmd('Rename ' .. value)
      print('New Name: ' .. value)
    end,
  })

  -- mount/open the component
  input:mount()

  -- unmount input by pressing `<Esc> or q` in normal mode
  input:map('n', { '<Esc>', 'q' }, function()
    input:unmount()
  end, { noremap = true })

  input:map('i', '<C-c>', function()
    input:unmount()
  end, { noremap = true })

  -- unmount component when cursor leaves buffer
  input:on(event.BufLeave, function()
    input:unmount()
  end)
end

return M
