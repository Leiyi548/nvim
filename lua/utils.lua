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

function M.show_buffers()
  local Menu = require('nui.menu')
  local event = require('nui.utils.autocmd').event
  local NuiText = require('nui.text')

  -- @type string
  local env_home = os.getenv('HOME')

  local opts = {
    show_all_buffers = false,
    ignore_current_buffer = false,
    sort_mru = true,
    cwd_only = false,
    use_icon = true,
  }

  local highlights = {
    TITLE_BAR = 'NeoTreeTitleBar',
    PROMPT = 'TelescopePromptPrefix',
    NORMAL = 'TelescopeNormal',
    SELECTION = 'TelescopeSelection',
  }

  local function get_extension(fn)
    local match = fn:match('^.+(%..+)$')
    local ext = ''
    if match ~= nil then
      ext = match:sub(2)
    end
    return ext
  end

  local function icon(fn)
    local nwd = require('nvim-web-devicons')
    local ext = get_extension(fn)
    return nwd.get_icon(fn, ext, { default = true })
  end

  local buffers_menu_tbl = {}
  local buffers_name_tbl = {}

  -- filter buffer
  local buffers_tbl = vim.tbl_filter(function(buffer)
    if 1 ~= vim.fn.buflisted(buffer) then
      return false
    end
    -- only hide unloaded buffers if opts.show_all_buffers is false, keep them listed if true or nil
    if opts.show_all_buffers == false and not vim.api.nvim_buf_is_loaded(buffer) then
      return false
    end
    if opts.ignore_current_buffer and buffer == vim.api.nvim_get_current_buf() then
      return false
    end
    if opts.cwd_only and not string.find(vim.api.nvim_buf_get_name(buffer), vim.loop.cwd(), 1, true) then
      return false
    end
    if not opts.cwd_only and opts.cwd and not string.find(vim.api.nvim_buf_get_name(buffer), opts.cwd, 1, true) then
      return false
    end
    return true
  end, vim.api.nvim_list_bufs())

  if opts.sort_mru then
    table.sort(buffers_tbl, function(a, b)
      return vim.fn.getbufinfo(a)[1].lastused > vim.fn.getbufinfo(b)[1].lastused
    end)
  end

  for _, buffer in ipairs(buffers_tbl) do
    local buffer_name = vim.api.nvim_buf_get_name(buffer):gsub(env_home, '~')
    -- highlight current buffer
    if opts.use_icon then
      -- TODO: add icon prefix
      local icon_text, icon_highlight_group = icon(buffer_name)
      -- local buffer_name_text = NuiText(icon_text, icon_highlight_group) + NuiText(buffer_name, "TelescopeNormal")
    end
    if buffer_name == vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()):gsub(env_home, '~') then
      table.insert(buffers_menu_tbl, Menu.item(NuiText(buffer_name, highlights.SELECTION)))
    else
      table.insert(buffers_menu_tbl, Menu.item(buffer_name))
    end
    table.insert(buffers_name_tbl, buffer_name)
  end

  ---return longest line length
  ---@param lines table
  ---@return number longest
  local function get_longest_line_length(lines)
    local longest = 0
    for _, line in ipairs(lines) do
      if vim.fn.strdisplaywidth(line) > longest then
        longest = vim.fn.strdisplaywidth(line)
      end
    end
    return longest
  end

  local max_length = #buffers_menu_tbl
  local max_width = get_longest_line_length(buffers_name_tbl)

  local menu = Menu({
    relative = 'editor',
    position = '50%',
    size = {
      width = max_width + 5,
      -- width = 50,
      height = max_length,
    },
    border = {
      style = 'single',
      text = {
        top = NuiText(' Buffers ', highlights.TITLE_BAR),
        top_align = 'center',
      },
    },
    win_options = {
      winhighlight = 'Normal:Normal,FloatBorder:Normal',
    },
    buf_options = {
      bufhidden = 'delete',
      buflisted = false,
      filetype = 'SuperHub',
    },
  }, {
    lines = buffers_menu_tbl,
    max_width = 20,
    keymap = {
      focus_next = { 'j', '<Down>', '<Tab>' },
      focus_prev = { 'k', '<Up>', '<S-Tab>' },
      close = { 'q', '<Esc>', '<C-c>' },
      submit = { '<CR>', 'o', '<2-LeftMouse>', '<RightMouse>' },
    },
    on_close = function() end,
    on_submit = function(item)
      -- print(item.text)
      -- print(vim.inspect(item))
      vim.cmd('e' .. item.text)
    end,
  })

  menu:on(event.BufLeave, function()
    menu:unmount()
  end)
  -- mount the component
  menu:mount()
end

function M.get_modify_buffers()
  local modified_buffers_tbl = {}
  for _, buffer in ipairs(vim.api.nvim_list_bufs()) do
    local buffer_name = vim.api.nvim_buf_get_name(buffer)
    print(buffer_name)
    repeat
      -- delete empty buffer
      if buffer_name == nil or buffer_name == '' then
        -- buffer_name = "[No Name]#" .. buffer
        break
      end
      modified_buffers_tbl[buffer_name] = vim.api.nvim_buf_get_option(buffer, 'modified')
    until true
  end
  return modified_buffers_tbl
end

return M
