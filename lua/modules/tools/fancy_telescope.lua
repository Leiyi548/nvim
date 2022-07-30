-- author: Leiyi548 https://github.com/Leiyi548
-- date: 2022-07-18
-- License: MIT

local M = {}
local action_state = require('telescope.actions.state')
local actions = require('telescope.actions')
local action_set = require('telescope.actions.set')
local sorters = require('telescope.sorters')
local pickers = require('telescope.pickers')
local themes = require('telescope.themes')
local builtin = require('telescope.builtin')
local finders = require('telescope.finders')
local conf = require('telescope.config').values

local file_ignore_patterns = {
  'vendor/*',
  'font/*',
  '.git/*',
  'node_modules',
  '%.jpg',
  '%.jpeg',
  '%.png',
  '%.svg',
  '%.otf',
  '%.ttf',
}

function M.findDotfile()
  local opts = {
    prompt_title = 'Dotfile',
    hidden = true,
    path_display = { 'absolute' },
    prompt_position = 'top',
    sorting_strategy = 'ascending',
    search_dirs = { '~/.config/nvim','~/.dotfile' },
    previewer = false,
    layout_config = {
      width = 0.5,
      height = 0.8,
      horizontal = { width = { padding = 0.15 } },
      vertical = { preview_height = 0.75 },
    },
    file_ignore_patterns = file_ignore_patterns,
  }
  builtin.find_files(themes.get_dropdown(opts))
end

function M.findBuffers()
  local opts = {
    prompt_title = 'Buffers',
    path_display = { 'absolute' },
    prompt_position = 'top',
    previewer = false,
    layout_config = {
      width = 0.5,
      height = 0.5,
      horizontal = { width = { padding = 0.15 } },
      vertical = { preview_height = 0.75 },
    },
  }
  builtin.buffers(themes.get_dropdown(opts))
end

function M.findFiles()
  local opts = {
    prompt_title = 'Files',
    -- path_display = { "smart" },
    previewer = false,
    layout_config = {
      width = 0.5,
      height = 0.5,
      horizontal = { width = { padding = 0.15 } },
      vertical = { preview_height = 0.75 },
    },
    file_ignore_patterns = file_ignore_patterns,
  }
  builtin.find_files(themes.get_dropdown(opts))
end

function M.findRecentFiles()
  local opts = {
    prompt_title = 'Recent Files',
    path_display = { 'absolute' },
    previewer = false,
    layout_config = {
      width = 0.5,
      height = 0.5,
      horizontal = { width = { padding = 0.15 } },
      vertical = { preview_height = 0.75 },
    },
    file_ignore_patterns = file_ignore_patterns,
  }
  builtin.oldfiles(themes.get_dropdown(opts))
end

function M.git_status()
  local opts = themes.get_dropdown({
    winblend = 10,
    border = true,
    previewer = false,
    shorten_path = false,
  })

  -- Can change the git icons using this.
  opts.git_icons = {
    added = 'A',
    changed = 'M',
    copied = '>',
    deleted = 'D',
    renamed = '➡',
    unmerged = '',
    untracked = '?',
  }

  builtin.git_status(opts)
end

function M.findConfiguration()
  local opts = {
    prompt_title = 'configuration',
    search_dirs = {
      '/mnt/c/Users/9/AppData/Roaming/alacritty',
    },
    -- path_display = { "smart" },
    previewer = false,
    layout_config = {
      width = 0.5,
      height = 0.5,
      horizontal = { width = { padding = 0.15 } },
      vertical = { preview_height = 0.75 },
    },
    file_ignore_patterns = file_ignore_patterns,
  }
  builtin.find_files(themes.get_dropdown(opts))
end

return M
