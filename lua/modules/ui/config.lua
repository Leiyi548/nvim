-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local config = {}

function config.github()
  if _G_colorscheme == 'github_light' then
    -- Example config in Lua
    require('github-theme').setup({
      theme_style = 'light',
      function_style = 'italic',
      comment_style = 'italic',
      keyword_style = 'NONE',
      variable_style = 'NONE',
      sidebars = { 'qf', 'vista_kind', 'terminal', 'packer' },

      -- Change the "hint" color to the "orange" color, and make the "error" color bright red
      colors = { hint = 'orange', error = '#ff0000' },

      -- Overwrite the highlight groups
      overrides = function(c)
        return {
          htmlTag = { fg = c.red, bg = '#282c34', sp = c.hint, style = 'underline' },
          DiagnosticHint = { link = 'LspDiagnosticsDefaultHint' },
          -- this will remove the highlight groups
          TSField = {},
        }
      end,
    })
  end
end

function config.kanagawa()
  -- Default options:
  require('kanagawa').setup({
    undercurl = true, -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = { italic = true },
    keywordStyle = { italic = false },
    statementStyle = { bold = true },
    typeStyle = {},
    variablebuiltinStyle = { italic = true },
    specialReturn = true, -- special highlight for the return keyword
    specialException = true, -- special highlight for exception handling keywords
    transparent = false, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    globalStatus = false, -- adjust window separators highlight for laststatus=3
    terminalColors = true, -- define vim.g.terminal_color_{0,17}
    colors = {},
    overrides = {},
  })
end

function config.onedarkpro()
  local onedarkpro_ok, onedarkpro = pcall(require, 'onedarkpro')
  if not onedarkpro_ok then
    return
  end

  onedarkpro.setup({
    styles = { -- Choose from "bold,italic,underline"
      strings = 'NONE', -- Style that is applied to strings.
      comments = 'italic', -- Style that is applied to comments
      keywords = 'NONE', -- Style that is applied to keywords
      functions = 'italic', -- Style that is applied to functions
      variables = 'NONE', -- Style that is applied to variables
      virtual_text = 'italic', -- Style that is applied to virtual text
    },
    options = {

      bold = true, -- Use the themes opinionated bold styles?
      italic = true, -- Use the themes opinionated italic styles?
      underline = true, -- Use the themes opinionated underline styles?
      undercurl = true, -- Use the themes opinionated undercurl styles?
      cursorline = true, -- Use cursorline highlighting?
      transparency = true, -- Use a transparent background?
      terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
      window_unfocussed_color = true, -- When the window is out of focus, change the normal background?
    },
    hlgroups = {
      IncSearch = { fg = '#ad4539', bg = '#22252c' },
    },
  })
end

function config.onedarker()
  local colorscheme = 'onedarker'
  local ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
  if not ok then
    return
  end
end

function config.dashboard()
  local home = os.getenv('HOME') -- /home/ewell
  local db = require('dashboard')
  -- macos
  -- db.preview_command = 'cat | lolcat -F 0.3'
  -- linux
  -- db.preview_command = 'ueberzug'
  -- db.preview_command = 'cat | lolcat -F 0.3'
  --
  -- db.preview_file_path = home .. '/.dotfile/wallpaper/01.png'
  -- db.preview_file_path = home .. '/.config/nvim/static/neovim.cat'
  -- db.preview_file_height = 12
  -- db.preview_file_width = 80
  db.custom_center = {
    {
      icon = '  ',
      desc = 'Recently latest session                 ',
      shortcut = 'SPC s l',
      action = 'SessionLoad',
    },
    {
      icon = '  ',
      desc = 'Recently opened files                   ',
      action = "lua require('modules.tools.fancy_telescope').findRecentFiles()",
      shortcut = 'SPC f r',
    },
    {
      icon = '  ',
      desc = 'Find  File                              ',
      action = "lua require('modules.tools.fancy_telescope').findFiles()",
      shortcut = 'SPC f f',
    },
    {
      icon = '  ',
      desc = 'Find  Text                              ',
      action = 'Telescope live_grep',
      shortcut = 'SPC f t',
    },
    {
      icon = '  ',
      desc = 'Open Personal dotfiles                  ',
      action = "lua require('modules.tools.fancy_telescope').findDotfile()",
      shortcut = 'SPC f d',
    },
  }
  db.custom_header = {
    '                                                                              ',
    '=================     ===============     ===============   ========  ========',
    '\\\\ . . . . . . .\\\\   //. . . . . . .\\\\   //. . . . . . .\\\\  \\\\. . .\\\\// . . //',
    '||. . ._____. . .|| ||. . ._____. . .|| ||. . ._____. . .|| || . . .\\/ . . .||',
    '|| . .||   ||. . || || . .||   ||. . || || . .||   ||. . || ||. . . . . . . ||',
    '||. . ||   || . .|| ||. . ||   || . .|| ||. . ||   || . .|| || . | . . . . .||',
    '|| . .||   ||. _-|| ||-_ .||   ||. . || || . .||   ||. _-|| ||-_.|\\ . . . . ||',
    "||. . ||   ||-'  || ||  `-||   || . .|| ||. . ||   ||-'  || ||  `|\\_ . .|. .||",
    '|| . _||   ||    || ||    ||   ||_ . || || . _||   ||    || ||   |\\ `-_/| . ||',
    "||_-' ||  .|/    || ||    \\|.  || `-_|| ||_-' ||  .|/    || ||   | \\  / |-_.||",
    "||    ||_-'      || ||      `-_||    || ||    ||_-'      || ||   | \\  / |  `||",
    "||    `'         || ||         `'    || ||    `'         || ||   | \\  / |   ||",
    "||            .===' `===.         .==='.`===.         .===' /==. |  \\/  |   ||",
    "||         .=='   \\_|-_ `===. .==='   _|_   `===. .===' _-|/   `==  \\/  |   ||",
    "||      .=='    _-'    `-_  `='    _-'   `-_    `='  _-'   `-_  /|  \\/  |   ||",
    "||   .=='    _-'          `-__\\._-'         `-_./__-'         `' |. /|  |   ||",
    "||.=='    _-'                                                     `' |  /==.||",
    "=='    _-'                        N E O V I M                         \\/   `==",
    "\\   _-'                                                                `-_   /",
    " `''                                                                      ``'  ",
  }
end

function config.lualine()
  -- require('modules.ui.statusline')
  require('modules.ui.sample_lualine')
end

function config.bufferline()
  require('modules.ui.tabline')
end

function config.nvim_tree()
  local icons = require('modules.ui.icons')
  require('nvim-tree').setup({
    auto_reload_on_write = true,
    create_in_closed_folder = false,
    disable_netrw = false,
    hijack_cursor = false,
    hijack_netrw = true,
    hijack_unnamed_buffer_when_opening = false,
    ignore_buffer_on_setup = false,
    open_on_setup = false,
    open_on_setup_file = false,
    open_on_tab = false,
    sort_by = 'name',
    update_cwd = true,
    reload_on_bufenter = false,
    respect_buf_cwd = false,

    view = {
      width = 30,
      height = 30,
      hide_root_folder = false,
      side = 'left',
      preserve_window_proportions = false,
      number = false,
      relativenumber = false,
      signcolumn = 'yes',
      mappings = {
        custom_only = false,
        list = {
          -- user mappings go here
          { key = '[d', action = 'prev_git_item' },
          { key = ']d', action = 'next_git_item' },
          { key = 'X', action = 'collapse_all' },
          { key = 's', action = 'vsplit' },
          { key = 'O', action = 'system_open' },
        },
      },
      float = {
        enable = false,
        open_win_config = {
          relative = 'editor',
          border = 'rounded',
          width = 30,
          height = 30,
          row = 1,
          col = 1,
        },
      },
    },
    renderer = {

      add_trailing = false,
      group_empty = false,
      highlight_git = false,
      highlight_opened_files = 'none',
      root_folder_modifier = ':~',
      -- root_folder_modifier = ':t',
      indent_markers = {
        enable = false,
        icons = {
          corner = '└ ',
          edge = '│ ',
          none = '  ',
        },
      },
      icons = {
        webdev_colors = true,

        git_placement = 'before', -- before | after
        padding = ' ',
        symlink_arrow = ' ➛ ',
        show = {
          file = true,
          folder = true,
          folder_arrow = true,
          git = true,
        },

        glyphs = {
          default = '',
          symlink = '',
          folder = {

            arrow_closed = '',
            arrow_open = '',
            default = '',
            open = '',
            empty = '',
            empty_open = '',
            symlink = '',
            symlink_open = '',
          },
          git = {
            unstaged = '',
            staged = 'S',
            unmerged = '',
            renamed = '➜',
            deleted = '',
            untracked = 'U',
            ignored = '◌',
          },
        },
      },
      special_files = { 'Cargo.toml', 'Makefile', 'README.md', 'readme.md' },
    },
    hijack_directories = {
      enable = true,
      auto_open = true,
    },
    update_focused_file = {
      enable = true,
      update_cwd = true,
      ignore_list = {},
    },
    ignore_ft_on_setup = {},
    system_open = {
      cmd = '',
      args = {},
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
      icons = {

        hint = icons.diagnostics.Hint,
        info = icons.diagnostics.Information,
        warning = icons.diagnostics.Warning,
        error = icons.diagnostics.Error,
      },
    },
    filters = {
      dotfiles = false,
      custom = {},
      exclude = {},
    },
    git = {
      enable = true,
      ignore = true,
      timeout = 400,
    },
    actions = {
      use_system_clipboard = true,
      change_dir = {
        enable = true,
        global = false,
        restrict_above_cwd = false,
      },
      open_file = {

        quit_on_open = false,

        resize_window = true,
        window_picker = {
          enable = true,
          chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
          exclude = {
            filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
            buftype = { 'nofile', 'terminal', 'help' },
          },
        },
      },
    },
    trash = {
      cmd = 'trash',
      require_confirm = true,
    },
    live_filter = {

      prefix = '[FILTER]: ',
      always_show_folders = true,
    },
    log = {
      enable = false,
      truncate = false,
      types = {
        all = false,
        config = false,
        copy_paste = false,

        diagnostics = false,
        git = false,
        profile = false,
      },
    },
  })
end

function config.indent_blankline()
  local ok, indent_blankline = pcall(require, 'indent_blankline')
  if not ok then
    return
  end

  vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
  vim.g.indent_blankline_filetype_exclude = {
    'help',
    'startify',
    'dashboard',
    'packer',
    'neogitstatus',
    'NvimTree',
    'Trouble',
    'text',
  }
  vim.g.indentLine_enabled = 1
  -- vim.g.indent_blankline_char = "│"
  vim.g.indent_blankline_char = '▏'
  -- vim.g.indent_blankline_char = "▎"
  vim.g.indent_blankline_show_trailing_blankline_indent = false
  vim.g.indent_blankline_show_first_indent_level = true
  vim.g.indent_blankline_use_treesitter = true
  -- vim.g.indent_blankline_use_treesitter_scope = 1
  vim.g.indent_blankline_show_current_context = true
  vim.g.indent_blankline_context_patterns = {
    'class',
    'return',
    'function',
    'method',
    '^if',
    '^while',
    'jsx_element',
    '^for',
    '^object',
    '^table',
    'block',
    'arguments',
    'if_statement',
    'else_clause',
    'jsx_element',
    'jsx_self_closing_element',
    'try_statement',
    'catch_clause',
    'import_statement',
    'operation_type',
  }
  -- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
  -- vim.wo.colorcolumn = "99999"

  indent_blankline.setup({
    -- show_end_of_line = true,
    -- space_char_blankline = " ",
    show_current_context = true,
    -- show_current_context_start = true,
  })
end

function config.colorizer()
  local status_ok, colorizer = pcall(require, 'colorizer')
  if not status_ok then
    return
  end

  colorizer.setup({ '*' }, {
    RGB = true, -- #RGB hex codes
    RRGGBB = true, -- #RRGGBB hex codes
    names = false, -- "Name" codes like Blue oe blue
    RRGGBBAA = true, -- #RRGGBBAA hex codes
    rgb_fn = true, -- CSS rgb() and rgba() functions
    hsl_fn = true, -- CSS hsl() and hsla() functions
    css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
    css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
    -- Available modes: foreground, background, virtualtext
    mode = 'background', -- Set the display mode.)
  })
end

return config
