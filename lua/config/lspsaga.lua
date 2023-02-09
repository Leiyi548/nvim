require('lspsaga').setup({
  preview = {
    lines_above = 0,
    lines_below = 10,
  },
  scroll_preview = {
    scroll_down = '<C-d>',
    scroll_up = '<C-u>',
  },
  request_timeout = 2000,
  finder = {
    edit = { 'o', '<CR>' },
    vsplit = '<C-v>',
    split = '<C-s>',
    tabe = '<C-t>',
    quit = { 'q', '<ESC>' },
  },
  definition = {
    edit = '<C-c>o',
    vsplit = '<C-v>',
    split = '<C-s>',
    tabe = '<C-t>',
    quit = 'q',
    close = '<Esc>',
  },
  code_action = {
    num_shortcut = true,
    keys = {
      -- string |table type
      quit = 'q',
      exec = { 'o', '<CR>' },
    },
  },
  lightbulb = {
    enable = true,
    enable_in_insert = true,
    sign = true,
    sign_priority = 40,
    virtual_text = true,
  },
  rename = {
    quit = '<C-c>',
    exec = '<CR>',
    mark = 'x',
    confirm = '<CR>',
    in_select = true,
    whole_project = true,
  },
  symbol_in_winbar = {
    enable = true,
    separator = ' ',
    hide_keyword = true,
    show_file = true,
    folder_level = 2,
    respect_root = false,
    color_mode = true,
  },
  outline = {
    win_position = 'right',
    win_with = '',
    win_width = 30,
    show_detail = true,
    auto_preview = true,
    auto_refresh = true,
    auto_close = true,
    custom_sort = nil,
    keys = {
      jump = 'o',
      expand_collapse = 'u',
      quit = 'q',
    },
  },
  ui = {
    -- currently only round theme
    theme = 'round',
    -- this option only work in neovim 0.9
    title = true,
    -- border type can be single,double,rounded,solid,shadow.
    border = 'single',
    winblend = 0,
    expand = '',
    collapse = '',
    preview = ' ',
    code_action = '💡',
    diagnostic = '🐞',
    incoming = ' ',
    outgoing = ' ',
    colors = {
      --float window normal background color
      normal_bg = '#282c34',
      --title background color
      title_bg = '#ce5dd6',
      red = '#e95678',
      magenta = '#b33076',
      orange = '#FF8700',
      yellow = '#f7bb3b',
      green = '#afd700',
      cyan = '#36d0e0',
      blue = '#61afef',
      purple = '#CBA6F7',
      white = '#d1d4cf',
      black = '#1c1c19',
    },
    kind = {},
  },
})

local keymap = vim.keymap.set
-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap('n', 'gw', '<cmd>Lspsaga lsp_finder<CR>')

-- Code action
keymap({ 'n', 'v' }, 'ga', '<cmd>Lspsaga code_action<CR>')

-- rename
keymap('n', '<leader>lr', '<cmd>Lspsaga rename<CR>')

-- Peek Definition
-- you can edit the definition file in this float window
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
keymap('n', 'gp', '<cmd>Lspsaga peek_definition<CR>') -- Go to Definition-- keymap('n', 'gd', '<cmd>Lspsaga goto_definition<CR>')
-- Show line diagnostics you can pass argument ++unfocus to make
-- show_line_diagnostics float window unfocus
keymap('n', 'gl', '<cmd>Lspsaga show_line_diagnostics<CR>')

-- Show cursor diagnostic
-- also like show_line_diagnostics  support pass ++unfocus
keymap('n', '<leader>ss', '<cmd>Lspsaga show_cursor_diagnostics<CR>')

-- Show buffer diagnostic
keymap('n', '<leader>sb', '<cmd>Lspsaga show_buf_diagnostics<CR>')

-- Diagnostic jump can use `<c-o>` to jump back
keymap('n', '[d', '<cmd>Lspsaga diagnostic_jump_prev<CR>')
keymap('n', ']d', '<cmd>Lspsaga diagnostic_jump_next<CR>')

-- Diagnostic jump with filter like Only jump to error
keymap('n', '[D', function()
  require('lspsaga.diagnostic').goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)
keymap('n', ']D', function()
  require('lspsaga.diagnostic').goto_next({ severity = vim.diagnostic.severity.ERROR })
end)

-- Toggle Outline
keymap('n', '<leader>oo', '<cmd>Lspsaga outline<CR>')

-- Hover Doc
-- if there has no hover will have a notify no information available
-- to disable it just Lspsaga hover_doc ++quiet
keymap('n', 'gh', '<cmd>Lspsaga hover_doc<CR>')
keymap('n', 'K', '<cmd>Lspsaga hover_doc<CR>')

-- Callhierarchy
keymap('n', '<Leader>ci', '<cmd>Lspsaga incoming_calls<CR>')
keymap('n', '<Leader>co', '<cmd>Lspsaga outgoing_calls<CR>')

-- Float terminal
-- keymap({"n", "t"}, "<A-d>", "<cmd>Lspsaga term_toggle<CR>")
