-- author: Leyi548 https://github.com/Leyi548
-- date: 2022-09-3
-- License: MIT

local config = {}

function config.github()
  if _G_colorscheme == 'github_light' then
    require('github-theme').setup({
      theme_style = 'light',
      function_style = 'NONE',
      comment_style = 'italic',
      keyword_style = 'NONE',
      variable_style = 'NONE',
      sidebars = { 'qf', 'vista_kind', 'terminal', 'packer' },

      -- Change the "hint" color to the "orange" color, and make the "error" color bright red
      colors = { hint = 'orange', error = '#ff0000' },

      -- Overwrite the highlight groups
      overrides = function(c)
        return {
          TreesitterContext = { bg = c.diff.add },
        }
      end,
    })
  end
end

function config.catppuccin()
  -- frappe（dark like） like tokynight
  -- macchiato,mocha是个深色主题
  -- latte is light colorscheme,I think mocha is better
  vim.g.catppuccin_flavour = 'mocha' -- latte, frappe, macchiato, mocha

  require('catppuccin').setup({
    dim_inactive = {
      enabled = false,
      shade = 'dark',
      percentage = 0.15,
    },
    transparent_background = false,
    term_colors = true,
    compile = {
      enabled = true,
      -- ~/.cache/nvim/catppuccin
      path = vim.fn.stdpath('cache') .. '/catppuccin',
    },
    styles = {
      comments = { 'italic' },
      conditionals = {},
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
      operators = {},
    },
    integrations = {
      treesitter = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = {},
          hints = {},
          warnings = {},
          information = {},
        },
        underlines = {
          errors = { 'underline' },
          hints = { 'underline' },
          warnings = { 'underline' },
          information = { 'underline' },
        },
      },
      coc_nvim = true,
      lsp_trouble = false,
      cmp = true,
      lsp_saga = true,
      gitgutter = false,
      gitsigns = true,
      leap = true,
      telescope = true,
      nvimtree = {
        enabled = true,
        show_root = true,
        transparent_panel = true,
      },
      neotree = {
        enabled = true,
        show_root = true,
        transparent_panel = false,
      },
      dap = {
        enabled = false,
        enable_ui = false,
      },
      which_key = true,
      indent_blankline = {
        enabled = true,
        colored_indent_levels = false,
      },
      dashboard = true,
      neogit = true,
      vim_sneak = false,
      fern = false,
      barbar = false,
      bufferline = true,
      markdown = true,
      lightspeed = false,
      ts_rainbow = false,
      hop = true,
      notify = true,
      telekasten = true,
      symbols_outline = false,
      mini = false,
      aerial = false,
      vimwiki = false,
      beacon = true,
      navic = true,
      overseer = false,
    },
    color_overrides = {},
    highlight_overrides = {},
  })
end

function config.vscode()
  if _G_colorscheme == 'vscode' then
    local c = require('vscode.colors')
    -- Lua:
    -- For dark theme (neovim's default)
    vim.o.background = 'dark'
    -- For light theme
    -- vim.o.background = 'light'
    require('vscode').setup({
      -- Enable transparent background
      transparent = false,

      -- Enable italic comment
      italic_comments = true,

      -- Disable nvim-tree background color
      disable_nvimtree_bg = true,

      -- Override colors (see ./lua/vscode/colors.lua)
      color_overrides = {
        -- vscLineNumber = '#FFFFFF',
      },

      -- Override highlight groups (see ./lua/vscode/theme.lua)
      group_overrides = {
        -- this supports the same val table as vim.api.nvim_set_hl
        -- use colors from this colorscheme by requiring vscode.colors!
        -- Cursor = { fg=c.vscDarkBlue, bg=c.vscLightGreen, bold=true },
        TsComment = { italic = true },
        CursorLineNr = { bold = true },
      },
    })
  end
end

function config.onedarkpro()
  if _G_colorscheme == 'onedarkpro' then
    require('onedarkpro').setup({
      dark_theme = 'onedark_vivid', -- The default dark theme
      light_theme = 'onelight', -- The default light theme
      colors = {}, -- Override default colors by specifying colors for 'onelight' or 'onedark' themes
      highlights = {
        CursorLineNr = { style = 'bold' },
        IncSearch = { bg = '${gray}' },
        -- plugins
        HopNextKey = { fg = '${green}', style = 'bold' },
        HopNextKey1 = { fg = '${yellow}', style = 'bold' },
        HopNextKey2 = { link = 'HopNextKey1' },
        -- heirline
        Heirline = { bg = '${statusline_bg}' },
        HeirlineBufferline = { fg = '${buffer_color}' },
        -- my person winbar hightlight
        WinbarFilename = { style = 'bold' },
        WinbarBufferNumber = { fg = '${blue}' },
      }, -- Override default highlight groups
      ft_highlights = {}, -- Override default highlight groups for specific filetypes
      plugins = { -- Override which plugin highlight groups are loaded
        -- See the Supported Plugins section for a list of available plugins
      },
      styles = { -- Choose from "bold,italic,underline"
        strings = 'NONE', -- Style that is applied to strings.
        comments = 'Italic', -- Style that is applied to comments
        keywords = 'italic', -- Style that is applied to keywords
        functions = 'italic', -- Style that is applied to functions
        variables = 'NONE', -- Style that is applied to variables
        virtual_text = 'NONE', -- Style that is applied to virtual text
      },
      options = {
        bold = true, -- Use the colorscheme's opinionated bold styles?
        italic = true, -- Use the colorscheme's opinionated italic styles?
        underline = true, -- Use the colorscheme's opinionated underline styles?
        undercurl = true, -- Use the colorscheme's opinionated undercurl styles?
        cursorline = true, -- Use cursorline highlighting?
        transparency = false, -- Use a transparent background?
        terminal_colors = true, -- Use the colorscheme's colors for Neovim's :terminal?
        window_unfocused_color = false, -- When the window is out of focus, change the normal background?
      },
    })
  end
end

function config.dashboard()
  -- local home = os.getenv('HOME') -- /home/ewell
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
      icon = '  ',
      desc = 'PackerCompile                           ',
      action = 'PackerCompile',
      shortcut = 'SPC p c',
    },
    {
      icon = '   ',
      desc = 'PackerSync                              ',
      action = 'PackerSync',
      shortcut = 'SPC p s',
    },
    {
      icon = '  ',
      desc = 'Recently opened files                   ',
      action = "lua require('modules.tools.fancy_telescope').findRecentFiles()",
      shortcut = 'SPC f o',
    },
    {
      icon = '  ',
      desc = 'Find  File                              ',
      action = "lua require('modules.tools.fancy_telescope').findFiles()",
      shortcut = 'SPC f f',
    },
    {
      icon = '  ',
      desc = 'Find  Text                              ',
      action = 'Telescope live_grep',
      shortcut = 'SPC f t',
    },
    {
      icon = '  ',
      desc = 'Open Personal dotfiles                  ',
      action = "lua require('modules.tools.fancy_telescope').findDotfile()",
      shortcut = 'SPC f d',
    },
  }
  local total_plugins = #vim.tbl_keys(packer_plugins)
  local version = vim.version()
  local nvim_version_info = '  Neovim v' .. version.major .. '.' .. version.minor .. '.' .. version.patch
  db.custom_header = require('modules.ui.banner').dashboard_banner()
  db.custom_footer = { ' ' .. total_plugins .. ' plugins' .. nvim_version_info }
end

function config.heirline()
  require('modules.ui.heirline_statusline').setup()
end

function config.lualine()
  require('modules.ui.statusline')
end

function config.eviline()
  require('modules.ui.eviline')
end

function config.bufferline()
  require('modules.ui.tabline')
end

function config.neo_tree()
  require('modules.ui.explorer')
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
          { key = 'l', action = 'edit' },
          { key = 'O', action = 'system_open' },
          { key = 'h', action = 'parent_node' },
          { key = 'i', action = 'split' },
          { key = 's', action = 'vsplit' },
          -- { key = 'J', action = 'next_sibling' },
          -- { key = 'K', action = 'prev_sibling' },
        },
      },
      float = {
        enable = true,
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
        git_placement = 'after', -- before | after
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
            -- open = '',
            -- empty = '',
          },
          git = {
            unstaged = '',
            staged = '',
            unmerged = '',
            renamed = '➜',
            deleted = '',
            untracked = '',
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
  local present, colorizer = pcall(require, 'colorizer')

  if not present then
    return
  end

  local options = {
    filetypes = {
      '*',
    },
    user_default_options = {
      RGB = true, -- #RGB hex codes
      RRGGBB = true, -- #RRGGBB hex codes
      names = false, -- "Name" codes like Blue
      RRGGBBAA = false, -- #RRGGBBAA hex codes
      rgb_fn = true, -- CSS rgb() and rgba() functions
      hsl_fn = true, -- CSS hsl() and hsla() functions
      css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
      css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn
      mode = 'background', -- Set the display mode.
    },
  }

  colorizer.setup(options)
  -- execute colorizer as soon as possible
end

return config
