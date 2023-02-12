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
        -- ['<C-j>'] = actions.move_selection_next,
        -- ['<C-k>'] = actions.move_selection_previous,
        ['<C-j>'] = actions.cycle_history_next,
        ['<C-k>'] = actions.cycle_history_prev,
        ['<PageUp>'] = actions.preview_scrolling_up,
        ['<PageDown>'] = actions.preview_scrolling_down,
        ['<C-b>'] = actions.preview_scrolling_up,
        ['<C-f>'] = actions.preview_scrolling_down,
        -- ['<C-y>'] = actions.which_key,
        ['<C-y>'] = actions.smart_send_to_qflist + actions.open_qflist,
        ['<tab>'] = actions.toggle_selection + actions.move_selection_next,
        ['<S-tab>'] = actions.toggle_selection + actions.move_selection_previous,
        -- telescope mulitopen
        -- more information please see https://github.com/rebelot/dotfiles/blob/master/nvim/lua/plugins/telescope.lua
        ['<C-v>'] = stopinsert(custom_actions.multi_selection_open_vertical),
        ['<C-s>'] = stopinsert(custom_actions.multi_selection_open_horizontal),
        ['<C-t>'] = stopinsert(custom_actions.multi_selection_open_tab),
        ['<C-l>'] = stopinsert(custom_actions.multi_selection_open),
        ['<cr>'] = stopinsert(custom_actions.multi_selection_open),
        -- add mouse click support
        -- not where I want
        ['<RightMouse>'] = actions.close,
        -- ['<LeftMouse>'] = actions.select_default,
        ['<ScrollWheelDown>'] = actions.move_selection_next,
        ['<ScrollWheelUp>'] = actions.move_selection_previous,
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
        ['<C-j>'] = actions.cycle_history_next,
        ['<C-k>'] = actions.cycle_history_prev,
        ['<C-n>'] = actions.move_selection_next,
        ['<C-p>'] = actions.move_selection_previous,
        ['<PageUp>'] = actions.preview_scrolling_up,
        ['<PageDown>'] = actions.preview_scrolling_down,
        ['<tab>'] = actions.toggle_selection + actions.move_selection_next,
        ['<S-tab>'] = actions.toggle_selection + actions.move_selection_previous,
        ['<C-y>'] = actions.smart_send_to_qflist + actions.open_qflist,
        -- telescope mulitopen
        -- more information please see https://github.com/rebelot/dotfiles/blob/master/nvim/lua/plugins/telescope.lua
        ['<C-v>'] = custom_actions.multi_selection_open_vertical,
        ['<C-s>'] = custom_actions.multi_selection_open_horizontal,
        ['<C-t>'] = custom_actions.multi_selection_open_tab,
        ['<C-l>'] = custom_actions.multi_selection_open,
        ['o'] = custom_actions.multi_selection_open,
        ['<cr>'] = custom_actions.multi_selection_open,
      },
    },
  },
  -- reference: https://github.com/dhruvmanila/dotfiles/blob/master/config/nvim/lua/dm/plugins/telescope/init.lua
  pickers = {
    live_grep = {
      --@usage don't include the filename in the search results
      only_sort_text = true,
      theme = 'dropdown',
      layout_config = {
        width = 0.8,
        height = 0.5,
      },
    },
    find_files = {
      theme = 'dropdown',
    },
    git_status = {
      layout_strategy = 'vertical',
    },
    git_commits = {
      layout_strategy = 'vertical',
      mappings = {
        i = {
          -- checkout commit
          ['<C-o>'] = actions.git_checkout,
          -- 复制 commit 信息
          ['<cr>'] = function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            if selection == nil then
              vim.notify('没有可以选择的 commit')
            else
              actions.close(prompt_bufnr)
              -- yanks the additions from the currently selected undo state into the default register
              vim.fn.setreg(require('utils').get_default_register(), selection.msg)
              vim.notify('复制成功 commit message: ' .. selection.msg)
            end
          end,
          -- 复制 commit hash 值
          ['<C-v>'] = function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            if selection == nil then
              vim.notify('没有可以选择的 commit')
            else
              actions.close(prompt_bufnr)
              -- yanks the additions from the currently selected undo state into the default register
              vim.fn.setreg(require('utils').get_default_register(), selection.value)
              vim.notify('复制成功 commit hash: ' .. selection.value)
            end
          end,
        },
        n = {
          -- checkout commit
          ['<C-o>'] = actions.git_checkout,
          -- 复制 commit 信息
          ['<cr>'] = function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            if selection == nil then
              vim.notify('没有可以选择的 commit')
            else
              actions.close(prompt_bufnr)
              vim.fn.setreg(require('utils').get_default_register(), selection.msg)
              vim.notify('复制成功 commit message: ' .. selection.msg)
            end
          end,
          -- 复制 commit hash 值
          ['<C-v>'] = function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            if selection == nil then
              vim.notify('没有可以选择的 commit')
            else
              actions.close(prompt_bufnr)
              vim.fn.setreg(require('utils').get_default_register(), selection.value)
              vim.notify('复制成功 commit hash: ' .. selection.value)
            end
          end,
        },
      },
    },
    git_bcommits = {
      layout_strategy = 'vertical',
    },
    quickfix = {
      layout_strategy = 'vertical',
    },
    buffers = {
      sort_lastused = true,
      sort_mru = true,
      ignore_current_buffer = false,
      theme = 'dropdown',
      previewer = false,
      mappings = {
        i = { ['<C-d>'] = actions.delete_buffer },
        n = {
          ['d'] = actions.delete_buffer,
          ['<C-d>'] = actions.delete_buffer,
        },
      },
    },
    lsp_definitions = {
      theme = 'dropdown',
    },
    lsp_references = {
      theme = 'dropdown',
    },
    lsp_document_symbols = {
      theme = 'dropdown',
    },
    lsp_workspace_symbols = {
      theme = 'dropdown',
    },
    marks = {
      theme = 'dropdown',
    },
    colorscheme = {
      theme = 'dropdown',
      previewer = false,
    },
    builtin = {
      theme = 'dropdown',
      layout_config = {
        width = 0.5,
        height = 0.5,
      },
      include_extensions = true,
      use_default_opts = true,
    },
    git_files = {
      theme = 'dropdown',
      show_untracked = true,
      layout_config = {
        width = 0.88,
        height = 0.5,
      },
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
    undo = {
      use_delta = true,
      initial_mode = 'normal',
      theme = 'dropdown',
      use_custom_command = nil, -- setting this implies `use_delta = false`. Accepted format is: { "bash", "-c", "echo '$DIFF' | delta" }
      side_by_side = false,
      layout_strategy = 'vertical',
      diff_context_lines = vim.o.scrolloff,
      entry_format = 'state #$ID, $STAT, $TIME',
      mappings = {
        i = {
          ['<cr>'] = require('telescope-undo.actions').restore,
          ['<C-s>'] = require('telescope-undo.actions').yank_deletions,
          ['<C-v>'] = require('telescope-undo.actions').yank_additions,
        },
        n = {
          ['o'] = require('telescope-undo.actions').restore,
          ['<cr>'] = require('telescope-undo.actions').restore,
          ['ya'] = require('telescope-undo.actions').yank_additions,
          ['yd'] = require('telescope-undo.actions').yank_deletions,
          ['<C-s>'] = require('telescope-undo.actions').yank_deletions,
          ['<C-v>'] = require('telescope-undo.actions').yank_additions,
        },
      },
    },
  },
})
require('telescope').load_extension('fzf')
require('telescope').load_extension('projects')
require('telescope').load_extension('undo')
