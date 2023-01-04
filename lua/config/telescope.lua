local telescope_ok, telescope = pcall(require, 'telescope')
if not telescope_ok then
  return
end
local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local transform_mod = require('telescope.actions.mt').transform_mod
local function multiopen(prompt_bufnr, method)
  local edit_file_cmd_map = {
    vertical = 'vsplit',
    horizontal = 'split',
    tab = 'tabedit',
    default = 'edit',
  }
  local edit_buf_cmd_map = {
    vertical = 'vert sbuffer',
    horizontal = 'sbuffer',
    tab = 'tab sbuffer',
    default = 'buffer',
  }
  local picker = action_state.get_current_picker(prompt_bufnr)
  local multi_selection = picker:get_multi_selection()

  if #multi_selection > 1 then
    require('telescope.pickers').on_close_prompt(prompt_bufnr)
    pcall(vim.api.nvim_set_current_win, picker.original_win_id)

    for i, entry in ipairs(multi_selection) do
      local filename, row, col

      if entry.path or entry.filename then
        filename = entry.path or entry.filename

        row = entry.row or entry.lnum
        col = vim.F.if_nil(entry.col, 1)
      elseif not entry.bufnr then
        local value = entry.value
        if not value then
          return
        end

        if type(value) == 'table' then
          value = entry.display
        end

        local sections = vim.split(value, ':')

        filename = sections[1]
        row = tonumber(sections[2])
        col = tonumber(sections[3])
      end

      local entry_bufnr = entry.bufnr

      if entry_bufnr then
        if not vim.api.nvim_buf_get_option(entry_bufnr, 'buflisted') then
          vim.api.nvim_buf_set_option(entry_bufnr, 'buflisted', true)
        end
        local command = i == 1 and 'buffer' or edit_buf_cmd_map[method]
        pcall(vim.cmd, string.format('%s %s', command, vim.api.nvim_buf_get_name(entry_bufnr)))
      else
        local command = i == 1 and 'edit' or edit_file_cmd_map[method]
        if vim.api.nvim_buf_get_name(0) ~= filename or command ~= 'edit' then
          filename = require('plenary.path'):new(vim.fn.fnameescape(filename)):normalize(vim.loop.cwd())
          pcall(vim.cmd, string.format('%s %s', command, filename))
        end
      end

      if row and col then
        pcall(vim.api.nvim_win_set_cursor, 0, { row, col })
      end
    end
  else
    actions['select_' .. method](prompt_bufnr)
  end
end

local custom_actions = transform_mod({
  multi_selection_open_vertical = function(prompt_bufnr)
    multiopen(prompt_bufnr, 'vertical')
  end,
  multi_selection_open_horizontal = function(prompt_bufnr)
    multiopen(prompt_bufnr, 'horizontal')
  end,
  multi_selection_open_tab = function(prompt_bufnr)
    multiopen(prompt_bufnr, 'tab')
  end,
  multi_selection_open = function(prompt_bufnr)
    multiopen(prompt_bufnr, 'default')
  end,
})

local function stopinsert(callback)
  return function(prompt_bufnr)
    vim.cmd.stopinsert()
    vim.schedule(function()
      callback(prompt_bufnr)
    end)
  end
end

telescope.setup({
  defaults = {
    -- path_display = { 'truncate' }, -- hidden tail absolute smart shorten truncate
    dynamic_preview_title = true, -- 动态更改预览窗口的名称 例如:预览窗口可以显示完整的文件名
    prompt_prefix = ' ', --     
    selection_caret = '➤ ', -- ➤  
    selection_strategy = 'reset', -- Determines how the cursor acts after each sort iteration.
    sorting_strategy = 'ascending', -- 按照升序排序
    entry_prefix = ' ',
    initial_mode = 'insert',
    file_sorter = require('telescope.sorters').get_fuzzy_file,
    generic_sorter = require('telescope.sorters').get_generic_fuzzy_sorter,
    winblend = 0, -- Transparency
    layout_config = {
      horizontal = { prompt_position = 'top', results_width = 0.6 },
      vertical = { mirror = false },
    },
    preview = {
      -- filesize_limit:The maximum file size in MB attempted to be previewed.
      -- Set to false to attempt to preview any file size.
      -- Default: 25
      filesize_limit = 5,
      -- timeout:Timeout the previewer if the preview did not
      -- complete within `timeout` milliseconds.
      -- Set to false to not timeout preview.
      -- Default: 250
      timeout = 300,
      treesitter = true,
    },
    history = {
      -- path:The path to the telescope history as string. default: stdpath("data")/telescope_history
      -- path = defaults (~/.local/share/nvim/telescope_history)
      -- limit:   The amount of entries that will be written in the history.
      limit = 100,
    },
    file_previewer = require('telescope.previewers').vim_buffer_cat.new,
    grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
    qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
    file_ignore_patterns = {
      '^static/*',
      'node_modules/*',
    },
    mappings = {
      i = {
        ['<C-c>'] = actions.close,
        ['<Up>'] = actions.move_selection_previous,
        ['<Down>'] = actions.move_selection_next,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['<PageUp>'] = actions.preview_scrolling_up,
        ['<PageDown>'] = actions.preview_scrolling_down,
        ['<C-b>'] = actions.preview_scrolling_up,
        ['<C-f>'] = actions.preview_scrolling_down,
        ['<C-y>'] = actions.which_key,
        ['<tab>'] = actions.toggle_selection + actions.move_selection_next,
        ['<S-tab>'] = actions.toggle_selection + actions.move_selection_previous,
        -- telescope mulitopen
        -- more information please see https://github.com/rebelot/dotfiles/blob/master/nvim/lua/plugins/telescope.lua
        ['<C-v>'] = stopinsert(custom_actions.multi_selection_open_vertical),
        ['<C-s>'] = stopinsert(custom_actions.multi_selection_open_horizontal),
        ['<C-t>'] = stopinsert(custom_actions.multi_selection_open_tab),
        ['<cr>'] = stopinsert(custom_actions.multi_selection_open),
      },
      n = {
        ['<esc>'] = actions.close,
        ['<C-c>'] = actions.close,
        ['q'] = actions.close,
        ['?'] = actions.which_key,
        ['<Up>'] = actions.move_selection_previous,
        ['<Down>'] = actions.move_selection_next,
        -- ['<C-j>'] = actions.move_selection_next,
        -- ['<C-k>'] = actions.move_selection_previous,
        ['<C-n>'] = actions.move_selection_next,
        ['<C-p>'] = actions.move_selection_previous,
        ['<PageUp>'] = actions.preview_scrolling_up,
        ['<PageDown>'] = actions.preview_scrolling_down,
        ['<tab>'] = actions.toggle_selection + actions.move_selection_next,
        ['<S-tab>'] = actions.toggle_selection + actions.move_selection_previous,
        -- telescope mulitopen
        -- more information please see https://github.com/rebelot/dotfiles/blob/master/nvim/lua/plugins/telescope.lua
        ['<C-v>'] = custom_actions.multi_selection_open_vertical,
        ['<C-s>'] = custom_actions.multi_selection_open_horizontal,
        ['<C-t>'] = custom_actions.multi_selection_open_tab,
        ['<cr>'] = custom_actions.multi_selection_open,
        ['<C-j>'] = custom_actions.multi_selection_open,
      },
    },
  },
  -- reference: https://github.com/dhruvmanila/dotfiles/blob/master/config/nvim/lua/dm/plugins/telescope/init.lua
  pickers = {
    live_grep = {
      --@usage don't include the filename in the search results
      only_sort_text = true,
      theme = 'dropdown',
    },
    find_files = {
      theme = 'dropdown',
    },
    buffers = {
      sort_lastused = true,
      sort_mru = true,
      ignore_current_buffer = false,
      theme = 'dropdown',
      previewer = false,
      mappings = {
        i = { ['<C-d>'] = actions.delete_buffer },
        n = { ['d'] = actions.delete_buffer },
      },
    },
    builtin = {
      theme = 'dropdown',
      layout_config = {
        width = 50,
        height = 0.5,
      },
      include_extensions = true,
      use_default_opts = true,
    },
    git_files = {
      show_untracked = true,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    coc = {
      theme = 'ivy',
      prefer_locations = true, -- always use Telescope locations to preview definitions/declarations/implementations etc
    },
  },
})
require('telescope').load_extension('fzf')
require('telescope').load_extension('projects')
require('telescope').load_extension('coc')
