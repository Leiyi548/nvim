local M = {}

M.winbar_filetype_exclude = {
  'help',
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
  '',
}

M.get_filename = function()
  local foldname = vim.api.nvim_eval("$PWD == $HOME ? '~' : substitute($PWD, '\\v(.*/)*', '', 'g')") .. ' '
  local filename = vim.fn.expand('%:t')
  local extension = vim.fn.expand('%:e')
  local f = require('utils.function')

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
        .. '%#WinbarFilename#'
        .. filename
        .. '%*'
        .. '%#WinbarBufferNumber#'
        .. require('utils.function').get_bufs_num()
        .. '%*'
        .. '%#NavicSeparator#'
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

  if not f.isempty(value) and f.get_buf_option('mod') then
    local mod = '%#WinbarModifySign#' .. ' ' .. '%*'
    value = value .. mod
  end

  local status_ok, _ = pcall(vim.api.nvim_set_option_value, 'winbar', value, { scope = 'local' })
  if not status_ok then
    return
  end
end

return M
