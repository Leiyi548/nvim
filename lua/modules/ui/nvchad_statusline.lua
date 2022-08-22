local statusline_ok, lualine = pcall(require, 'lualine')
if not statusline_ok then
  vim.notify('lualine not found!')
  return
end

local icons = require('modules.ui.icons')

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

local filetype = {
  'filetype',
  fmt = function(str)
    local ui_filetypes = {
      'help',
      'packer',
      'neogitstatus',
      'NvimTree',
      'Trouble',
      'lir',
      'Outline',
      'spectre_panel',
      'toggleterm',
      'DressingSelect',
      '',
    }

    if str == 'toggleterm' then
      -- 
      local term = '%#SLTermIcon#'
        .. ' '
        .. '%*'
        .. '%#SLFG#'
        .. vim.api.nvim_buf_get_var(0, 'toggle_number')
        .. '%*'
      return term
    end

    if contains(ui_filetypes, str) then
      return ''
    else
      return str
    end
  end,
  icons_enabled = true,
}

local diagnostics = {
  'diagnostics',
  sources = { 'nvim_diagnostic' },
  sections = { 'error', 'warn' },
  symbols = { error = icons.diagnostics.Error .. ' ', warn = icons.diagnostics.Warning .. ' ' },
  colored = false,
  update_in_insert = false,
  cond = hide_in_width,
  always_visible = false,
}

local diff = {
  'diff',
  colored = true,
  symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
  cond = hide_in_width_60,
  -- separator = '%#SLSeparator#' .. '│ ' .. '%*',
  separator = ' │',
}

local git = {
  function()
    if not vim.b.gitsigns_head or vim.b.gitsigns_git_status then
      return ''
    end

    local git_status = vim.b.gitsigns_status_dict

    local branch_name = '   ' .. git_status.head

    return branch_name
  end,
}

-- cool function for progress
local progress = {
  'progress',
  padding = 0,
}

local fileinfo = {
  function()
    ---@diagnostic disable-next-line: missing-parameter
    local filename = (vim.fn.expand('%') == '' and 'Empty ') or vim.fn.expand('%:t')
    ---@diagnostic disable-next-line: missing-parameter
    local extension = vim.fn.expand('%:e')
    local file_icon, file_icon_color =
      require('nvim-web-devicons').get_icon_color(filename, extension, { default = true })
    local hl_group = 'FileIconColor' .. extension
    vim.api.nvim_set_hl(0, hl_group, { fg = file_icon_color })
    filename = ' ' .. filename .. ' '
    -- return '%#hl_group#' .. file_icon .. filename
    return file_icon .. filename
  end,
}

local cwd = {
  function()
    local dir_icon = ' '
    local dir_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
    return dir_icon .. dir_name
  end,
}

local filename = {
  'filename',
  file_status = true, -- Displays file status (readonly status, modified status)
  newfile_status = false, -- Display new file status (new file means no write after created)
  path = 3, -- 0: Just the filename
  -- 1: Relative path
  -- 2: Absolute path
  -- 3: Absolute path, with tilde(~) as the home directory
  shorting_target = 0, -- Shortens path to leave 40 spaces in the window
  -- for other components. (terrible name, any suggestions?)
  symbols = {
    modified = '[+]', -- Text to show when the file is modified.
    readonly = '[-]', -- Text to show when the file is non-modifiable or readonly.
    unnamed = '[No Name]', -- Text to show for unnamed buffers.
    newfile = '[New]', -- Text to show for new created file before first writting
  },
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

lualine.setup({
  options = {
    icons_enabled = true,
    globalstatus = true,
    theme = 'auto',
    -- component_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = '' },
    -- component_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'alpha', 'dashboard', 'Outline', 'startify', 'TelescopePrompt' },
    always_divide_middle = false,

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
    lualine_a = { git },
    lualine_b = { fileinfo },
    lualine_c = {},
    -- lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_x = { LSP_status, diff },
    lualine_y = { diagnostics, cwd },
    lualine_z = { progress },
  },
  -- 没有聚焦的窗口
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { filename },
    -- lualine_c = { "filename" },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})
