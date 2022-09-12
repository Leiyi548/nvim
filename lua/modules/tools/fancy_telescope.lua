-- author: Leiyi548 https://github.com/Leiyi548
-- date: 2022-07-18
-- License: MIT

local M = {}
local themes = require('telescope.themes')
local builtin = require('telescope.builtin')

local file_ignore_patterns = {
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

function M.findDotfile()
  local opts = {
    prompt_title = 'Dotfile',
    hidden = true,
    path_display = { 'truncate' },
    prompt_position = 'top',
    sorting_strategy = 'ascending',
    search_dirs = { '~/.config/nvim', '~/.dotfile' },
    previewer = false,
    file_ignore_patterns = file_ignore_patterns,
  }
  builtin.find_files(themes.get_dropdown(opts))
end

-- more information please see :help ls
function M.findBuffers()
  local opts = {
    prompt_title = 'Buffers',
    -- path_display = { 'absolute' },
    prompt_position = 'top',
    previewer = false,
  }
  builtin.buffers(themes.get_dropdown(opts))
end

function M.selectBuffers()
  local opts = {
    prompt_title = 'Buffers',
    prompt_position = 'top',
    previewer = false,
    initial_mode = 'normal',
  }
  builtin.buffers(themes.get_dropdown(opts))
end

function M.showBuffers()
  local opts = {
    prompt_title = 'Buffers',
    -- path_display = { 'smart' },
    prompt_position = 'top',
    previewer = false,
    initial_mode = 'normal',
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
    layout_config = larget_layout_config,
    -- file_ignore_patterns = file_ignore_patterns,
  }
  builtin.find_files(themes.get_dropdown(opts))
end

function M.findRecentFiles()
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
      added = ' ',
      changed = ' ',
      copied = '> ',
      deleted = '✖ ',
      renamed = '➡ ',
      unmerged = ' ',
      untracked = '? ',
    },
  }

  builtin.git_status(opts)
end

function M.findSnippets()
  local opts = {
    prompt_title = 'friendlysnippets',
    search_dirs = {
      '~/.local/share/nvim/site/pack/packer/start/friendly-snippets',
      -- '~/.config/nvim/snippets',
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
    search_dirs = {
      '~/NOTE/Now',
    },
    previewer = false,
    file_ignore_patterns = file_ignore_patterns,
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

return M
