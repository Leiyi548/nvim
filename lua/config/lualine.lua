local statusline_ok, lualine = pcall(require, 'lualine')
if not statusline_ok then
  vim.notify('lualine not found!')
  return
end

local icons = require('config.icons')

-- check if value in table
local function contains(t, value)
  for _, v in pairs(t) do
    if v == value then
      return true
    end
  end
  return false
end

local hide_in_width_60 = function()
  return vim.o.columns > 60
end

local hide_in_width = function()
  return vim.o.columns > 80
end

local hide_in_width_100 = function()
  return vim.o.columns > 100
end

local diagnostics = {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  sections = { 'error', 'warn' },
  symbols = {
    error = icons.diagnostics.BoldError,
    warn = icons.diagnostics.BoldWarn,
  },
  colored = true,
  update_in_insert = false,
  always_visible = true,
  separator = '',
}

local diff = {
  'diff',
  colored = true,
  symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
  cond = hide_in_width_60,
  separator = '',
}

local branch = {
  'branch',
  icons_enabled = true,
  icon = icons.git.Branch,
  colored = false,
  cond = hide_in_width_100,
}

local progress = {
  'progress',
  padding = 0,
}

local location = {
  'location',
  padding = 1,
}

local simple_filename = {
  'filename',
  file_status = false, -- Displays file status (readonly status, modified status)
  newfile_status = true, -- Display new file status (new file means no write after created)
  path = 1,
  -- 0: Just the filename
  -- 1: Relative path
  -- 2: Absolute path
  -- 3: Absolute path, with tilde(~) as the home directory
  shorting_target = 0, -- Shortens path to leave 40 spaces in the window
  -- for other components. (terrible name, any suggestions?)
  symbols = {
    modified = ' ', -- Text to show when the file is modified.
    readonly = ' ', -- Text to show when the file is non-modifiable or readonly.
    unnamed = ' ', -- Text to show for unnamed buffers.
    -- newfile = ' ', -- Text to show for new created file before first writting
    newfile = '[new]', -- Text to show for new created file before first writting
    -- newfile = ' ' .. require('nvim-nonicons').get('vim-normal-mode'), -- Text to show for new created file before first writting
  },
  fmt = function(str)
    local size = require('lualine.components.filesize')()
    if size == '' then
      size = ''
    else
      size = ' [' .. size .. ']'
    end
    return str .. size
  end,
  separator = '',
}

local spaces = {
  function()
    local buf_ft = vim.bo.filetype

    local ui_filetypes = {
      'help',
      'packer',
      'neogitstatus',
      'NvimTree',
      'Trouble',
      'lir',
      'Outline',
      'spectre_panel',
      'DressingSelect',
      '',
    }
    local space = ''

    if contains(ui_filetypes, buf_ft) then
      space = ' '
    end

    -- TODO: update codicons and use their indent
    return '  ' .. vim.api.nvim_buf_get_option(0, 'shiftwidth') .. space .. ' '
  end,
  padding = 0,
  -- separator = '%#SLSeparator#' .. ' │' .. '%*',
  -- separator = ' │',
  cond = hide_in_width_100,
}

local LSP_status = {
  function()
    if rawget(vim, 'lsp') then
      for _, client in ipairs(vim.lsp.get_active_clients()) do
        if client.attached_buffers[vim.api.nvim_get_current_buf()] then
          return ('   LSP ~ ' .. client.name .. ' ') or '   LSP '
        end
      end
    end
  end,
  cond = hide_in_width,
}

-- cool function for progress
local super_progress = {
  function()
    local current_line = vim.fn.line('.')
    local total_lines = vim.fn.line('$')
    local chars = { '__', '▁▁', '▂▂', '▃▃', '▄▄', '▅▅', '▆▆', '▇▇', '██' }
    local line_ratio = current_line / total_lines
    local index = math.ceil(line_ratio * #chars)
    return chars[index]
  end,
  -- color = { fg = colors.yellow, bg = colors.blue },
  padding = { left = 0, right = 0 },
}

local encoding = {
  'encoding',
  cond = hide_in_width_100,
}

local filetype = {
  'filetype',
  colored = true,
  icon_only = true,
  separator = '',
  padding = { left = 1, right = 0 },
}

local pwd = function()
  local foldname = vim.fn.fnamemodify(vim.fn.getcwd(), ':t') .. ' '
  return ' ' .. foldname
end

local lazy = {
  require('lazy.status').updates,
  cond = require('lazy.status').has_updates,
  color = { fg = '#ff9e63' },
}

local window = function()
  return vim.api.nvim_win_get_number(0)
end

local function is_loclist()
  return vim.fn.getloclist(0, { filewinid = 1 }).filewinid ~= 0
end

local quickfix_label = function()
  return is_loclist() and 'Location List' or 'Quickfix List'
end

local quickfix_title = function()
  if is_loclist() then
    return vim.fn.getloclist(0, { title = 0 }).title
  end
  return vim.fn.getqflist({ title = 0 }).title
end

local quickfix_extension = {
  sections = {
    lualine_a = { window },
    lualine_b = { quickfix_title },
    lualine_c = { quickfix_label },
    lualine_y = { location },
    lualine_z = { progress },
  },
  filetypes = { 'qf' },
}

local fugitive_branch = function()
  local icon = icons.git.Branch
  return icon .. ' ' .. vim.fn.FugitiveHead()
end

local fugitive_extension = {
  sections = {
    lualine_a = { window },
    lualine_b = { fugitive_branch },
    lualine_y = { location },
    lualine_z = { progress },
  },
  filetypes = { 'fugitive' },
}

local get_short_cwd = function()
  return vim.fn.fnamemodify(vim.fn.getcwd(), ':~')
end

local neo_tree_extension = {
  sections = {
    lualine_a = { window },
    lualine_b = { get_short_cwd },
  },
  filetypes = { 'neo-tree' },
}

local toggleterm_statusline = function()
  return 'ToggleTerm #' .. vim.b.toggle_number
end

local toggleterm_extension = {
  sections = {
    lualine_a = { window },
    lualine_b = { toggleterm_statusline },
  },
  filetypes = { 'toggleterm' },
}

lualine.setup({
  options = {
    icons_enabled = true,
    globalstatus = false,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'dashboard', 'Outline', 'startify', 'TelescopePrompt', 'packer' },
    always_divide_middle = true,

    refresh = { -- sets how often lualine should refreash it's contents (in ms)
      statusline = 1000, -- The refresh option sets minimum time that lualine tries
      tabline = 1000, -- to maintain between refresh. It's not guarantied if situation
      winbar = 1000, -- arises that lualine needs to refresh itself before this time
      -- it'll do it.

      -- Also you can force lualine's refresh by calling refresh function
      -- like require('lualine').refresh()
    },
  },
  sections = {
    lualine_a = { window },
    lualine_b = { branch },
    lualine_c = { filetype, simple_filename, diff, diagnostics },
    lualine_x = { spaces, encoding },
    lualine_y = { location },
    lualine_z = { progress },
  },
  -- 没有聚焦的窗口
  inactive_sections = {
    lualine_a = { window },
    lualine_b = { 'filetype' },
    lualine_c = { { 'filename', path = 1, symbols = { modified = '[*]' } } },
    lualine_x = {},
    lualine_y = { location },
    lualine_z = { progress },
  },
  tabline = {},
  extensions = { quickfix_extension, fugitive_extension, neo_tree_extension, toggleterm_extension },
})
