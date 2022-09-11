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

function config.tokyonight()
  require('tokyonight').setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    style = 'night', -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
    transparent = true, -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    styles = {
      -- Style to be applied to different syntax groups
      -- Value is any valid attr-list value `:help attr-list`
      comments = 'italic',
      keywords = 'NONE',
      functions = 'NONE',
      variables = 'NONE',
      -- Background styles. Can be "dark", "transparent" or "normal"
      sidebars = 'transparent', -- style for sidebars, see below
      floats = 'transparent', -- style for floating windows
    },
    sidebars = { 'qf', 'help' }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
    day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
    hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
    dim_inactive = false, -- dims inactive windows
    lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

    --- You can override specific color groups to use other groups or a hex color
    --- fucntion will be called with a ColorScheme table
    ---@param colors ColorScheme
    on_colors = function(colors) end,

    --- You can override specific highlights to use other groups or a hex color
    --- fucntion will be called with a Highlights and ColorScheme table
    ---@param hls Highlights
    ---@param c ColorScheme
    -- 记住修改后，packercompile
    on_highlights = function(hls, c)
      -- current
      hls.CursorLineNr = {
        fg = c.blue1,
      }
      hls.markdownBold = {
        fg = c.orange,
      }
      -- markdown
      hls.LineNr = {
        fg = c.blue1,
      }
      -- telescope
      hls.TelescopeSelection = {
        fg = c.orange,
        style = 'bold',
      }
      hls.TelescopeNormal = {
        fg = c.fg,
        bg = c.none,
      }
      hls.TelescopeResultsDiffAdd = {
        fg = c.green,
        bg = c.none,
      }
      hls.TelescopeResultsDiffChange = {
        fg = '#61afef',
        bg = c.none,
      }
      hls.TelescopeResultsDiffDelete = {
        fg = c.gitSigns.delete,
        bg = c.none,
      }
      hls.TelescopeResultsDiffUntracked = {
        fg = c.orange,
        bg = c.none,
      }
      -- TreesitterContext default link normal float
      hls.TreesitterContext = {
        bg = c.bg_visual,
      }
      -- gitsigns
      hls.GitSignsAdd = {
        fg = c.green,
        bg = c.green,
      }
      hls.GitSignsChange = {
        fg = '#61afef',
        bg = '#61afef',
      }
      -- navic
      hls.NavicText = {
        fg = c.dark3,
      }
      hls.NavicIconsPackage = {
        fg = c.orange,
      }
      hls.NavicIconsField = {
        fg = c.blue,
      }
      hls.NavicIconsVariable = {
        fg = c.magenta,
      }
      hls.NavicIconsInterface = {
        fg = c.blue,
      }
      hls.NavicIconsMethod = {
        fg = c.blue,
      }
      hls.NavicIconsProperty = {
        fg = c.blue,
      }
      hls.NavicIconsConstructor = {
        fg = c.blue,
      }
      hls.NavicIconsMethod = {
        fg = c.blue,
      }
      hls.NavicIconsFunction = {
        fg = c.blue,
      }
      hls.NavicIconsClass = {
        fg = c.orange,
      }
      hls.NavicIconsInterface = {
        fg = c.orange,
      }
      hls.NavicIconsStruct = {
        fg = c.orange,
      }
      hls.NavicIconsEvent = {
        fg = c.orange,
      }
      hls.NavicIconsEnum = {
        fg = c.orange,
      }
      -- custom my winbar hightlight
      hls.WinbarFilename = {
        fg = c.fg_dark,
      }
      hls.WinbarBufferNumber = {
        fg = c.cyan,
      }
    end,
  })
end

function config.kanagawa()
  -- Default options:
  require('kanagawa').setup({
    undercurl = true, -- enable undercurls
    commentStyle = { italic = true },
    functionStyle = { italic = false },
    keywordStyle = { italic = false },
    statementStyle = { bold = false },
    typeStyle = {},
    variablebuiltinStyle = {},
    specialReturn = true, -- special highlight for the return keyword
    specialException = true, -- special highlight for exception handling keywords
    transparent = false, -- do not set background color
    dimInactive = false, -- dim inactive window `:h hl-NormalNC`
    globalStatus = false, -- adjust window separators highlight for laststatus=3
    terminalColors = true, -- define vim.g.terminal_color_{0,17}
    colors = {},
    overrides = {},
    theme = 'default',
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
      functions = 'NONE', -- Style that is applied to functions
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

function config.material()
  vim.g.material_style = 'darker' -- lighter darker oceanic palenight deep ocean
  require('material').setup({

    contrast = {
      sidebars = true, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
      floating_windows = true, -- Enable contrast for floating windows
      line_numbers = false, -- Enable contrast background for line numbers
      sign_column = false, -- Enable contrast background for the sign column
      cursor_line = true, -- Enable darker background for the cursor line
      non_current_windows = false, -- Enable darker background for non-current windows
      popup_menu = false, -- Enable lighter background for the popup menu
    },

    italics = {
      comments = true, -- Enable italic comments
      keywords = false, -- Enable italic keywords
      functions = false, -- Enable italic functions
      strings = false, -- Enable italic strings
      variables = false, -- Enable italic variables
    },

    contrast_filetypes = { -- Specify which filetypes get the contrasted (darker) background
      'terminal', -- Darker terminal background
      'packer', -- Darker packer background
      'qf', -- Darker qf list background
    },

    high_visibility = {
      lighter = false, -- Enable higher contrast text for lighter style
      darker = false, -- Enable higher contrast text for darker style
    },

    disable = {
      colored_cursor = false, -- Disable the colored cursor
      borders = false, -- Disable borders between verticaly split windows
      background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
      term_colors = false, -- Prevent the theme from setting terminal colors
      eob_lines = false, -- Hide the end-of-buffer lines
    },

    lualine_style = 'default', -- Lualine style ( can be 'stealth' or 'default' )

    async_loading = true, -- Load parts of the theme asyncronously for faster startup (turned on by default)

    custom_highlights = {}, -- Overwrite highlights with your own

    plugins = { -- Here, you can disable(set to false) plugins that you don't use or don't want to apply the theme to
      trouble = true,
      nvim_cmp = true,
      neogit = true,
      gitsigns = true,
      git_gutter = true,
      telescope = true,
      nvim_tree = true,
      sidebar_nvim = true,
      lsp_saga = true,
      nvim_dap = true,
      nvim_navic = true,
      which_key = true,
      sneak = true,
      hop = true,
      indent_blankline = true,
      nvim_illuminate = true,
      mini = true,
    },
  })
end

function config.gruvbox_material()
  -- more information please see :help gruvbox-material
  vim.g.gruvbox_material_background = 'material'
  vim.g.gruvbox_material_better_performance = 1
  vim.g.gruvbox_material_background = 'hard'
  vim.g.gruvbox_material_disable_italic_comment = 0
  -- -- enable bold function name
  vim.g.gruvbox_material_enable_bold = 1
  vim.g.gruvbox_material_enable_italic = 1
end

function config.gruvbox_baby()
  vim.g.gruvbox_baby_background_color = 'dark'
  vim.g.gruvbox_baby_keyword_style = 'NONE'
  vim.g.gruvbox_baby_comment_style = 'italic'
  vim.g.gruvbox_baby_string_style = 'NONE'
  vim.g.gruvbox_baby_function_style = 'NONE'
  vim.g.gruvbox_baby_keyword_style = 'NONE'
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
    term_colors = false,
    compile = {
      enabled = false,
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
          errors = { 'italic' },
          hints = { 'italic' },
          warnings = { 'italic' },
          information = { 'italic' },
        },
        underlines = {
          errors = { 'underline' },
          hints = { 'underline' },
          warnings = { 'underline' },
          information = { 'underline' },
        },
      },
      coc_nvim = false,
      lsp_trouble = false,
      cmp = true,
      lsp_saga = true,
      gitgutter = false,
      gitsigns = true,
      leap = false,
      telescope = true,
      nvimtree = {
        enabled = true,
        show_root = true,
        transparent_panel = false,
      },
      neotree = {
        enabled = false,
        show_root = true,
        transparent_panel = false,
      },
      dap = {
        enabled = false,
        enable_ui = false,
      },
      which_key = false,
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
      vimwiki = true,
      beacon = true,
      navic = false,
      overseer = false,
    },
    color_overrides = {},
    highlight_overrides = {},
  })
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
    -- {
    --   icon = '  ',
    --   desc = 'Recently latest session                 ',
    --   shortcut = 'SPC s l',
    --   action = 'SessionLoad',
    -- },
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
      shortcut = 'SPC f r',
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
  db.custom_header = {
    [[                           ▓▓▓▓▓▓▓     ]],
    [[                       ▓▓▓▓▓▓▓▓▓▓▓▓▓▓  ]],
    [[                     ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓]],
    [[                   ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓]],
    [[  ▓▓             ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓]],
    [[▓▓▓▓▓▓▓        ▓▓▓▓▓▓▓▓▓▓▓▓▓ ▒▓▓▓▓▓▓▓▓▓]],
    [[▓▓▓▓▓▓▓▓▓▓   ▓▓▓▓▓▓▓▓▓▓▓▓    ░▓▓▓▓▓▓▓▓▓]],
    [[  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓      ░▓▓▓▓▓▓▓▓▓]],
    [[    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓         ▓▓▓▓▓▓▓▓▓▓]],
    [[      ▓▓▓▓▓▓▓▓▓▓▓▓           ▓▓▓▓▓▓▓▓▓▓]],
    [[    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓         ▓▓▓▓▓▓▓▓▓▓]],
    [[  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓      ▒▓▓▓▓▓▓▓▓▓]],
    [[▓▓▓▓▓▓▓▓▓▓   ▓▓▓▓▓▓▓▓▓▓▓▓    ▒▓▓▓▓▓▓▓▓▓]],
    [[▓▓▓▓▓▓▓        ▓▓▓▓▓▓▓▓▓▓▓▓▓ ▒▓▓▓▓▓▓▓▓▓]],
    [[  ▓▓             ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓]],
    [[                   ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓]],
    [[                     ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓]],
    [[                        ▓▓▓▓▓▓▓▓▓▓▓▓▓  ]],
    [[                          ▓▓▓▓▓▓▓      ]],
    [[                                       ]],
    -- [[             Start Editing             ]],
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
