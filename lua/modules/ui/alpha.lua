local status_ok, alpha = pcall(require, 'alpha')
if not status_ok then
  return
end

local path_ok, path = pcall(require, 'plenary.path')
if not path_ok then
  return
end

local dashboard = require('alpha.themes.dashboard')
local nvim_web_devicons = require('nvim-web-devicons')
local cdir = vim.fn.getcwd()

local function getGreeting(name)
  local tableTime = os.date('*t')
  local hour = tableTime.hour
  local greetingsTable = {
    [1] = '  Sleep well',
    [2] = '  Good morning',
    [3] = '  Good afternoon',
    [4] = '  Good evening',
    [5] = '望 Good night',
  }
  local greetingIndex = 0
  if hour == 23 or hour < 7 then
    greetingIndex = 1
  elseif hour < 12 then
    greetingIndex = 2
  elseif hour >= 12 and hour < 18 then
    greetingIndex = 3
  elseif hour >= 18 and hour < 21 then
    greetingIndex = 4
  elseif hour >= 21 then
    greetingIndex = 5
  end
  return greetingsTable[greetingIndex] .. ', ' .. name
end

local userName = 'LEIYI'
local greeting = getGreeting(userName)

local greetHeading = {
  type = 'text',
  val = greeting,
  opts = {
    position = 'center',
    hl = 'Keyword',
  },
}

-- get filetype extension
-- example icons.lua
-- return .lua
local function get_extension(fn)
  local match = fn:match('^.+(%..+)$')
  local ext = ''
  if match ~= nil then
    ext = match:sub(2)
  end
  return ext
end

-- get icon base on filetype
-- fn is filename abbration
local function icon(fn)
  local nwd = require('nvim-web-devicons')
  local ext = get_extension(fn)
  return nwd.get_icon(fn, ext, { default = true })
end

local function file_button(filename, shortcut, short_filename)
  short_filename = short_filename or filename
  local icon_txt
  local file_button_highlight_table = {}

  -- add icon highlight
  local icon, icon_highlight_name = icon(filename)
  local icon_highlight_option_type = type(nvim_web_devicons.highlight)

  table.insert(file_button_highlight_table, { icon_highlight_name, 0, 2 })
  icon_txt = icon .. '  '

  local file_button_el = dashboard.button(shortcut, icon_txt .. short_filename, '<cmd>e ' .. filename .. ' <cr>')
  -- highlight match
  local filename_start = short_filename:match('.*[/\\]')
  if filename_start ~= nil then
    table.insert(file_button_highlight_table, { 'Comment', #icon_txt - 2, #filename_start + #icon_txt })
  end
  -- icon button highlight
  file_button_el.opts.hl = file_button_highlight_table
  -- for _, v in ipairs(file_button_highlight_table) do
  --   print(vim.inspect(v))
  -- end
  return file_button_el
end

local default_mru_ignore = { 'gitcommit' }

local mru_opts = {
  ignore = function(path, ext)
    return (string.find(path, 'COMMIT_EDITMSG')) or (vim.tbl_contains(default_mru_ignore, ext))
  end,
}

--- @param start number
--- @param cwd string optional
--- @param items_number number optional number of items to generate, default = 10
local function mru(start, cwd, items_number, opts)
  opts = opts or mru_opts
  items_number = items_number or 9

  local oldfiles = {}
  for _, v in pairs(vim.v.oldfiles) do
    if #oldfiles == items_number then
      break
    end
    local cwd_cond
    if not cwd then
      cwd_cond = true
    else
      cwd_cond = vim.startswith(v, cwd)
    end
    -- filter file to add oldfile list
    local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
    if (vim.fn.filereadable(v) == 1) and cwd_cond and not ignore then
      oldfiles[#oldfiles + 1] = v
    end
  end

  local special_shortcuts = { 'a', 's', 'd' }
  local target_width = 35

  local tbl = {}
  for i, fn in ipairs(oldfiles) do
    local short_fn
    if cwd then
      -- if file in current folder
      -- relative path
      short_fn = vim.fn.fnamemodify(fn, ':.')
    else
      -- absolute path
      short_fn = vim.fn.fnamemodify(fn, ':~')
    end

    if #short_fn > target_width then
      short_fn = path.new(short_fn):shorten(1, { -2, -1 })
      if #short_fn > target_width then
        short_fn = path.new(short_fn):shorten(1, { -1 })
      end
    end

    local shortcut = ''
    if i <= #special_shortcuts then
      shortcut = special_shortcuts[i]
    else
      shortcut = tostring(i + start - 1 - #special_shortcuts)
    end

    -- fn is oldfile list filename
    -- shortcut is button index
    local file_button_el = file_button(fn, ' ' .. shortcut, short_fn)
    tbl[i] = file_button_el
  end
  return {
    type = 'group',
    val = tbl,
    opts = {},
  }
end

local header = {
  type = 'text',
  -- val = {
  --   ' ',
  --   '    ███    ██ ██    ██ ██ ███    ███',
  --   '    ████   ██ ██    ██ ██ ████  ████',
  --   '    ██ ██  ██ ██    ██ ██ ██ ████ ██',
  --   '    ██  ██ ██  ██  ██  ██ ██  ██  ██',
  --   '    ██   ████   ████   ██ ██      ██',
  -- },
  val = {
    "        `       --._    `-._   `-.   `.     :   /  .'   .-'   _.-'    _.--'                 ",
    "        `--.__     `--._   `-._  `-.  `. `. : .' .'  .-'  _.-'   _.--'     __.--'           ",
    "           __    `--.__    `--._  `-._ `-. `. :/ .' .-' _.-'  _.--'    __.--'    __         ",
    "            `--..__   `--.__   `--._ `-._`-.`_=_'.-'_.-' _.--'   __.--'   __..--'           ",
    "          --..__   `--..__  `--.__  `--._`-q(-_-)p-'_.--'  __.--'  __..--'   __..--         ",
    "                ``--..__  `--..__ `--.__ `-'_) (_`-' __.--' __..--'  __..--''               ",
    "          ...___        ``--..__ `--..__`--/__/  --'__..--' __..--''        ___...          ",
    "                ```---...___    ``--..__`_(<_   _/)_'__..--''    ___...---'''               ",
    "           ```-----....._____```---...___(____|_/__)___...---'''_____.....-----'''          ",
    '    ',
    'Virtue is what you do when nobody is looking. The rest is marketing. - Nassim Nicholas Taleb',
  },
  -- val = {
  --   '',
  --   '',
  --   '        ⢀⣴⡾⠃⠄⠄⠄⠄⠄⠈⠺⠟⠛⠛⠛⠛⠻⢿⣿⣿⣿⣿⣶⣤⡀  ',
  --   '      ⢀⣴⣿⡿⠁⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⠄⣸⣿⣿⣿⣿⣿⣿⣿⣷ ',
  --   '     ⣴⣿⡿⡟⡼⢹⣷⢲⡶⣖⣾⣶⢄⠄⠄⠄⠄⠄⢀⣼⣿⢿⣿⣿⣿⣿⣿⣿⣿ ',
  --   '    ⣾⣿⡟⣾⡸⢠⡿⢳⡿⠍⣼⣿⢏⣿⣷⢄⡀⠄⢠⣾⢻⣿⣸⣿⣿⣿⣿⣿⣿⣿ ',
  --   '  ⣡⣿⣿⡟⡼⡁⠁⣰⠂⡾⠉⢨⣿⠃⣿⡿⠍⣾⣟⢤⣿⢇⣿⢇⣿⣿⢿⣿⣿⣿⣿⣿ ',
  --   ' ⣱⣿⣿⡟⡐⣰⣧⡷⣿⣴⣧⣤⣼⣯⢸⡿⠁⣰⠟⢀⣼⠏⣲⠏⢸⣿⡟⣿⣿⣿⣿⣿⣿ ',
  --   ' ⣿⣿⡟⠁⠄⠟⣁⠄⢡⣿⣿⣿⣿⣿⣿⣦⣼⢟⢀⡼⠃⡹⠃⡀⢸⡿⢸⣿⣿⣿⣿⣿⡟ ',
  --   ' ⣿⣿⠃⠄⢀⣾⠋⠓⢰⣿⣿⣿⣿⣿⣿⠿⣿⣿⣾⣅⢔⣕⡇⡇⡼⢁⣿⣿⣿⣿⣿⣿⢣ ',
  --   ' ⣿⡟⠄⠄⣾⣇⠷⣢⣿⣿⣿⣿⣿⣿⣿⣭⣀⡈⠙⢿⣿⣿⡇⡧⢁⣾⣿⣿⣿⣿⣿⢏⣾ ',
  --   ' ⣿⡇⠄⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠟⢻⠇⠄⠄⢿⣿⡇⢡⣾⣿⣿⣿⣿⣿⣏⣼⣿ ',
  --   ' ⣿⣷⢰⣿⣿⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⢰⣧⣀⡄⢀⠘⡿⣰⣿⣿⣿⣿⣿⣿⠟⣼⣿⣿ ',
  --   ' ⢹⣿⢸⣿⣿⠟⠻⢿⣿⣿⣿⣿⣿⣿⣿⣶⣭⣉⣤⣿⢈⣼⣿⣿⣿⣿⣿⣿⠏⣾⣹⣿⣿ ',
  --   ' ⢸⠇⡜⣿⡟⠄⠄⠄⠈⠙⣿⣿⣿⣿⣿⣿⣿⣿⠟⣱⣻⣿⣿⣿⣿⣿⠟⠁⢳⠃⣿⣿⣿ ',
  --   '  ⣰⡗⠹⣿⣄⠄⠄⠄⢀⣿⣿⣿⣿⣿⣿⠟⣅⣥⣿⣿⣿⣿⠿⠋  ⣾⡌⢠⣿⡿⠃ ',
  --   ' ⠜⠋⢠⣷⢻⣿⣿⣶⣾⣿⣿⣿⣿⠿⣛⣥⣾⣿⠿⠟⠛⠉            ',
  --   '',
  --   '',
  -- },
  opts = {
    position = 'center',
    hl = 'Comment',
  },
}

-- Foot must be a table so that its height is correctly measured
local num_plugins_loaded = #vim.fn.globpath(vim.fn.stdpath('data') .. '/site/pack/packer/start', '*', 0, 1)

local section_mru = {
  type = 'group',
  val = {
    {
      type = 'text',
      val = num_plugins_loaded .. ' ' .. '⚡ ' .. '➜ ' .. vim.fn.fnamemodify(vim.fn.getcwd(), ':t'),
      opts = {
        hl = 'Comment',
        shrink_margin = false,
        position = 'center',
      },
    },
    { type = 'padding', val = 1 },
    {
      type = 'group',
      val = function()
        return { mru(1, '', 12) } -- 空字符为全局目录，可以使用 cdir 切换到当前目录的最近编辑文件
      end,
      opts = { shrink_margin = false },
    },
  },
}

local buttons = {
  type = 'group',
  val = {
    { type = 'text', val = 'Quick links', opts = { hl = 'Comment', position = 'center' } },
    { type = 'padding', val = 1 },
    dashboard.button('p', ' ' .. ' Find project', ":lua require('telescope').extensions.projects.projects()<cr>"),
    dashboard.button('f', '  Find file', ':lua require("modules.tools.fancy_telescope").findFiles()<cr>'),
    dashboard.button('t', '  Find text', ':Telescope live_grep<cr>'),
    dashboard.button('e', '  New file', ':ene <BAR><CR>'),
    dashboard.button('u', '  Update plugins', ':PackerSync<cr>'),
    dashboard.button('q', '  Quit', ':qa<cr>'),
  },
  position = 'center',
}

local plugins_count = {
  type = 'text',
  val = { num_plugins_loaded .. ' plugins ﮣ loaded' },
  opts = {
    position = 'center',
    hl = 'Keyword',
  },
}

local opts = {
  layout = {
    { type = 'padding', val = 1 },
    header,
    -- greetHeading,
    { type = 'padding', val = 2 },
    section_mru,
    { type = 'padding', val = 2 },
    buttons,
  },
  opts = {
    margin = 5,
  },
}

alpha.setup(opts)
