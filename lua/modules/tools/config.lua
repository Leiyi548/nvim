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
  telescope.setup({
    defaults = {
      path_display = { 'truncate' }, -- hidden tail absolute smart shorten truncate
      dynamic_preview_title = true, -- 动态更改预览窗口的名称 例如:预览窗口可以显示完整的文件名
      prompt_prefix = ' ', --     
      selection_caret = ' ',
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
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
    },
    mappings = {
      i = {
        ['<Down>'] = actions.move_selection_next,
        ['<Up>'] = actions.move_selection_previous,
      },
      n = {
        ['<esc>'] = actions.close,
        ['q'] = actions.close,
        ['?'] = actions.which_key,
      },
    },
    file_ignore_patterns = {
      'static/*',
    },
  })
  require('telescope').load_extension('fzy_native')
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
    open_mapping = [[<M-i>]],
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
    vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<M-k>', [[<C-\><C-n><C-W>k]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<M-h>', [[<C-\><C-n><C-W>l]], opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<M-l>', '<cmd>ToggleTerm size=10 direction=horizontal<cr>', opts)
    vim.api.nvim_buf_set_keymap(0, 't', '<M-v>', '<cmd>ToggleTerm size=80 direction=vertical<cr>', opts)
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
    vim.notify('todo-comments not found')
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
      delete = { hl = 'GitSignsDelete', text = '契', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
      topdelete = { hl = 'GitSignsDelete', text = '契', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
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

return config
