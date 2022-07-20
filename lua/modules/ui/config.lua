-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local config = {}

function config.github()
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

function config.alpha()
  local alpha = require('alpha')
  local startify = require('alpha.themes.startify')
  -- get neovim plugins count
  local handle = io.popen('fd -d 2 . $HOME"/.local/share/nvim/site/pack/packer" | grep pack | wc -l | tr -d "\n" ')
  ---@diagnostic disable-next-line: need-check-nil
  local plugins = handle:read('*a')
  local plugins_count = plugins:gsub('^%s*(.-)%s*$', '%1')

  alpha.setup(startify.config)
  startify.nvim_web_devicons.enabled = true
  -- disable top_buttons
  startify.section.top_buttons.val = {}
  startify.section.bottom_buttons.val = {
    { type = 'padding', val = 1 },
    startify.button('e', ' Find Files', "<cmd>lua require('modules.tools.fancy_telescope').findFiles()<cr>"),
    startify.button('r', ' Recent Files', "<cmd>lua require('modules.tools.fancy_telescope').findRecentFiles()<cr>"),
    startify.button('t', ' Find Text', '<cmd>Telescope live_grep<CR>'),
    startify.button('d', ' Find Dotfiles', "<cmd>lua require('modules.tools.fancy_telescope').findDotfile()<cr>"),
    startify.button(
      'c',
      ' Find Configuration',
      "<cmd>lua require('modules.tools.fancy_telescope').findConfiguration()<cr>"
    ),
    startify.button('u', ' Update Plugins', '<cmd>PackerSync<cr>'),
    startify.button('q', ' Quit Neovim', '<cmd>q<cr>'),
  }
  startify.section.footer.val = {
    {
      type = 'text',
      val = 'neovim load ' .. plugins_count .. ' plugins',
      opts = {
        position = 'left',
        hl = 'Comment',
        hl_shortcut = 'Comment',
      },
    },
  }
end

function config.lualine()
  require('modules.ui.statusline')
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
          { key = '[g', action = 'prev_git_item' },
          { key = ']g', action = 'next_git_item' },
          { key = 'X', action = 'collapse_all' },
          { key = 's', action = 'vsplit' },
          { key = 'O', action = 'system_open' },
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
