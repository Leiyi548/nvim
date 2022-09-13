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
      -- neogit
      hls.NeogitDiffAdd = {
        fg = c.green,
        bg = c.none,
      }
      hls.NeogitDiffDelete = {
        fg = c.gitSigns.delete,
        bg = c.none,
      }
      hls.NeogitDiffAddHighlight = {
        fg = c.none,
        bg = c.none,
      }
      hls.NeogitDiffDeleteHighlight = {
        fg = c.gitSigns.delete,
        bg = c.none,
      }
      hls.NeogitDiffContextHighlight = {
        bg = c.none,
      }
      hls.NeogitObjectId = {
        fg = c.orange,
        bg = c.none,
      }
      hls.NeogitHunkHeader = {
        fg = c.cyan,
        bg = c.none,
      }
      hls.NeogitHunkHeaderHighlight = {
        fg = c.orange,
        bg = c.none,
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
