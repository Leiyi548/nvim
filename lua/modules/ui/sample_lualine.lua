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
  always_visible = true,
}

local diff = {
  'diff',
  colored = true,
  symbols = { added = ' ', modified = ' ', removed = ' ' }, -- changes diff symbols
  cond = hide_in_width_60,
  -- separator = '%#SLSeparator#' .. '│ ' .. '%*',
  separator = ' │',
}

local branch = {
  'branch',
  icons_enabled = true,
  icon = icons.git.SourceControl,
  colored = false,
}

-- cool function for progress
local progress = {
  'progress',
  padding = 0,
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
    return '  ' .. vim.api.nvim_buf_get_option(0, 'shiftwidth') .. space
  end,
  padding = 0,
  -- separator = '%#SLSeparator#' .. ' │' .. '%*',
  separator = ' │',
  cond = hide_in_width_100,
}

local language_server = {
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
      'toggleterm',
      'DressingSelect',
      '',
    }

    if contains(ui_filetypes, buf_ft) then
      return M.language_servers
    end

    local clients = vim.lsp.get_active_clients()
    local client_names = {}
    local copilot_active = false

    -- add client
    for _, client in pairs(clients) do
      if client.name ~= 'copilot' and client.name ~= 'null-ls' then
        table.insert(client_names, client.name)
      end
      if client.name == 'copilot' then
        copilot_active = true
      end
    end

    -- add formatter
    local s = require('null-ls.sources')
    local available_sources = s.get_available(buf_ft)
    local registered = {}
    for _, source in ipairs(available_sources) do
      for method in pairs(source.methods) do
        registered[method] = registered[method] or {}
        table.insert(registered[method], source.name)
      end
    end

    local formatter = registered['NULL_LS_FORMATTING']
    local linter = registered['NULL_LS_DIAGNOSTICS']
    if formatter ~= nil then
      vim.list_extend(client_names, formatter)
    end
    if linter ~= nil then
      vim.list_extend(client_names, linter)
    end

    -- join client names with commas
    local client_names_str = table.concat(client_names, ', ')

    -- check client_names_str if empty
    local language_servers = ''
    local client_names_str_len = #client_names_str
    if client_names_str_len ~= 0 then
      -- language_servers = '%#SLLSP#' .. '[' .. client_names_str .. ']' .. '%*'
      language_servers = '[' .. client_names_str .. ']'
    end
    if copilot_active then
      language_servers = language_servers .. '%#SLCopilot#' .. ' ' .. icons.git.Octoface .. '%*'
    end

    if client_names_str_len == 0 and not copilot_active then
      return ''
    else
      M.language_servers = language_servers
      return language_servers
    end
  end,
  padding = 0,
  cond = hide_in_width,
  -- separator = '%#SLSeparator#' .. ' │' .. '%*',
  separator = ' │',
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
    component_separators = { left = '', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = { 'alpha', 'dashboard', 'Outline', 'startify', 'TelescopePrompt' },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { branch },
    lualine_b = { filename },
    lualine_c = {},
    -- lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_x = { diff },
    lualine_y = { diagnostics },
    lualine_z = { progress },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    -- lualine_c = { "filename" },
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  extensions = {},
})
