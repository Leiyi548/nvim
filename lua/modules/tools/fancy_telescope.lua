-- author: Leiyi548 https://github.com/Leiyi548
-- date: 2022-07-18
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
  if not packer_plugins['telescope.nvim'].loaded then
    vim.cmd([[packadd telescope.nvim]])
  end
  local opts = {
    prompt_title = 'Dotfile',
    hidden = true,
    path_display = { 'truncate' },
    prompt_position = 'top',
    sorting_strategy = 'ascending',
    search_dirs = { '~/.config/nvim', '~/.dotfile' },
    previewer = false,
    layout_config = larget_layout_config,
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
  builtin.find_files(themes.get_dropdown(opts))
end

function M.findBuffers()
  local opts = {
    prompt_title = 'Buffers',
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

function M.findFiles()
  local opts = {
    prompt_title = 'Files',
    -- path_display = { "smart" },
    previewer = false,
    layout_config = larget_layout_config,
    file_ignore_patterns = file_ignore_patterns,
  }
  builtin.find_files(opts)
end

function M.findRecentFiles()
  local opts = {
    prompt_title = 'Recent Files',
    path_display = { 'absolute' },
    previewer = false,
    layout_config = larget_layout_config,
    initial_mode = 'normal',
    -- file_ignore_patterns = file_ignore_patterns,
  }
  builtin.oldfiles(themes.get_dropdown(opts))
end

function M.git_status()
  local opts = {
    git_icons = {
      -- added = ' ',
      -- changed = ' ',
      added = '+ ',
      changed = 'M ',
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

function M.findGoSource()
  local opts = {
    prompt_title = 'Find In Go Root',
    result_title = 'Go Source Code',
    find_command = {
      'rg',
      '--files',
      '-t',
      'go',
    },
    path_display = { 'smart' },
    search_dirs = {
      '/usr/local/go',
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

function M.grep_string_by_type()
  require('telescope.builtin').live_grep({
    prompt_title = 'Search for a specific file type',
    type_filter = vim.fn.input('Type:'),
  })
end

return M
