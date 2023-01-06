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
  sources = { 'coc' },
  sections = { 'error', 'warn' },
  symbols = { error = icons.diagnostics.BoldError, warn = icons.diagnostics.BoldWarn },
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
  padding = 0,
}

local simple_filename = {
  'filename',
  file_status = false, -- Displays file status (readonly status, modified status)
  newfile_status = true, -- Display new file status (new file means no write after created)
  path = 3,
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
  require("lazy.status").updates,
  cond = require('lazy.status').has_updates,
  color = { fg = "#ff9e63" }
}


lualine.setup({
  options = {
    icons_enabled = true,
    globalstatus = true,
    theme = 'auto',
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'alpha', 'dashboard', 'Outline', 'startify', 'TelescopePrompt', 'packer' },
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
    lualine_a = { 'mode' },
    lualine_b = { branch },
    lualine_c = { filetype, simple_filename, diff, diagnostics },
    lualine_x = { encoding },
    lualine_y = { location },
    lualine_z = { progress },
  },
  -- 没有聚焦的窗口
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})
