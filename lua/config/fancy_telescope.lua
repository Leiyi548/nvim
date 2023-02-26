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

return M
