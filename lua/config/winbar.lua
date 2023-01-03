local M = {}

M.winbar_filetype_exclude = {
  -- 'help',
  'startify',
  'dashboard',
  'packer',
  'neogitstatus',

  'NvimTree',
  'neo-tree',
  'Trouble',
  'alpha',
  'lir',
  'Outline',
  'spectre_panel',
  'toggleterm',
  'floaterm',

  'DressingSelect',
  'Jaq',
  'harpoon',
  'dapui_scopes',

  'dapui_breakpoints',
  'dapui_stacks',
  'dapui_watches',
  'dap-repl',
  'dap-terminal',
  'dapui_console',
  'fugitive',
  '',
}

function _G.winbar_click_exploer()
  vim.cmd('NeoTreeFloatToggle')
end

function _G.winbar_click_buffers()
  vim.cmd('NeoTreeFloatToggle buffers')
end

M.get_filename = function()
  local filename = vim.fn.expand('%:t')
  local extension = vim.fn.expand('%:e')
  local f = require('utils.function')
  local nr = vim.api.nvim_get_current_buf()

  if not f.isempty(filename) then
    local file_icon, file_icon_color =
      require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
    local hl_group = 'FileIconColor' .. extension
    vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })
    if f.isempty(file_icon) then
      file_icon = ''
      file_icon_color = ''
    end

    return
      '%#'
        .. hl_group
        .. '#'
        .. file_icon
        .. '%*'
        .. ' '
        .. '%'
        .. nr
        .. '@v:lua.winbar_click_exploer@'
        .. '%#WinbarFilename#'
        .. filename
        .. '%*'
  end
end

local excludes = function()
  if vim.tbl_contains(M.winbar_filetype_exclude, vim.bo.filetype) then
    vim.opt_local.winbar = nil
    return true
  end
  return false
end

M.get_winbar = function()
  if excludes() then
    return
  end
  local f = require('utils.function')
  local value = M.get_filename()

  if not f.isempty(value) then
    local nr = vim.api.nvim_get_current_buf()
    if f.get_buf_option('mod') then
      local mod = '%' .. nr .. '@v:lua.winbar_click_buffers@' .. '%#WinbarModifySign#' .. ' ' .. '%*'
      value = value .. mod
    end
    local num_tabs = #vim.api.nvim_list_tabpages()

    local nr = vim.api.nvim_get_current_buf()
    if num_tabs > 1 and not f.isempty(value) then
      local tabpage_number = tostring(vim.api.nvim_tabpage_get_number(0))
      value = value .. '%' .. nr .. '@v:lua.winbar_click_tabs@' .. '%=' .. tabpage_number .. '/' .. tostring(num_tabs)
    end
  end

  local status_ok, _ = pcall(vim.api.nvim_set_option_value, 'winbar', value, { scope = 'local' })
  if not status_ok then
    return
  end
end

return M
