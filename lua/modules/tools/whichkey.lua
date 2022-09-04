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
  ['c'] = { '<cmd>BufferLinePickClose<CR>', '﩯Close Buffer' },
  ['e'] = { '<cmd>NvimTreeToggle<cr>', ' Explorer' },
  ['h'] = { '<cmd>nohl<cr>', ' Highlight' },
  ['H'] = { '<cmd>TSHighlightCapturesUnderCursor<cr>', ' Ts Highlight' },
  ['q'] = { '<cmd>lua require("utils.function").smart_quit()<cr>', ' Quit Neovim' },
  ['R'] = { '<cmd>lua require("spectre").open_visual({select_word=true})<cr>', ' Replace' },
  ['v'] = { '<cmd>ToggleTerm size=80 direction=vertical<cr>', ' Vterm' },
  ['x'] = { '<cmd>Telescope diagnostic<cr>', ' Diagnostics' },
  -- ['z'] = { '<cmd>ZenMode<cr>', ' ZenMode' },

  -- whichkey-p
  p = {
    name = ' Packer',
    p = { "<cmd>lua require'telescope'.extensions.project.project{}<CR>", 'Registers' },
    C = { '<cmd>PackerClean<cr>', 'Clean' },
    c = { '<cmd>PackerCompile<cr>', 'Compile' },
    i = { '<cmd>PackerInstall<cr>', 'Install' },
    s = { '<cmd>PackerSync<cr>', 'Sync' },
    S = { '<cmd>PackerStatus<cr>', 'Status' },
    u = { '<cmd>PackerUpdate<cr>', 'Update' },
  },

  -- whichkey-w
  w = {
    name = ' Window',
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
    name = ' Open',
    b = { '<cmd>BufferLinePick<cr>', '﩯Buffer' },
    -- e = { '<cmd>NeoTreeFocusToggle<cr>', ' Explorer' },
    -- g = { '<cmd>NeoTreeFocusToggle git_status<cr>', ' Git Explorer ' },
    o = { '<cmd>LSoutlineToggle<cr>', ' Outline' },
    t = { '<cmd>ToggleTerm size=10 direction=horizontal<cr>', ' Horizontal' },
    s = { '<cmd>AsyncTask Application<cr>', ' System open' },
  },

  -- whichkey-f
  f = {
    name = ' Find',
    t = { '<cmd>Telescope live_grep<cr>', ' Text' },
    b = { '<cmd>Telescope builtin<cr>', 'Builtin' },
    -- s = { "<cmd>lua require('modules.tools.fancy_telescope').git_status()<cr>", 'Git Status' },
    s = { '<cmd>w!<cr>', ' Save' },
    S = { '<cmd>wa!<cr>', ' Save all' },
    d = { "<cmd>lua require('modules.tools.fancy_telescope').findDotfile()<cr>", 'Dotfiles' },
    f = { "<cmd>lua require('modules.tools.fancy_telescope').findFiles()<cr>", 'Files' },
    g = { "<cmd>lua require('modules.tools.fancy_telescope').git_status()<cr>", 'Git Status' },
    c = { '<cmd>Telescope git_bcommits<cr>', 'Commit' },
    l = { '<cmd>VisitLinkInBuffer<cr>', 'Links' },
    C = { '<cmd>Telescope commands<cr>', 'Commands' },
    p = { "<cmd>lua require'telescope'.extensions.project.project{}<CR>", 'Project' },
    k = { '<cmd>Telescope keymaps<cr>', 'Keymaps' },
    m = { '<cmd>Telescope man_pages<cr>', 'Man' },
    h = { '<cmd>Telescope highlights<cr>', 'Highlight' },
    N = { '<cmd>Telescope notify<cr>', 'View notify' },
    r = {
      "<cmd>lua require('modules.tools.fancy_telescope').findRecentFiles()<cr>",
      'Recent File',
    },
    R = { '<cmd>SudaRead<cr>', 'View Read with sudo' },
    W = { '<cmd>SudaWrite<cr>', 'Write Read with sudo' },
    j = {
      "<cmd>lua require'telescope.builtin'.jumplist(require('telescope.themes').get_dropdown({}))<cr>",
      'Jumplist',
    },
  },

  -- whichkey-b
  b = {
    name = '﩯Buffer',
    s = { '<cmd>BufferLineSortByExtension<cr>', 'sort buffer by extensions' },
    k = { '<cmd>bdelete!<cr>', 'kill buffer' },
    p = { '<cmd>BufferLinePick<cr>', 'pick buffer' },
    f = { '<cmd>Telescope current_buffer_fuzzy_find<cr>', 'Current Buffer' },
    h = { '<cmd>Bdelete hidden<cr>', 'Close hidden buffer' },
    o = { '<cmd>Bdelete other<cr>', 'Close other buffer' },
    b = { "<cmd>lua require('modules.tools.fancy_telescope').findBuffers()<cr>", '﩯Find Buffer' },
    -- h = { '<cmd>BufferLineCloseLeft<cr>', 'Close left buffer' },
    -- l = { '<cmd>BufferLineCloseRight<cr>', 'Close right buffer' },
  },
  -- whichkey-r
  r = {
    name = ' Run or Rename',
    r = { '<cmd>AsyncTask file-run<cr>', 'Run on Terminal' },
    n = { 'Rename file' },
    f = { '<cmd>AsyncTask file-run-floaterm<cr>', 'Run on floaterm' },
    l = { '<cmd>luafile%<cr>', 'luafile%' },
  },

  -- whichkey-g
  g = {
    name = ' Git',
    h = { '<cmd>DiffviewFileHistory<cr>', ' History' },
    j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", ' Next Hunk' },
    k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", ' Prev Hunk' },
    g = { '<cmd>Neogit<cr>', ' Neogit' },
    -- l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", ' Blame' },
    p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", ' Preview Hunk' },

    r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", ' Reset Hunk' },
    R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", ' Reset Buffer' },
    s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", ' Stage Hunk' },
    u = {
      "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
      ' Undo Stage Hunk',
    },
    o = { '<cmd>Telescope git_status<cr>', ' Open changed file' },
    b = { '<cmd>Telescope git_branches<cr>', ' Checkout branch' },
    c = { '<cmd>Telescope git_commits<cr>', ' Checkout commit' },
    d = {
      '<cmd>DiffviewOpen<cr>',
      'Diff',
    },
  },

  -- whichkey-l
  l = {
    name = '  LSP',
    a = { '<cmd>lua vim.lsp.buf.code_action()<cr>', '  Code Action' },
    d = {
      '<cmd>Telescope lsp_document_diagnostics<cr>',
      '  Document Diagnostics',
    },
    w = {
      '<cmd>Telescope lsp_workspace_diagnostics<cr>',
      '  Workspace Diagnostics',
    },
    f = { '<cmd>lua vim.lsp.buf.format{async = true}<cr>', '  Format' },
    i = { '<cmd>LspInfo<cr>', '  Info' },
    I = { '<cmd>Mason<cr>', '  Mason Install' },
    j = {
      '<cmd>lua vim.diagnostic.goto_next()<cr>',
      ' Next Diagnostic',
    },
    g = { '<cmd>lua _LAZYGIT_TOGGLE()<cr>', ' Lazygit' },
    k = {
      '<cmd>lua vim.diagnostic.goto_prev()<cr>',
      ' Prev Diagnostic',
    },
    -- l = { '<cmd>lua vim.lsp.codelens.run()<cr>', '  CodeLens Action' },
    q = { '<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>', '  Quickfix' },
    r = { name = 'Rename' },
    s = { '<cmd>Telescope lsp_document_symbols<cr>', '  Document Symbols' },
    S = {
      '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>',
      '  Workspace Symbols',
    },
  },

  -- whichkey-d
  d = {
    name = ' Debug',
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
    name = ' Search',
    b = { '<cmd>Telescope git_branches<cr>', ' Checkout branch' },
    h = { '<cmd>Telescope help_tags<cr>', ' Help' },
    s = { "<cmd>lua require('modules.tools.fancy_telescope').findSnippets()<cr>", ' Save' },
    M = { '<cmd>Telescope man_pages<cr>', 'Man Pages' },
    t = { '<cmd>TodoQuickFix<cr>', 'Todo' },
    r = { '<cmd>Telescope registers<cr>', 'Registers' },
    c = { '<cmd>Telescope colorscheme<cr>', 'Colorschemes' },
    C = { '<cmd>Telescope commands<cr>', 'Commands' },
  },

  -- whichkey-t
  t = {
    name = ' Toggle/Terminal',
    n = { '<cmd>lua _NODE_TOGGLE()<cr>', 'Node' },
    p = { '<cmd>lua _PYTHON_TOGGLE()<cr>', 'Python' },
    g = { '<cmd>lua _GOTOP_TOGGLE()<CR>', 'gotop' },
    f = { '<cmd>ToggleTerm direction=float<cr>', ' Float' },
    h = { '<cmd>ToggleTerm size=10 direction=horizontal<cr>', ' Horizontal' },
    v = { '<cmd>ToggleTerm size=80 direction=vertical<cr>', ' Vertical' },
    t = { '<cmd>ToggleTerm direction=tab<cr>', 'New Terminal Tab' },
    c = { '<cmd>ColorizerToggle<cr>', 'Toggle Colorizer highlight' },
  },

  -- whichkey-i
  i = {
    name = ' Insert',
    m = { '<cmd>PasteImg<cr>', 'Image' },
    c = { '<cmd>Colortils<cr>', 'Color' },
    l = { '<cmd>Colortils css list<cr>', 'List Css' },
  },

  -- whichkey-m
  m = {
    name = ' Markdown/Mark',
    p = { '<cmd>MarkdownPreview<cr>', 'MarkdownPreview' },
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
  ['p'] = { '<cmd>Telescope registers<cr>', ' Clipboard' },
}

which_key.register(mappings, opts)
which_key.register(v_mappings, v_opts)
which_key.setup(setup)
