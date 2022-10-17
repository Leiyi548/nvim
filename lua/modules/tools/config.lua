---@diagnostic disable: undefined-doc-name
-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local config = {}

function config.telescope()
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
      grep_string = {
        only_sort_text = true,
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
          n = { ['dd'] = actions.delete_buffer },
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
        theme = 'dropdown',
        hidden = true,
        previewer = false,
        show_untracked = true,
      },
      lsp_references = {
        theme = 'dropdown',
        initial_mode = 'normal',
      },
      lsp_definitions = {
        theme = 'dropdown',
        initial_mode = 'normal',
      },
      lsp_declarations = {
        theme = 'dropdown',
        initial_mode = 'normal',
      },
      lsp_implementations = {
        theme = 'dropdown',
        initial_mode = 'normal',
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
      project = {
        base_dirs = {
          -- '~/dev/src',
          -- { '~/dev/src2' },
          -- { '~/dev/src3', max_depth = 4 },
          -- { path = '~/dev/src4' },
          -- { path = '~/dev/src5', max_depth = 2 },
        },
        hidden_files = true, -- default: false
        theme = 'dropdown',
      },
      -- ["ui-select"] = {
      -- require("telescope.themes").get_dropdown {
      --   -- even more opts
      -- }
    },
  })
  require('telescope').load_extension('fzf')
  require('telescope').load_extension('projects')
  require('telescope').load_extension('ui-select')
end

function config.project()
  require('project_nvim').setup({
    -- Manual mode doesn't automatically change your root directory, so you have
    -- the option to manually do so using `:ProjectRoot` command.
    manual_mode = false,

    -- Methods of detecting the root directory. **"lsp"** uses the native neovim
    -- lsp, while **"pattern"** uses vim-rooter like glob pattern matching. Here
    -- order matters: if one is not detected, the other is used as fallback. You
    -- can also delete or rearangne the detection methods.
    detection_methods = { 'lsp', 'pattern' },

    -- All the patterns used to detect root dir, when **"pattern"** is in
    -- detection_methods
    patterns = { '.git', '_darcs', '.hg', '.bzr', '.svn', 'Makefile', 'package.json' },

    -- Table of lsp clients to ignore by name
    -- eg: { "efm", ... }
    ignore_lsp = {},

    -- Don't calculate root dir on specific directories
    -- Ex: { "~/.cargo/*", ... }
    exclude_dirs = {},

    -- Show hidden files in telescope
    show_hidden = false,

    -- When set to false, you will get a message when project.nvim changes your
    -- directory.
    silent_chdir = true,

    -- Path where project.nvim will store the project history for use in
    -- telescope
    datapath = vim.fn.stdpath('data'),
  })
end

function config.whichkey()
  require('modules.tools.whichkey')
end

function config.toggleterm()
  local ok, toggleterm = pcall(require, 'toggleterm')
  if not ok then
    return
  end

  toggleterm.setup({
    size = 20,
    open_mapping = [[<C-\>]],
    hide_numbers = true,
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 2,
    start_in_insert = true,
    insert_mappings = true,
    persist_size = true,
    direction = 'float',
    close_on_exit = true,
    shell = vim.o.shell,
    float_opts = {
      border = 'curved',
      winblend = 0,
      highlights = {
        border = 'Normal',
        background = 'Normal',
      },
    },
  })

  function _G.set_terminal_keymaps()
    local opts = { noremap = true }
    vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
    -- vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    -- vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    -- vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    -- 终端下的<C-l>清屏快捷键冲突
    -- vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
    -- vim.api.nvim_buf_set_keymap(1, 't', '<M-k>', [[<C-\><C-n><C-W>k]], opts)
    -- vim.api.nvim_buf_set_keymap(0, 't', '<M-h>', [[<C-\><C-n><C-W>l]], opts)
    -- vim.api.nvim_buf_set_keymap(0, 't', '<M-l>', '<cmd>ToggleTerm size=10 direction=horizontal<cr>', opts)
    -- vim.api.nvim_buf_set_keymap(0, 't', '<M-v>', '<cmd>ToggleTerm size=80 direction=vertical<cr>', opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<M-i>', '<cmd>ToggleTerm direction=float<cr>', opts)
  end

  vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

  local Terminal = require('toggleterm.terminal').Terminal

  local lazygit = Terminal:new({
    cmd = 'lazygit',
    hidden = true,
    direction = 'float',
    on_open = function(term)
      vim.cmd('startinsert!')
      vim.api.nvim_buf_set_keymap(0, 't', '<esc>', '<cmd>close<CR>', { silent = false, noremap = true })
      if vim.fn.mapcheck('<esc>', 't') ~= '' then
        vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<esc>')
      end
    end,
  })

  function _LAZYGIT_TOGGLE()
    lazygit:toggle()
  end

  local ranger = Terminal:new({
    cmd = 'ranger',
    hidden = true,
    direction = 'float',
    on_open = function(term)
      vim.cmd('startinsert!')
      vim.api.nvim_buf_set_keymap(0, 't', '<esc>', '<cmd>close<CR>', { silent = false, noremap = true })
      if vim.fn.mapcheck('<esc>', 't') ~= '' then
        vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<esc>')
      end
    end,
  })

  function _RANGER_TOGGLE()
    ranger:toggle()
  end

  local gotop = Terminal:new({
    cmd = 'gotop',
    hidden = true,
    direction = 'float',
    on_open = function(term)
      vim.cmd('startinsert!')
      vim.api.nvim_buf_set_keymap(0, 't', '<esc>', '<cmd>close<CR>', { silent = false, noremap = true })
      if vim.fn.mapcheck('<esc>', 't') ~= '' then
        vim.api.nvim_buf_del_keymap(term.bufnr, 't', '<esc>')
      end
    end,
  })

  function _GOTOP_TOGGLE()
    gotop:toggle()
  end

  local node = Terminal:new({
    cmd = 'node',
    hidden = true,
    direction = 'float',
    on_open = function(term)
      vim.cmd('startinsert!')
      vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
    end,
  })
  function _NODE_TOGGLE()
    node:toggle()
  end

  local python = Terminal:new({
    cmd = 'python3',
    hidden = true,
    direction = 'float',
    on_open = function(term)
      vim.cmd('startinsert!')
      vim.api.nvim_buf_set_keymap(term.bufnr, 'n', 'q', '<cmd>close<CR>', { noremap = true, silent = true })
    end,
  })
  function _PYTHON_TOGGLE()
    python:toggle()
  end
end

function config.Comment()
  local Comment_ok, Comment = pcall(require, 'Comment')
  if not Comment_ok then
    return
  end

  Comment.setup({
    ---Add a space b/w comment and the line
    ---@type boolean|fun():boolean
    padding = true,

    ---Whether the cursor should stay at its position
    ---NOTE: This only affects NORMAL mode mappings and doesn't work with dot-repeat
    ---@type boolean
    sticky = true,

    ---Lines to be ignored while comment/uncomment.
    ---Could be a regex string or a function that returns a regex string.
    ---Example: Use '^$' to ignore empty lines
    ---@type string|fun():string
    ignore = nil,

    ---LHS of toggle mappings in NORMAL + VISUAL mode
    ---@type table
    toggler = {
      ---Line-comment toggle keymap
      line = 'gcc',
      ---Block-comment toggle keymap
      block = 'gbc',
    },

    ---LHS of operator-pending mappings in NORMAL + VISUAL mode
    ---@type table
    opleader = {
      ---Line-comment keymap
      line = 'gc',
      ---Block-comment keymap
      block = 'gb',
    },

    ---LHS of extra mappings
    ---@type table
    extra = {
      ---Add comment on the line above
      above = 'gcO',
      ---Add comment on the line below
      below = 'gco',
      ---Add comment at the end of line
      eol = 'gcA',
    },

    ---Create basic (operator-pending) and extended mappings for NORMAL + VISUAL mode
    ---NOTE: If `mappings = false` then the plugin won't create any mappings
    ---@type boolean|table
    mappings = {
      ---Operator-pending mapping
      ---Includes `gcc`, `gbc`, `gc[count]{motion}` and `gb[count]{motion}`
      ---NOTE: These mappings can be changed individually by `opleader` and `toggler` config
      basic = true,
      ---Extra mapping
      ---Includes `gco`, `gcO`, `gcA`
      extra = true,
      ---Extended mapping
      ---Includes `g>`, `g<`, `g>[count]{motion}` and `g<[count]{motion}`
      extended = false,
    },

    ---Pre-hook, called before commenting the line
    ---@type fun(ctx: CommentCtx):string
    pre_hook = nil,

    ---Post-hook, called after commenting is done
    ---@type fun(ctx: CommentCtx)
    post_hook = nil,
  })
end

function config.todo_comments()
  local todo_comments_ok, todo_comments = pcall(require, 'todo-comments')
  if not todo_comments_ok then
    return
  end

  local icons = require('modules.ui.icons')

  local error_red = '#F44747'
  local warning_orange = '#ff8800'
  local info_yellow = '#FFCC66'
  local hint_blue = '#4FC1FF'
  local perf_purple = '#7C3AED'
  -- local note_green = '#10B981'

  todo_comments.setup({
    signs = true, -- show icons in the signs column
    sign_priority = 10, -- sign priority
    -- keywords recognized as todo comments
    keywords = {
      FIX = {
        icon = icons.ui.Bug, -- icon used for the sign, and in search results
        color = error_red, -- can be a hex color, or a named color (see below)
        alt = { 'FIXME', 'BUG', 'FIXIT', 'ISSUE' }, -- a set of other keywords that all map to this FIX keywords
        -- signs = false, -- configure signs for some keywords individually
      },
      TODO = { icon = icons.ui.Check, color = hint_blue, alt = { 'TIP' } },
      HACK = { icon = icons.ui.Fire, color = warning_orange },
      WARN = { icon = icons.diagnostics.Warning, color = warning_orange, alt = { 'WARNING', 'XXX' } },
      PERF = { icon = icons.ui.Dashboard, color = perf_purple, alt = { 'OPTIM', 'PERFORMANCE', 'OPTIMIZE' } },
      NOTE = { icon = icons.ui.Note, color = info_yellow, alt = { 'INFO' } },
    },
    -- merge_keywords = true, -- when true, custom keywords will be merged with the defaults
    -- highlighting of the line containing the todo comment
    -- * before: highlights before the keyword (typically comment characters)
    -- * keyword: highlights of the keyword
    -- * after: highlights after the keyword (todo text)
    highlight = {
      before = '', -- "fg" or "bg" or empty
      -- keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
      keyword = 'fg', -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
      after = 'fg', -- "fg" or "bg" or empty
      pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
      comments_only = true, -- uses treesitter to match keywords in comments only
      max_line_len = 400, -- ignore lines longer than this
      exclude = {}, -- list of file types to exclude highlighting
    },
    -- list of named colors where we try to extract the guifg from the
    -- list of hilight groups or use the hex color if hl not found as a fallback
    -- colors = {
    --   error = { "LspDiagnosticsDefaultError", "ErrorMsg", "#DC2626" },
    --   warning = { "LspDiagnosticsDefaultWarning", "WarningMsg", "#FBBF24" },
    --   info = { "LspDiagnosticsDefaultInformation", "#2563EB" },
    --   hint = { "LspDiagnosticsDefaultHint", "#10B981" },
    --   default = { "Identifier", "#7C3AED" },
    -- },
    search = {
      command = 'rg',
      args = {
        '--color=never',
        '--no-heading',
        '--with-filename',
        '--line-number',
        '--column',
      },
      -- regex that will be used to match keywords.
      -- don't replace the (KEYWORDS) placeholder
      pattern = [[\b(KEYWORDS):]], -- ripgrep regex
      -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
    },
  })
end

function config.gitsigns()
  local gitsigns_ok, gitsigns = pcall(require, 'gitsigns')
  if not gitsigns_ok then
    return
  end

  gitsigns.setup({
    signs = {
      add = { hl = 'GitSignsAdd', text = '▎', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
      change = { hl = 'GitSignsChange', text = '▎', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
      changedelete = {
        hl = 'GitSignsChange',
        text = '▎',
        numhl = 'GitSignsChangeNr',
        linehl = 'GitSignsChangeLn',
      },
      -- delete = { hl = "GitSignsDelete", text = "", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      -- topdelete = { hl = "GitSignsDelete", text = "‾", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
      delete = { hl = 'GitSignsDelete', text = '', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
      topdelete = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
    },
    signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
    numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
    linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
    word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
    watch_gitdir = {
      interval = 1000,
      follow_files = true,
    },
    attach_to_untracked = true,
    current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
    current_line_blame_opts = {
      virt_text = true,
      virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
      delay = 1000,
      ignore_whitespace = false,
    },
    current_line_blame_formatter_opts = {
      relative_time = true,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> • <summary>',
    -- current_line_blame_formatter = "<author>, <author_time> • <summary>",
    sign_priority = 6,
    update_debounce = 100,
    status_formatter = nil, -- Use default
    max_file_length = 40000,
    preview_config = {
      -- Options passed to nvim_open_win
      border = 'single',
      style = 'minimal',
      relative = 'cursor',
      row = 0,
      col = 1,
    },
    yadm = {
      enable = false,
    },
  })
end

function config.spctre()
  require('spectre').setup({

    color_devicons = true,
    open_cmd = 'vnew',
    live_update = false, -- auto excute search again when you write any file in vim
    line_sep_start = '┌-----------------------------------------',

    result_padding = '¦  ',
    line_sep = '└-----------------------------------------',
    highlight = {
      ui = 'String',
      search = 'DiffChange',
      replace = 'DiffDelete',
    },
    mapping = {
      ['toggle_line'] = {
        map = 'dd',
        cmd = "<cmd>lua require('spectre').toggle_line()<CR>",
        desc = 'toggle current item',
      },

      ['enter_file'] = {
        map = '<cr>',
        cmd = "<cmd>lua require('spectre.actions').select_entry()<CR>",
        desc = 'goto current file',
      },
      ['send_to_qf'] = {
        map = '<leader>q',
        cmd = "<cmd>lua require('spectre.actions').send_to_qf()<CR>",
        desc = 'send all item to quickfix',
      },
      ['replace_cmd'] = {
        map = '<leader>c',

        cmd = "<cmd>lua require('spectre.actions').replace_cmd()<CR>",
        desc = 'input replace vim command',
      },
      ['show_option_menu'] = {
        map = '<leader>o',
        cmd = "<cmd>lua require('spectre').show_options()<CR>",
        desc = 'show option',
      },
      ['run_current_replace'] = {
        map = '<leader>rc',
        cmd = "<cmd>lua require('spectre.actions').run_current_replace()<CR>",
        desc = 'replace current line',
      },

      ['run_replace'] = {
        map = '<leader>R',
        cmd = "<cmd>lua require('spectre.actions').run_replace()<CR>",
        desc = 'replace all',
      },
      ['change_view_mode'] = {
        map = '<leader>v',
        cmd = "<cmd>lua require('spectre').change_view()<CR>",
        desc = 'change result view mode',
      },
      ['toggle_live_update'] = {
        map = 'tu',
        cmd = "<cmd>lua require('spectre').toggle_live_update()<CR>",
        desc = 'update change when vim write file.',
      },
      ['toggle_ignore_case'] = {
        map = 'ti',
        cmd = "<cmd>lua require('spectre').change_options('ignore-case')<CR>",
        desc = 'toggle ignore case',
      },
      ['toggle_ignore_hidden'] = {
        map = 'th',
        cmd = "<cmd>lua require('spectre').change_options('hidden')<CR>",
        desc = 'toggle search hidden',
      },
      -- you can put your mapping here it only use normal mode
    },
    find_engine = {
      -- rg is map with finder_cmd
      ['rg'] = {
        cmd = 'rg',
        -- default args
        args = {
          '--color=never',
          '--no-heading',
          '--with-filename',
          '--line-number',
          '--column',
        },
        options = {
          ['ignore-case'] = {
            value = '--ignore-case',
            icon = '[I]',
            desc = 'ignore case',
          },
          ['hidden'] = {
            value = '--hidden',
            desc = 'hidden file',
            icon = '[H]',
          },
          -- you can put any rg search option you want here it can toggle with
          -- show_option function
        },
      },

      ['ag'] = {
        cmd = 'ag',

        args = {
          '--vimgrep',
          '-s',
        },
        options = {
          ['ignore-case'] = {
            value = '-i',
            icon = '[I]',
            desc = 'ignore case',
          },
          ['hidden'] = {

            value = '--hidden',
            desc = 'hidden file',
            icon = '[H]',
          },
        },
      },
    },

    replace_engine = {
      ['sed'] = {
        cmd = 'sed',
        args = nil,
      },

      options = {
        ['ignore-case'] = {
          value = '--ignore-case',
          icon = '[I]',
          desc = 'ignore case',
        },
      },
    },
    default = {
      find = {
        --pick one of item in find_engine
        cmd = 'rg',
        options = { 'ignore-case' },
      },
      replace = {
        --pick one of item in replace_engine
        cmd = 'sed',
      },
    },
    replace_vim_cmd = 'cdo',
    is_open_target_win = true, --open file on opener window
    is_insert_mode = false, -- start open panel on is_insert_mode
  })
end

function config.neogit()
  local neogit = require('neogit')

  neogit.setup({
    disable_signs = false,
    disable_hint = false,
    disable_context_highlighting = false,
    disable_commit_confirmation = true,
    -- Neogit refreshes its internal state after specific events, which can be expensive depending on the repository size.
    -- Disabling `auto_refresh` will make it so you have to manually refresh the status after you open it.
    auto_refresh = true,
    disable_builtin_notifications = false,
    use_magit_keybindings = true,
    -- Change the default way of opening neogit
    kind = 'tab',
    -- Change the default way of opening the commit popup
    commit_popup = {
      kind = 'split',
    },
    -- Change the default way of opening popups
    popup = {
      kind = 'split',
    },
    -- customize displayed signs
    signs = {
      -- { CLOSED, OPENED }
      section = { '>', 'v' },
      item = { '>', 'v' },
      hunk = { '', '' },
    },
    integrations = {
      -- Neogit only provides inline diffs. If you want a more traditional way to look at diffs, you can use `sindrets/diffview.nvim`.
      diffview = true,
    },
    -- Setting any section to `false` will make the section not render at all
    sections = {
      untracked = {
        folded = false,
      },
      unstaged = {
        folded = false,
      },
      staged = {
        folded = false,
      },
      stashes = {
        folded = true,
      },
      unpulled = {
        folded = true,
      },
      unmerged = {
        folded = false,
      },
      recent = {
        folded = false,
      },
    },
    -- override/add mappings
    mappings = {
      -- modify status buffer mappings
      status = {
        -- Adds a mapping with "B" as key that does the "BranchPopup" command
        ['B'] = 'BranchPopup',
        -- Removes the default mapping of "s"
        -- ['s'] = '',
      },
    },
  })
end

function config.diffview()
  -- Lua
  local actions = require('diffview.actions')

  require('diffview').setup({
    diff_binaries = false, -- Show diffs for binaries
    enhanced_diff_hl = false, -- See ':h diffview-config-enhanced_diff_hl'
    git_cmd = { 'git' }, -- The git executable followed by default args.
    use_icons = true, -- Requires nvim-web-devicons
    icons = { -- Only applies when use_icons is true.
      folder_closed = '',
      folder_open = '',
    },
    signs = {
      fold_closed = '',
      fold_open = '',
    },
    file_panel = {
      listing_style = 'tree', -- One of 'list' or 'tree'
      tree_options = { -- Only applies when listing_style is 'tree'
        flatten_dirs = true, -- Flatten dirs that only contain one single dir
        folder_statuses = 'only_folded', -- One of 'never', 'only_folded' or 'always'.
      },
      win_config = { -- See ':h diffview-config-win_config'
        position = 'left',
        width = 35,
      },
    },
    file_history_panel = {
      log_options = { -- See ':h diffview-config-log_options'
        single_file = {
          diff_merges = 'combined',
        },
        multi_file = {
          diff_merges = 'first-parent',
        },
      },
      win_config = { -- See ':h diffview-config-win_config'
        position = 'bottom',
        height = 16,
      },
    },
    commit_log_panel = {
      win_config = {}, -- See ':h diffview-config-win_config'
    },
    default_args = { -- Default args prepended to the arg-list for the listed commands
      DiffviewOpen = {},
      DiffviewFileHistory = {},
    },
    hooks = {}, -- See ':h diffview-config-hooks'
    keymaps = {
      disable_defaults = false, -- Disable the default keymaps
      view = {
        -- The `view` bindings are active in the diff buffers, only when the current
        -- tabpage is a Diffview.
        ['<tab>'] = actions.select_next_entry, -- Open the diff for the next file
        ['<s-tab>'] = actions.select_prev_entry, -- Open the diff for the previous file
        ['gf'] = actions.goto_file, -- Open the file in a new split in the previous tabpage
        ['<C-w><C-f>'] = actions.goto_file_split, -- Open the file in a new split
        ['<C-w>gf'] = actions.goto_file_tab, -- Open the file in a new tabpage
        ['<leader>e'] = actions.focus_files, -- Bring focus to the files panel
        ['<leader>b'] = actions.toggle_files, -- Toggle the files panel.
      },
      file_panel = {
        ['j'] = actions.next_entry, -- Bring the cursor to the next file entry
        ['<down>'] = actions.next_entry,
        ['k'] = actions.prev_entry, -- Bring the cursor to the previous file entry.
        ['<up>'] = actions.prev_entry,
        ['<cr>'] = actions.select_entry, -- Open the diff for the selected entry.
        ['o'] = actions.select_entry,
        ['<2-LeftMouse>'] = actions.select_entry,
        ['-'] = actions.toggle_stage_entry, -- Stage / unstage the selected entry.
        ['S'] = actions.stage_all, -- Stage all entries.
        ['U'] = actions.unstage_all, -- Unstage all entries.
        ['X'] = actions.restore_entry, -- Restore entry to the state on the left side.
        ['R'] = actions.refresh_files, -- Update stats and entries in the file list.
        ['L'] = actions.open_commit_log, -- Open the commit log panel.
        ['<c-b>'] = actions.scroll_view(-0.25), -- Scroll the view up
        ['<c-f>'] = actions.scroll_view(0.25), -- Scroll the view down
        ['<tab>'] = actions.select_next_entry,
        ['<s-tab>'] = actions.select_prev_entry,
        ['gf'] = actions.goto_file,
        ['<C-w><C-f>'] = actions.goto_file_split,
        ['<C-w>gf'] = actions.goto_file_tab,
        ['i'] = actions.listing_style, -- Toggle between 'list' and 'tree' views
        ['f'] = actions.toggle_flatten_dirs, -- Flatten empty subdirectories in tree listing style.
        ['<leader>e'] = actions.focus_files,
        ['<leader>b'] = actions.toggle_files,
      },
      file_history_panel = {
        ['g!'] = actions.options, -- Open the option panel
        ['<C-A-d>'] = actions.open_in_diffview, -- Open the entry under the cursor in a diffview
        ['y'] = actions.copy_hash, -- Copy the commit hash of the entry under the cursor
        ['L'] = actions.open_commit_log,
        ['zR'] = actions.open_all_folds,
        ['zM'] = actions.close_all_folds,
        ['j'] = actions.next_entry,
        ['<down>'] = actions.next_entry,
        ['k'] = actions.prev_entry,
        ['<up>'] = actions.prev_entry,
        ['<cr>'] = actions.select_entry,
        ['o'] = actions.select_entry,
        ['<2-LeftMouse>'] = actions.select_entry,
        ['<c-b>'] = actions.scroll_view(-0.25),
        ['<c-f>'] = actions.scroll_view(0.25),
        ['<tab>'] = actions.select_next_entry,
        ['<s-tab>'] = actions.select_prev_entry,
        ['gf'] = actions.goto_file,
        ['<C-w><C-f>'] = actions.goto_file_split,
        ['<C-w>gf'] = actions.goto_file_tab,
        ['<leader>e'] = actions.focus_files,
        ['<leader>b'] = actions.toggle_files,
      },
      option_panel = {
        ['<tab>'] = actions.select_entry,
        ['q'] = actions.close,
      },
    },
  })
end

function config.visitor()
  require('link-visitor').setup({
    open_cmd = 'google-chrome-stable',
  })
end

function config.notify()
  local status_ok, notify = pcall(require, 'notify')
  if not status_ok then
    return
  end
  notify.setup({
    background_colour = 'Normal',
    fps = 30,
    icons = {
      DEBUG = '',
      ERROR = '',
      INFO = '',
      TRACE = '✎',
      WARN = '',
    },
    level = 2,
    minimum_width = 50,
    render = 'default',
    stages = 'fade_in_slide_out',
    timeout = 1000,
  })
  vim.notify = notify
end

function config.CamelCaseMotion()
  vim.g.camelcasemotion_key = '\\'
end

function config.colortils()
  require('colortils').setup({
    -- Register in which color codes will be copied
    register = '+',
    -- Preview for colors, if it contains `%s` this will be replaced with a hex color code of the color
    color_preview = '█ %s',
    -- The default in which colors should be saved
    -- This can be hex, hsl or rgb
    default_format = 'hex',
    -- Border for the float
    border = 'rounded',
    -- Some mappings which are used inside the tools
    mappings = {
      -- increment values
      increment = 'l',
      -- decrement values
      decrement = 'h',
      -- increment values with bigger steps
      increment_big = 'L',
      -- decrement values with bigger steps
      decrement_big = 'H',
      -- set values to the minimum
      min_value = '0',
      -- set values to the maximum
      max_value = '$',
      -- save the current color in the register specified above with the format specified above
      set_register_default_format = '<cr>',
      -- save the current color in the register specified above with a format you can choose
      set_register_cjoose_format = 'g<cr>',
      -- replace the color under the cursor with the current color in the format specified above
      replace_default_format = '<m-cr>',
      -- replace the color under the cursor with the current color in a format you can choose
      replace_choose_format = 'g<m-cr>',
      -- export the current color to a different tool
      export = 'E',
      -- set the value to a certain number (done by just entering numbers)
      set_value = 'c',
      -- toggle transparency
      transparency = 'T',
      -- choose the background (for transparent colors)
      choose_background = 'B',
    },
  })
end

function config.harpoon()
  require('harpoon').setup({
    global_settings = {
      -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
      save_on_toggle = false,

      -- saves the harpoon file upon every change. disabling is unrecommended.
      save_on_change = true,

      -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
      enter_on_sendcmd = false,

      -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
      tmux_autoclose_windows = false,

      -- filetypes that you want to prevent from adding to the harpoon list menu.
      excluded_filetypes = { 'harpoon' },

      -- set marks specific to each git branch inside git repository
      mark_branch = false,
    },
  })
end

function config.mcc()
  require('mcc').setup({
    c = { '-', '->', '-' },
    -- not signal char anything you want change
    rust = { '88', '::', '88' },
    -- also support mulitple rules
    go = {
      { ';', ':=', ';' },
      { '/', ':=', ';' },
    },
    markdown = {
      { ';', '``', ';' },
    },
  })
end

function config.nvim_surround()
  require('nvim-surround').setup({
    keymaps = {
      -- insert = 'ys',
      insert = '<C-g>s',
      insert_line = '<C-g>S',
      visual = 'S',
      delete = 'ds',
      change = 'cs',
    },
  })
end

function config.comment_box()
  require('comment-box').setup({
    doc_width = 80, -- width of the document
    box_width = 60, -- width of the boxes
    borders = { -- symbols used to draw a box
      top = '─',
      bottom = '─',
      left = '│',
      right = '│',
      top_left = '╭',
      top_right = '╮',
      bottom_left = '╰',
      bottom_right = '╯',
    },
    line_width = 70, -- width of the lines
    line = { -- symbols used to draw a line
      line = '─',
      line_start = '─',
      line_end = '─',
    },
    outer_blank_lines = false, -- insert a blank line above and below the box
    inner_blank_lines = false, -- insert a blank line above and below the text
    line_blank_line_above = false, -- insert a blank line above the line
    line_blank_line_below = false, -- insert a blank line below the line
  })
end

return config
