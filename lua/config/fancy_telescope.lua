-- author: Leiyi548 https://github.com/Leiyi548
-- date: 2023-01-19
-- License: MIT

local M = {}
local themes = require('telescope.themes')
local builtin = require('telescope.builtin')

local file_ignore_patterns = {
  -- disable directory
  'vendor/*',
  'fonts/*',
  '.git/*',
  'node_modules',
  -- diable filetype
  '%.jpg',
  '%.jpeg',
  '%.png',
  '%.svg',
  '%.otf',
  '%.ttf',
  'a.out',
}

local larget_layout_config = {
  bottom_pane = {
    height = 25,
    preview_cutoff = 120,
    prompt_position = 'top',
  },
  center = {
    height = 0.9,
    preview_cutoff = 40,
    prompt_position = 'top',
    width = 0.8,
  },
  cursor = {
    height = 0.9,
    preview_cutoff = 40,
    width = 0.8,
  },
  horizontal = {
    height = 0.9,
    preview_cutoff = 120,
    prompt_position = 'bottom',
    width = 0.8,
  },
  vertical = {
    height = 0.9,
    preview_cutoff = 40,
    prompt_position = 'bottom',
    width = 0.8,
  },
}

function M.find_dotfile()
  local opts = {
    prompt_title = 'Dotfile',
    hidden = true,
    path_display = { 'tail' },
    prompt_position = 'top',
    sorting_strategy = 'ascending',
    -- search_dirs = { '~/.config/nvim', '~/.dotfile' },
    search_dirs = { '~/.config/nvim' },
    previewer = false,
    file_ignore_patterns = {
      'alacritty.scratchpad.yml',
      'polybar/*',
      '__pycache__/*',
      'wallpaper/*',
      'ranger_devicons/*',
      'rime/*',
      'awesome/*',
      'material/*',
      'openvpn/*',
      'fonts/*',
      '.git/*',
      '%.jpg',
      '%.jpeg',
      '%.png',
      '%.svg',
      '%.otf',
      '%.ttf',
    },
  }
  require('vim.highlight').on_yank({ higroup = 'Search', timeout = 60 })
  builtin.find_files(themes.get_dropdown(opts))
end

function M.select_buffers()
  local opts = {
    prompt_title = 'Buffers',
    prompt_position = 'top',
    previewer = false,
    initial_mode = 'normal',
  }
  builtin.buffers(themes.get_dropdown(opts))
end

function M.find_files()
  local opts = {
    prompt_title = 'Files',
    -- path_display = { "smart" },
    previewer = false,
    layout_config = larget_layout_config,
    file_ignore_patterns = file_ignore_patterns,
  }
  builtin.find_files(themes.get_dropdown(opts))
end

-- Smartly opens either git_files or find_files, depending on whether the working directory is
-- contained in a Git repo.
function M.find_project_files(opts)
  opts = opts or {}
  local ok = pcall(builtin.git_files, opts)

  if not ok then
    builtin.find_files(opts)
  end
end

function M.find_recent_files()
  local opts = {
    prompt_title = 'Recent Files',
    path_display = { 'absolute' },
    previewer = false,
    layout_config = larget_layout_config,
    -- file_ignore_patterns = file_ignore_patterns,
  }
  builtin.oldfiles(themes.get_dropdown(opts))
end

function M.git_status()
  local opts = {
    git_icons = {
      -- added = ' ',
      -- changed = ' ',
      added = 'A',
      changed = 'M',
      copied = '>',
      deleted = 'D',
      renamed = '➡',
      unmerged = '',
      untracked = 'U',
      -- untracked = '? ',
    },
  }
  builtin.git_status(opts)
end

function M.findSnippets()
  local opts = {
    prompt_title = 'friendlysnippets',
    search_dirs = {
      '~/.local/share/nvim/lazy/friendly-snippets/snippet',
    },
    path_display = { 'tail' },
    previewer = false,
    file_ignore_patterns = file_ignore_patterns,
  }
  builtin.find_files(themes.get_dropdown(opts))
end

function M.findNotes()
  local opts = {
    prompt_title = 'Notes',
    path_display = { 'smart' },
    search_dirs = {
      '~/NOTE/Now',
    },
    previewer = false,
    file_ignore_patterns = file_ignore_patterns,
    layout_config = larget_layout_config,
  }
  builtin.find_files(themes.get_dropdown(opts))
end

function M.grep_string_visual()
  local visual_selection = function()
    local save_previous = vim.fn.getreg('a')
    vim.api.nvim_command('silent! normal! "ay')
    local selection = vim.fn.trim(vim.fn.getreg('a'))
    vim.fn.setreg('a', save_previous)
    return vim.fn.substitute(selection, [[\n]], [[\\n]], 'g')
  end
  require('telescope.builtin').live_grep({
    default_text = visual_selection(),
  })
end

function M.current_buffer_fuzzy_find_by_visual()
  local visual_selection = function()
    local save_previous = vim.fn.getreg('a')
    vim.api.nvim_command('silent! normal! "ay')
    local selection = vim.fn.trim(vim.fn.getreg('a'))
    vim.fn.setreg('a', save_previous)
    return vim.fn.substitute(selection, [[\n]], [[\\n]], 'g')
  end
  require('telescope.builtin').current_buffer_fuzzy_find({
    default_text = visual_selection(),
  })
end

function M.grep_string_visual_by_filetype()
  local visual_selection = function()
    local save_previous = vim.fn.getreg('a')
    vim.api.nvim_command('silent! normal! "ay')
    local selection = vim.fn.trim(vim.fn.getreg('a'))
    vim.fn.setreg('a', save_previous)
    return vim.fn.substitute(selection, [[\n]], [[\\n]], 'g')
  end
  require('telescope.builtin').live_grep({
    default_text = visual_selection(),
    type_filter = vim.fn.expand('%:e'),
  })
end

function M.grep_string_by_filetype()
  require('telescope.builtin').live_grep({
    prompt_title = 'Search for a specific file type',
    type_filter = vim.fn.input('FireType: '),
  })
end

function M.grep_string_open_files()
  require('telescope.builtin').live_grep({
    prompt_title = 'Grep String in open files',
    grep_open_files = true,
  })
end

function M.buffers()
  local actionstate = require('telescope.actions.state')
  local actions = require('telescope.actions')
  builtin.buffers({
    ignore_current_buffer = false,
    sort_mru = true,
    layout_strategy = 'vertical',
    entry_maker = M.gen_from_buffer({
      bufnr_width = 2,
      sort_mru = true,
    }),
    attach_mappings = function(prompt_bufnr, map)
      local close_buf = function()
        -- local picker = actionstate.get_current_picker(prompt_bufnr)
        local selection = actionstate.get_selected_entry()
        actions.close(prompt_bufnr)
        vim.api.nvim_buf_delete(selection.bufnr, { force = false })
        local state = require('telescope.state')
        local cached_pickers = state.get_global_key('cached_pickers') or {}
        -- remove this picker cache
        table.remove(cached_pickers, 1)
      end

      map('i', '<C-d>', close_buf)
      return true
    end,
  })
end

function M.gen_from_buffer(opts)
  local utils = require('telescope.utils')
  local strings = require('plenary.strings')
  local entry_display = require('telescope.pickers.entry_display')
  local Path = require('plenary.path')
  local make_entry = require('telescope.make_entry')

  opts = opts or {}

  local disable_devicons = opts.disable_devicons

  local icon_width = 0
  if not disable_devicons then
    local icon, _ = utils.get_devicons('fname', disable_devicons)
    icon_width = strings.strdisplaywidth(icon)
  end

  local cwd = vim.fn.expand(opts.cwd or vim.loop.cwd())

  local make_display = function(entry)
    -- bufnr_width + modes + icon + 3 spaces + : + lnum
    opts.__prefix = opts.bufnr_width + 4 + icon_width + 3 + 1 + #tostring(entry.lnum)
    local bufname_tail = utils.path_tail(entry.filename)
    local path_without_tail = require('plenary/strings').truncate(entry.filename, #entry.filename - #bufname_tail, '')
    local path_to_display = utils.transform_path({
      path_display = { 'truncate' },
    }, path_without_tail)
    local bufname_width = strings.strdisplaywidth(bufname_tail)
    local icon, hl_group = utils.get_devicons(entry.filename, disable_devicons)

    local displayer = entry_display.create({
      separator = ' ',
      items = {
        { width = opts.bufnr_width },
        { width = 4 },
        { width = icon_width },
        { width = bufname_width },
        { remaining = true },
      },
    })

    return displayer({
      { entry.bufnr, 'TelescopeResultsNumber' },
      { entry.indicator, 'TelescopeResultsComment' },
      { icon, hl_group },
      bufname_tail,
      { path_to_display .. ':' .. entry.lnum, 'TelescopeResultsComment' },
    })
  end
  return function(entry)
    local bufname = entry.info.name ~= '' and entry.info.name or '[No Name]'
    -- if bufname is inside the cwd, trim that part of the string
    bufname = Path:new(bufname):normalize(cwd)

    local hidden = entry.info.hidden == 1 and 'h' or 'a'
    local readonly = vim.api.nvim_buf_get_option(entry.bufnr, 'readonly') and '=' or ' '
    local changed = entry.info.changed == 1 and '+' or ' '
    local indicator = entry.flag .. hidden .. readonly .. changed
    local lnum = 1

    -- account for potentially stale lnum as getbufinfo might not be updated or from resuming buffers picker
    if entry.info.lnum ~= 0 then
      -- but make sure the buffer is loaded, otherwise line_count is 0
      if vim.api.nvim_buf_is_loaded(entry.bufnr) then
        local line_count = vim.api.nvim_buf_line_count(entry.bufnr)
        lnum = math.max(math.min(entry.info.lnum, line_count), 1)
      else
        lnum = entry.info.lnum
      end
    end

    return make_entry.set_default_entry_mt({
      value = bufname,
      ordinal = entry.bufnr .. ' : ' .. bufname,
      display = make_display,
      bufnr = entry.bufnr,
      filename = bufname,
      lnum = lnum,
      indicator = indicator,
    }, opts)
  end
end

return M
