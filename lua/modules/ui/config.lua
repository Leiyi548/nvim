-- author: Leiyi548 https://github.com/Leiyi548
-- date: 2022-10-26
-- License: MIT

local config = {}

function config.github()
  if _G_colorscheme == 'github_light' then
    require('github-theme').setup({
      theme_style = 'NONE',
      function_style = 'NONE',
      comment_style = 'Italic',
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

function config.tokyonight()
  require('tokyonight').setup({
    -- your configuration comes here
    -- or leave it empty to use the default settings
    style = 'night', -- The theme comes in three styles, `storm`, a darker variant `night` and `day`
    transparent = true, -- Enable this to disable setting the background color
    terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
    styles = {
      -- Style to be applied to different syntax groups
      -- Value is any valid attr-list value for `:help nvim_set_hl`
      comments = { italic = true },
      keywords = {},
      functions = { italic = true },
      variables = {},
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
      -- hls.LineNr = {
      --   fg = '#0087d7',
      -- }
      hls.CursorLine = {
        bg = c.none,
        style = { bold = true },
      }
      -- current line
      hls.CursorLineNr = {
        fg = c.blue,
        style = { bold = true },
      }
      hls.Function = {
        fg = c.blue,
        style = 'bold',
      }
      -- TodoComment
      hls.TodoBgFix = {
        bg = c.none,
      }
      hls.TodoBgHack = {
        bg = c.none,
      }
      hls.TodoBgNote = {
        bg = c.none,
      }
      hls.TodoBgREPF = {
        bg = c.none,
      }
      hls.TodoBgTEST = {
        bg = c.none,
      }
      -- cmp highlight selected line
      hls.PmenuSel = {
        bg = c.bg_visual,
      }
      hls.markdownBold = {
        fg = c.orange,
        style = 'bold',
      }
      hls.DashboardFooter = {
        fg = c.orange,
        style = 'bold',
      }
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
      -- hls.TreesitterContext = {
      --   bg = c.bg_visual,
      -- }
      -- gitsigns
      -- hls.GitSignsAdd = {
      --   fg = c.green,
      --   bg = c.green,
      -- }
      -- hls.GitSignsChange = {
      --   fg = '#61afef',
      --   bg = '#61afef',
      -- }
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
      hls.DiagnosticVirtualTextError = {
        fg = c.error,
        bg = c.none,
      }
      hls.DiagnosticVirtualTextWarn = {
        fg = c.warning,
        bg = c.none,
      }
      hls.DiagnosticVirtualTextInfo = {
        fg = c.info,
        bg = c.none,
      }
      hls.DiagnosticVirtualTextHint = {
        fg = c.hint,
        bg = c.none,
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
      functions = { 'italic' },
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
      icon = '  ',
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
  local total_plugins = #vim.tbl_keys(packer_plugins)
  local version = vim.version()
  local nvim_version_info = '  Neovim v' .. version.major .. '.' .. version.minor .. '.' .. version.patch
  db.custom_footer = { ' ' .. total_plugins .. ' plugins' .. nvim_version_info }
end

function config.tabline()
  require('tabline').setup({
    show_index = true, -- show tab index
    show_modify = true, -- show buffer modification indicator
    modify_indicator = '[+]', -- modify indicator
    no_name = '[No name]', -- no name buffer name
  })
end

function config.lualine()
  require('modules.ui.lualine')
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
      hide_root_folder = false,
      side = 'right', -- left right
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
          { key = 'o', action = 'edit' },
          { key = 'O', action = 'system_open' },
          { key = 'h', action = 'parent_node' },
          { key = 'i', action = 'split' },
          { key = 's', action = 'vsplit' },
          -- { key = 'J', action = 'next_sibling' },
          -- { key = 'K', action = 'prev_sibling' },
        },
      },
      -- float = {
      --   enable = false,
      --   open_win_config = {
      --     relative = 'editor',
      --     border = 'rounded',
      --     width = 30,
      --     height = 30,
      --     row = 1,
      --     col = 1,
      --   },
      -- },
      float = { enable = true, open_win_config = { border = 'rounded', width = 40, height = 30, row = 0, col = 999 } },
      --
      -- Smart C-l
      vim.keymap.set('n', '<C-l>', function()
        local get_current_window_num = vim.api.nvim_call_function('winnr', {})
        local right_window_num = vim.api.nvim_call_function('winnr', { 'l' })
        if get_current_window_num == right_window_num then
          return '<cmd>NvimTreeGoTree<cr>'
        else
          return '<cmd>wincmd l<cr>'
        end
      end, opts(expr, silent, noremap)),
    },
    renderer = {
      add_trailing = false,
      group_empty = false,
      highlight_git = false,
      highlight_opened_files = 'none',
      root_folder_modifier = ':~',
      indent_markers = {
        enable = true,
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

function config.neo_tree()
  local icons = require('modules.ui.icons')
  require('neo-tree').setup({
    close_if_last_window = false, -- Close Neo-tree if it is the last window left in the tab
    popup_border_style = 'rounded',
    enable_git_status = true,
    enable_diagnostics = true,
    sort_case_insensitive = false, -- used when sorting files and directories in the tree
    sort_function = nil, -- use a custom function for sorting files and directories in the tree
    -- sort_function = function (a,b)
    --       if a.type == b.type then
    --           return a.path > b.path
    --       else
    --           return a.type > b.type
    --       end
    --   end , -- this sorts files and directories descendantly
    default_component_configs = {
      container = {
        enable_character_fade = true,
      },
      indent = {
        indent_size = 2,
        padding = 1, -- extra padding on left hand side
        -- indent guides
        with_markers = true,
        indent_marker = '│',
        last_indent_marker = '└',
        highlight = 'NeoTreeIndentMarker',
        -- expander config, needed for nesting files
        with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = '',
        expander_expanded = '',
        expander_highlight = 'NeoTreeExpander',
      },
      icon = {
        folder_closed = '',
        folder_open = '',
        folder_empty = '',
        -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
        -- then these will never be used.
        default = '*',
        highlight = 'NeoTreeFileIcon',
      },
      modified = {
        symbol = '[+]',
        highlight = 'NeoTreeModified',
      },
      name = {
        trailing_slash = false,
        use_git_status_colors = true,
        highlight = 'NeoTreeFileName',
      },
      git_status = {
        symbols = {
          -- Change type
          added = icons.git.add, -- or "✚", but this is redundant info if you use git_status_colors on the name
          modified = '', -- or "", but this is redundant info if you use git_status_colors on the name
          deleted = icons.git.delete, -- this can only be used in the git_status source
          renamed = icons.git.renamed, -- this can only be used in the git_status source
          -- Status type
          untracked = icons.git.untracked,
          ignored = icons.git.ignored,
          unstaged = icons.git.unstaged,
          staged = icons.git.staged,
          conflict = icons.git.conflict,
        },
      },
    },
    window = {
      position = 'left',
      width = 40,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ['<space>'] = {
          'toggle_node',
          nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
        },
        ['<2-LeftMouse>'] = 'open',
        ['<cr>'] = 'open',
        ['o'] = 'open',
        ['i'] = 'open_split',
        ['s'] = 'open_vsplit',
        -- ["S"] = "split_with_window_picker",
        -- ["s"] = "vsplit_with_window_picker",
        ['t'] = 'open_tabnew',
        ['w'] = 'open_with_window_picker',
        ['C'] = 'close_node',
        ['X'] = 'close_all_nodes',
        ['O'] = 'expand_all_nodes',
        ['a'] = {
          'add',
          -- some commands may take optional config options, see `:h neo-tree-mappings` for details
          config = {
            show_path = 'relative', -- "none", "relative", "absolute"
          },
        },
        ['A'] = 'add_directory', -- also accepts the optional config.show_path option like "add".
        ['d'] = 'delete',
        ['r'] = 'rename',
        ['y'] = 'copy_to_clipboard',
        ['x'] = 'cut_to_clipboard',
        ['p'] = 'paste_from_clipboard',
        ['c'] = 'copy', -- takes text input for destination, also accepts the optional config.show_path option like "add":
        -- ["c"] = {
        --  "copy",
        --  config = {
        --    show_path = "none" -- "none", "relative", "absolute"
        --  }
        --}
        ['m'] = 'move', -- takes text input for destination, also accepts the optional config.show_path option like "add".
        ['q'] = 'close_window',
        ['R'] = 'refresh',
        ['?'] = 'show_help',
        ['<'] = 'prev_source',
        ['>'] = 'next_source',
      },
    },
    nesting_rules = {},
    source_selector = {
      winbar = false,
      statusline = false,
    },
    filesystem = {
      filtered_items = {
        visible = false, -- when true, they will just be displayed differently than normal items
        hide_dotfiles = true,
        hide_gitignored = true,
        hide_hidden = true, -- only works on Windows for hidden files/directories
        hide_by_name = {
          --"node_modules"
        },
        hide_by_pattern = { -- uses glob style patterns
          --"*.meta",
          --"*/src/*/tsconfig.json",
        },
        always_show = { -- remains visible even if other settings would normally hide it
          --".gitignored",
        },
        never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
          --".DS_Store",
          --"thumbs.db"
        },
      },
      follow_current_file = true, -- This will find and focus the file in the active buffer every
      -- time the current file is changed while the tree is open.
      group_empty_dirs = false, -- when true, empty folders will be grouped together
      hijack_netrw_behavior = 'open_default', -- netrw disabled, opening a directory opens neo-tree
      -- in whatever position is specified in window.position
      -- "open_current",  -- netrw disabled, opening a directory opens within the
      -- window like netrw would, regardless of window.position
      -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
      use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
      -- instead of relying on nvim autocmd events.
      window = {
        mappings = {
          ['<bs>'] = 'navigate_up',
          ['.'] = 'set_root',
          ['H'] = 'toggle_hidden',
          ['/'] = 'fuzzy_finder',
          ['D'] = 'fuzzy_finder_directory',
          ['f'] = 'filter_on_submit',
          ['<c-x>'] = 'clear_filter',
          ['[g'] = 'prev_git_modified',
          [']g'] = 'next_git_modified',
        },
      },
    },
    buffers = {
      follow_current_file = true, -- This will find and focus the file in the active buffer every
      -- time the current file is changed while the tree is open.
      group_empty_dirs = true, -- when true, empty folders will be grouped together
      show_unloaded = true,
      window = {
        position = 'float',
        mappings = {
          ['d'] = 'buffer_delete',
          ['bd'] = 'buffer_delete',
          ['<bs>'] = 'navigate_up',
          ['.'] = 'set_root',
        },
      },
    },
    git_status = {
      window = {
        position = 'float',
        mappings = {
          ['A'] = 'git_add_all',
          ['gu'] = 'git_unstage_file',
          ['ga'] = 'git_add_file',
          ['gr'] = 'git_revert_file',
          ['gc'] = 'git_commit',
          ['gp'] = 'git_push',
          ['gg'] = 'git_commit_and_push',
        },
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
    show_current_context = true,
    -- 显示下划线
    -- show_current_context_start = true,
    -- space_char_blankline = ' ',
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

function config.dressing()
  require('dressing').setup({
    input = {
      -- Set to false to disable the vim.ui.input implementation
      enabled = true,

      -- Default prompt string
      default_prompt = 'Input:',

      -- Can be 'left', 'right', or 'center'
      prompt_align = 'center',

      -- When true, <Esc> will close the modal
      insert_only = true,

      -- When true, input will start in insert mode.
      start_in_insert = true,

      -- These are passed to nvim_open_win
      anchor = 'SW',
      border = 'rounded',
      -- 'editor' and 'win' will default to being centered
      relative = 'editor',

      -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
      prefer_width = 40,
      width = nil,
      -- min_width and max_width can be a list of mixed types.
      -- min_width = {20, 0.2} means "the greater of 20 columns or 20% of total"
      max_width = { 140, 0.9 },
      min_width = { 20, 0.2 },

      -- Window transparency (0-100)
      winblend = 0,
      -- Change default highlight groups (see :help winhl)
      winhighlight = '',

      -- Set to `false` to disable
      mappings = {
        n = {
          ['<Esc>'] = 'Close',
          ['<CR>'] = 'Confirm',
        },
        i = {
          ['<C-c>'] = 'Close',
          ['<CR>'] = 'Confirm',
          ['<Up>'] = 'HistoryPrev',
          ['<Down>'] = 'HistoryNext',
        },
      },
      -- see :help dressing_get_config
      get_config = nil,
    },
    select = {
      -- Set to false to disable the vim.ui.select implementation
      enabled = true,

      -- Priority list of preferred vim.select implementations
      backend = { 'telescope', 'fzf_lua', 'fzf', 'builtin', 'nui' },

      -- Trim trailing `:` from prompt
      trim_prompt = true,

      -- Options for telescope selector
      -- These are passed into the telescope picker directly. Can be used like:
      -- telescope = require('telescope.themes').get_ivy({...})
      telescope = nil,

      -- Options for fzf selector
      fzf = {
        window = {
          width = 0.5,
          height = 0.4,
        },
      },

      -- Options for fzf_lua selector
      fzf_lua = {
        winopts = {
          width = 0.5,
          height = 0.4,
        },
      },

      -- Options for nui Menu
      nui = {
        position = '50%',
        size = nil,
        relative = 'editor',
        border = {
          style = 'rounded',
        },
        buf_options = {
          swapfile = false,
          filetype = 'DressingSelect',
        },
        win_options = {
          winblend = 10,
        },
        max_width = 80,
        max_height = 40,
        min_width = 40,
        min_height = 10,
      },

      -- Options for built-in selector
      builtin = {
        -- These are passed to nvim_open_win
        anchor = 'NW',
        border = 'rounded',
        -- 'editor' and 'win' will default to being centered
        relative = 'editor',

        -- Window transparency (0-100)
        winblend = 10,
        -- Change default highlight groups (see :help winhl)
        winhighlight = '',

        -- These can be integers or a float between 0 and 1 (e.g. 0.4 for 40%)
        -- the min_ and max_ options can be a list of mixed types.
        -- max_width = {140, 0.8} means "the lesser of 140 columns or 80% of total"
        width = nil,
        max_width = { 140, 0.8 },
        min_width = { 40, 0.2 },
        height = nil,
        max_height = 0.9,
        min_height = { 10, 0.2 },

        -- Set to `false` to disable
        mappings = {
          ['<Esc>'] = 'Close',
          ['<C-c>'] = 'Close',
          ['<CR>'] = 'Confirm',
        },

        override = function(conf)
          -- This is the config that will be passed to nvim_open_win.
          -- Change values here to customize the layout
          return conf
        end,
      },

      -- Used to override format_item. See :help dressing-format
      format_item_override = {},

      -- see :help dressing_get_config
      get_config = nil,
    },
  })
end

function config.colorful_winsep()
  require('colorful-winsep').setup({
    highlight = {
      guibg = 'none',
      guifg = '#957CC6',
    },
    interval = 100,
    no_exec_files = {
      'packer',
      'TelescopePrompt',
      'mason',
      'CompetiTest',
      'toggleterm',
      'NvimTree',
      'neo-tree',
      'DressingInput',
      'lspsagahover',
      'sagasignature',
      'sagacodeaction',
      'sagarename',
      'sagacodeaction',
      'lspsagafinder',
      'harpoon',
    },
    symbols = { '━', '┃', '┏', '┓', '┗', '┛' },
  })
end

function config.barbecue()
  require('barbecue').setup({
    ---whether to attach navic to language servers automatically
    ---@type boolean
    attach_navic = true,

    ---whether to create winbar updater autocmd
    ---@type boolean
    create_autocmd = true,

    ---buftypes to enable winbar in
    ---@type string[]
    include_buftypes = { '' },

    ---filetypes not to enable winbar in
    ---@type string[]
    exclude_filetypes = { 'toggleterm' },

    ---returns a string to be shown at the end of winbar
    ---@type fun(bufnr: number): number|string
    custom_section = function()
      return ''
    end,

    modifiers = {
      ---filename modifiers applied to dirname
      ---@type string
      dirname = ':~:.',

      ---filename modifiers applied to basename
      ---@type string
      basename = '',
    },

    ---icons used by barbecue
    ---@type table<string, string>
    symbols = {
      ---entry separator
      ---@type string
      separator = '',

      ---modification indicator
      ---`false` to disable
      ---@type false|string
      modified = false,

      ---context placeholder for the root node
      ---`false` to disable
      ---@type false|string
      default_context = '…',
    },

    ---icons for different context entry kinds
    ---@type table<string, string>
    kinds = {
      File = '',
      Package = '',
      Module = '',
      Namespace = '',
      Macro = '',
      Class = '',
      Constructor = '',
      Field = '',
      Property = '',
      Method = '',
      Struct = '',
      Event = '',
      Interface = '',
      Enum = '',
      EnumMember = '',
      Constant = '',
      Function = '',
      TypeParameter = '',
      Variable = '',
      Operator = '',
      Null = '',
      Boolean = '',
      Number = '',
      String = '',
      Key = '',
      Array = '',
      Object = '',
    },
  })
end

return config
