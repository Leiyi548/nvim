local whichkey_ok, which_key = pcall(require, 'which-key')
if not whichkey_ok then
  return
end

local setup = {
  plugins = {
    marks = true, -- shows a list of your marks on ' and `
    registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
      suggestions = 20, -- how many suggestions should be shown in the list?
    },
    -- the presets plugin, adds help for a bunch of default keybindings in Neovim
    -- No actual key bindings are created
    presets = {
      operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
      motions = true, -- adds help for motions
      text_objects = true, -- help for text objects triggered after entering an operator
      windows = true, -- default bindings on <c-w>
      nav = true, -- misc bindings to work with windows
      z = true, -- bindings for folds, spelling and others prefixed with z
      g = true, -- bindings for prefixed with g
    },
  },
  -- add operators that will trigger motion and text object completion
  -- to enable all native operators, set the preset / operators plugin above
  -- operators = { gc = "Comments" },
  key_labels = {
    -- override the label used to display some keys. It doesn't effect WK in any other way.
    -- For example:
    -- ["<space>"] = "SPC",
    -- ["<cr>"] = "RET",
    -- ["<tab>"] = "TAB",
  },
  icons = {
    breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
    separator = '➜', -- symbol used between a key and it's label
    group = '+', -- symbol prepended to a group
  },
  popup_mappings = {
    scroll_down = '<c-d>', -- binding to scroll down inside the popup
    scroll_up = '<c-u>', -- binding to scroll up inside the popup
  },
  window = {
    border = 'single', -- none, single, double, shadow
    position = 'bottom', -- bottom, top
    margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
    padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
    winblend = 20,
  },
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 3, -- spacing between columns
    align = 'left', -- align columns left, center or right
  },
  ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
  hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ ' }, -- hide mapping boilerplate
  show_help = true, -- show help message on the command line when the popup is visible
  triggers = 'auto', -- automatically setup triggers
  -- triggers = {"<leader>"} -- or specify a list manually
  triggers_blacklist = {
    -- list of mode / prefixes that should never be hooked by WhichKey
    -- this is mostly relevant for key maps that start with a native binding
    -- most people should not need to change this
    i = { 'j', 'k' },
    v = { 'j', 'k' },
  },
}

local opts = {
  mode = 'n', -- NORMAL mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
  -- basic mapping no prefix
  ['/'] = { '<Plug>(comment_toggle_linewise_current)', ' Comment' },
  -- harpoon
  ['<leader>'] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>", '  Harpoon' },
  -- lsp document symbol
  ['.'] = { '<cmd>Telescope lsp_document_symbols<cr>', '  Document Symbols' },
  ['1'] = { "<cmd>lua require('harpoon.ui').nav_file(1)<cr>", ' goto1' },
  ['2'] = { "<cmd>lua require('harpoon.ui').nav_file(2)<cr>", ' goto2' },
  ['3'] = { "<cmd>lua require('harpoon.ui').nav_file(3)<cr>", ' goto3' },
  ['4'] = { "<cmd>lua require('harpoon.ui').nav_file(4)<cr>", ' goto4' },
  ['a'] = { "<cmd>lua require('harpoon.mark').add_file()<CR>", ' Add Mark' },
  ['j'] = { '<cmd>Lspsaga diagnostic_jump_next<cr>', 'diagnostic_jump_next' },
  ['k'] = { '<cmd>Lspsaga diagnostic_jump_prev<cr>', 'diagnostic_jump_prev' },
  ['e'] = { '<cmd>NvimTreeToggle<cr>', ' Explorer' },
  ['h'] = { '<cmd>nohl<cr>', ' Highlight' },
  ['H'] = { '<cmd>TSHighlightCapturesUnderCursor<cr>', ' Ts Highlight' },
  ['q'] = { '<cmd>lua require("utils.function").smart_quit()<cr>', ' Quit Neovim' },
  ['R'] = { '<cmd>lua require("spectre").open_visual({select_word=true})<cr>', ' Replace' },
  -- ['z'] = { '<cmd>ZenMode<cr>', ' ZenMode' },

  -- whichkey-p
  p = {
    name = 'Packer',
    p = { '<cmd>Telescope projects<cr>', 'Project' },
    C = { '<cmd>PackerClean<cr>', 'Clean' },
    c = { '<cmd>PackerCompile<cr>', 'Compile' },
    i = { '<cmd>PackerInstall<cr>', 'Install' },
    s = { '<cmd>PackerSync<cr>', 'Sync' },
    S = { '<cmd>PackerStatus<cr>', 'Status' },
    u = { '<cmd>PackerUpdate<cr>', 'Update' },
  },

  -- whichkey-c
  c = {
    name = 'Checkout/Comment',
    b = { '<cmd>Telescope git_branches<cr>', 'Checkout branch' },
    c = { '<cmd>Telescope git_commits<cr>', 'Checkout commit' },
    F = { '<cmd>lua require("utils.clipboard").copyFileName()<cr>', 'Doc function' },
    f = { '<cmd>lua require("neogen").generate({type="func"})<cr>', 'Doc function' },
  },

  -- whichkey-u
  u = {
    name = 'Undo',
    s = { "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>", 'Undo Stage Hunk' },
  },
  -- whichkey-w
  w = {
    name = 'Window',
    h = { '<C-w><C-h>', 'Left window' },
    j = { '<C-w><C-j>', 'Down window' },
    k = { '<C-w><C-k>', 'Up window' },
    l = { '<C-w><C-l>', 'Right window' },
    s = { '<cmd>split<cr>', 'Split' },
    v = { '<cmd>vsplit<cr>', 'Vsplit' },
    d = { '<C-w>c', 'Close window' },
    c = { '<C-w>c', 'Close window' },
  },
  -- whichkey-o
  o = {
    name = 'Open',
    b = { '<cmd>BufferLinePick<cr>', 'Buffer' },
    d = { '<cmd>lua require("utils.diary").open_diary()<cr>', 'Diary' },
    o = { '<cmd>LSoutlineToggle<cr>', 'Outline' },
    t = { '<cmd>ToggleTerm size=10 direction=horizontal<cr>', 'Horizontal' },
    s = { '<cmd>AsyncTask Application<cr>', 'System open' },
  },

  -- whichkey-f
  f = {
    name = 'Find',
    g = { '<cmd>Telescope git_files<cr>', 'Git Files' },
    t = { '<cmd>Telescope live_grep<cr>', 'Text' },
    b = { '<cmd>Telescope builtin<cr>', 'Builtin' },
    -- s = { "<cmd>lua require('modules.tools.fancy_telescope').git_status()<cr>", 'Git Status' },
    c = { '<cmd>Telescope commands<cr>', 'Commands' },
    s = { '<cmd>w!<cr>', 'Save' },
    S = { '<cmd>wa!<cr>', 'Save all' },
    d = { "<cmd>lua require('modules.tools.fancy_telescope').findDotfile()<cr>", 'Dotfiles' },
    f = { "<cmd>lua require('modules.tools.fancy_telescope').findFiles()<cr>", 'Files' },
    n = { "<cmd>lua require('modules.tools.fancy_telescope').findNotes()<cr>", 'Note' },
    l = { '<cmd>VisitLinkInBuffer<cr>', 'Links' },
    k = { '<cmd>Telescope keymaps<cr>', 'Keymaps' },
    m = { '<cmd>Telescope marks<cr>', 'Mark' },
    h = { '<cmd>Telescope highlights<cr>', 'Highlight' },
    r = {
      "<cmd>lua require('modules.tools.fancy_telescope').findRecentFiles()<cr>",
      'Recent File',
    },
    o = {
      "<cmd>lua require('modules.tools.fancy_telescope').findRecentFiles()<cr>",
      'Old File',
    },
    R = { '<cmd>SudaRead<cr>', 'View Read with sudo' },
    W = { '<cmd>SudaWrite<cr>', 'Write Read with sudo' },
  },

  -- whichkey-y
  y = {
    name = 'copy',
    r = { "<cmd>lua require('utils.clipboard').copy_relative_path()<cr>", 'Copy relative name' },
    a = { "<cmd>lua require('utils.clipboard').copy_absolute_path_with_tilde()<cr>", 'Copy absoulte name' },
    f = { "<cmd>lua require('utils.clipboard').copy_filename()<cr>", 'Copy filename' },
  },

  -- whichkey-b
  b = {
    name = 'Buffer',
    -- s = { '<cmd>BufferLineSortByExtension<cr>', 'sort buffer by extensions' },
    k = { '<cmd>bdelete!<cr>', 'kill buffer' },
    -- p = { '<cmd>BufferLinePick<cr>', 'pick buffer' },
    f = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Current Buffer' },
    h = { '<cmd>Bdelete hidden<cr>', 'Close hidden buffer' },
    o = { '<cmd>Bdelete other<cr>', 'Close other buffer' },
    b = { "<cmd>lua require('modules.tools.fancy_telescope').findBuffers()<cr>", '﩯Find Buffer' },
    -- h = { '<cmd>BufferLineCloseLeft<cr>', 'Close left buffer' },
    -- l = { '<cmd>BufferLineCloseRight<cr>', 'Close right buffer' },
  },
  -- whichkey-r
  r = {
    name = 'Run or Rename',
    a = { '<cmd>lua _RANGER_TOGGLE()<cr>', 'Ranger' },
    r = { '<cmd>AsyncTask file-run<cr>', 'Run on Terminal' },
    f = { '<cmd>AsyncTask file-run-floaterm<cr>', 'Run on floaterm' },
    l = { '<cmd>luafile%<cr>', 'luafile%' },
    h = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", 'Reset Hunk' },
    b = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", 'Reset Buffer' },
  },

  -- whichkey-g
  g = {
    name = 'Git',
    c = { '<cmd>Telescope git_bcommits<cr>', 'Commit (Current Buffer)' },
    C = { '<cmd>Telescope git_commits<cr>', 'Commit (Current Repository)' },
    f = { '<cmd>Telescope git_files<cr>', 'Git Files' },
    o = { "<cmd>lua require('modules.tools.fancy_telescope').git_status()<cr>", 'Git status' },
    h = { '<cmd>DiffviewFileHistory<cr>', 'History' },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", 'Next Hunk' },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", 'Prev Hunk' },
    g = { '<cmd>Neogit<cr>', 'Neogit' },
    l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", 'Blame line' },
    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", 'Reset Hunk' },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", 'Reset Buffer' },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", 'Stage Hunk' },
    d = {
      '<cmd>DiffviewOpen<cr>',
      'Diff',
    },
  },

  -- whichkey-l
  l = {
    name = 'LSP',
    a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code Action' },
    d = {
      '<cmd>Telescope diagnostics<cr>',
      'Document Diagnostics',
    },
    w = {
      '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>',
      'Workspace Diagnostics',
    },
    f = { '<cmd>lua vim.lsp.buf.format{async = true}<cr>', 'Format' },
    i = { '<cmd>LspInfo<cr>', 'Info' },
    I = { '<cmd>Mason<cr>', 'Mason Install' },
    j = {
      '<cmd>Lspsaga diagnostic_jump_next<cr>',
      'Next Diagnostic',
    },
    g = { '<cmd>lua _LAZYGIT_TOGGLE()<cr>', 'Lazygit' },
    k = {
      '<cmd>Lspsaga diagnostic_jump_prev<cr>',
      'Prev Diagnostic',
    },
    -- l = { '<cmd>lua vim.lsp.codelens.run()<cr>', '  CodeLens Action' },
    q = { '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', 'Quickfix' },
    r = { name = 'Rename' },
    s = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document Symbols' },
    S = {
      '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>',
      'Workspace Symbols',
    },
  },

  -- whichkey-d
  d = {
    name = 'Debug',
    t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", 'Toggle Breakpoint' },
    b = { "<cmd>lua require'dap'.step_back()<cr>", 'Step Back' },
    c = { "<cmd>lua require'dap'.continue()<cr>", 'Continue' },
    C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", 'Run To Cursor' },
    d = { "<cmd>lua require'dap'.disconnect()<cr>", 'Disconnect' },
    g = { "<cmd>lua require'dap'.session()<cr>", 'Get Session' },
    i = { "<cmd>lua require'dap'.step_into()<cr>", 'Step Into' },
    o = { "<cmd>lua require'dap'.step_over()<cr>", 'Step Over' },
    u = { "<cmd>lua require'dap'.step_out()<cr>", 'Step Out' },
    p = { "<cmd>lua require'dap'.pause.toggle()<cr>", 'Pause' },
    r = { "<cmd>lua require'dap'.repl.toggle()<cr>", 'Toggle Repl' },
    s = { "<cmd>lua require'dap'.continue()<cr>", 'Start' },
    q = { "<cmd>lua require'dap'.close()<cr>", 'Quit' },
  },

  -- whichkey-s
  s = {
    name = 'Search',
    b = { '<cmd>Telescope git_branches<cr>', 'Checkout branch' },
    h = { '<cmd>Telescope help_tags<cr>', 'Help' },
    s = { "<cmd>lua require('modules.tools.fancy_telescope').findSnippets()<cr>", ' Save' },
    g = { "<cmd>lua require('modules.tools.fancy_telescope').findGoSource()<cr>", 'Gosource' },
    m = { '<cmd>Telescope man_pages<cr>', 'man Pages' },
    q = { '<cmd>TodoQuickFix<cr>', 'Todo Quickfix' },
    t = { '<cmd>TodoTelescope<cr>', 'Todo Telescope' },
    r = { '<cmd>Telescope registers<cr>', 'Registers' },
    c = { '<cmd>Telescope colorscheme<cr>', 'Colorschemes' },
    n = {
      "<cmd>lua require('telescope').extensions.notify.notify(require('telescope.themes').get_dropdown({}))<cr>",
      'View notify',
    },
    j = {
      "<cmd>lua require'telescope.builtin'.jumplist(require('telescope.themes').get_dropdown({}))<cr>",
      'Jumplist',
    },
  },

  -- whichkey-t
  t = {
    name = 'Toggle/Terminal/Tab',
    n = { '<cmd>ToggleTerm direction=tab<cr>', 'New Terminal Tab' },
    N = { '<cmd>lua _NODE_TOGGLE()<cr>', 'Node' },
    o = { '<cmd>tabonly<cr>', 'tabonly' },
    t = { '<cmd>Telescope telescope-tabs list_tabs<cr>', 'Telescope Tabs' },
    s = { '<cmd>TrimTrailingWhitespace<cr>', 'TrimTrailingWhitespace(Buffer)' },
    p = { '<cmd>lua _PYTHON_TOGGLE()<cr>', 'Python' },
    g = { '<cmd>lua _GOTOP_TOGGLE()<CR>', 'gotop' },
    f = { '<cmd>ToggleTerm direction=float<cr>', ' Float' },
    h = { '<cmd>ToggleTerm size=10 direction=horizontal<cr>', ' Hterm' },
    v = { '<cmd>ToggleTerm size=80 direction=vertical<cr>', ' Vterm' },
    c = { '<cmd>ColorizerToggle<cr>', 'Toggle Colorizer highlight' },
  },

  -- whichkey-i
  i = {
    name = 'Insert',
    t = { '<cmd>TemplateInit<cr>', 'Insert Template' },
    -- m = { '<cmd>lua require("nvim-picgo").upload_clipboard()<cr>', 'Image(Picgo)' },
    c = { '<cmd>Colortils<cr>', 'Color' },
    l = { '<cmd>Colortils css list<cr>', 'List Css' },
  },

  -- whichkey-m
  m = {
    name = 'Markdown/Mark',
    p = { '<cmd>MarkdownPreview<cr>', 'MarkdownPreview' },
    j = { 'Next Method' },
    k = { 'Previous Method' },
  },
}

-- visual mode

local v_opts = {
  mode = 'v', -- NORMAL mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

local v_mappings = {
  ['/'] = { '<Plug>(comment_toggle_linewise_visual)', ' Comment' },
  ['f'] = { "<cmd>lua require('modules.tools.fancy_telescope').grep_string_visual()<cr>", 'Grep visual' },
}

which_key.register(mappings, opts)
which_key.register(v_mappings, v_opts)
which_key.setup(setup)
