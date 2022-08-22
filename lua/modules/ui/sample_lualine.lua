local statusline_ok, lualine = pcall(require, 'lualine')
if not statusline_ok then
  vim.notify('lualine not found!')
  return
end

local icons = require('modules.ui.icons')

-- set highlight
vim.api.nvim_set_hl(0, 'SLGitIcon', { fg = '#E8AB53', bg = '#32363e' })
vim.api.nvim_set_hl(0, 'SLTermIcon', { fg = '#b668cd', bg = '#282c34' })
vim.api.nvim_set_hl(0, 'SLBranchName', { fg = '#abb2bf', bg = '#32363e', bold = false })
-- vim.api.nvim_set_hl(0, "SLProgress", { fg = "#D7BA7D", bg = "#252525" })
vim.api.nvim_set_hl(0, 'SLProgress', { fg = '#abb2bf', bg = '#32363e' })
vim.api.nvim_set_hl(0, 'SLFG', { fg = '#abb2bf', bg = '#282c34' })
vim.api.nvim_set_hl(0, 'SLSeparator', { fg = '#6b727f', bg = '#33373e' })
vim.api.nvim_set_hl(0, 'SLLSP', { fg = '#5e81ac', bg = '#282c34' })
vim.api.nvim_set_hl(0, 'SLCopilot', { fg = '#6CC644', bg = '#282c34' })

local hl_str = function(str, hl)
  return '%#' .. hl .. '#' .. str .. '%*'
end

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

local branch = {
  'branch',
  icons_enabled = true,
  icon = icons.git.Github_nvchad,
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

local lanuage_server = {
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
      'TelescopePrompt',
      'lspinfo',
      'lsp-installer',
      'mason',
    }

    if contains(ui_filetypes, buf_ft) then
      if M.language_servers == nil then
        return 'null'
      else
        return M.language_servers
      end
    end

    local clients = vim.lsp.get_active_clients()
    local client_names = {}

    -- add client
    for _, client in pairs(clients) do
      if client.name ~= 'null-ls' then
        -- insert lsp client name
        table.insert(client_names, client.name)
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
      language_servers = hl_str('', 'SLSep') .. hl_str(client_names_str, 'SLSeparator') .. hl_str('', 'SLSep')
    end

    if client_names_str_len == 0 then
      return 'null'
    else
      M.language_servers = language_servers
      -- return language_servers:gsub(', anonymous source', '')
      return language_servers
    end
  end,
  padding = 0,
  always_visible = true,
  -- cond = hide_in_width,
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
    lualine_a = { branch },
    lualine_b = { filename },
    lualine_c = {},
    -- lualine_x = { "encoding", "fileformat", "filetype" },
    lualine_x = { LSP_status, diff },
    lualine_y = { diagnostics },
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
