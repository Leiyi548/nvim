local M = {}

function M.onedarkpro()
  require('onedarkpro').setup({
    colors = {
      dark = {
        statusline_bg = '#2e323b', -- gray
        statuscolumn_border = '#3c4047',
        indentline = '#3c4047',
        telescope_prompt = "require('onedarkpro.helpers').darken('bg', 1, 'onedark')",
        telescope_results = "require('onedarkpro.helpers').darken('bg', 4, 'onedark')",
        telescope_preview = "require('onedarkpro.helpers').darken('bg', 6, 'onedark')",
        telescope_selection = "require('onedarkpro.helpers').darken('bg', 8, 'onedark')",
        copilot = "require('onedarkpro.helpers').darken('gray', 8, 'onedark')",
        breadcrumbs = "require('onedarkpro.helpers').darken('gray', 10, 'onedark')",
        lspsaga_winbar_folder_name_fg = '#acad8f',
      },
      light = {
        comment = '#bebebe', -- Revert back to original comment colors
        statusline_bg = '#f0f0f0', -- gray
        statuscolumn_border = "require('onedarkpro.helpers').darken('bg', 3, 'onelight')",
        telescope_prompt = "require('onedarkpro.helpers').darken('bg', 2, 'onelight')",
        telescope_results = "require('onedarkpro.helpers').darken('bg', 5, 'onelight')",
        telescope_preview = "require('onedarkpro.helpers').darken('bg', 7, 'onelight')",
        telescope_selection = "require('onedarkpro.helpers').darken('bg', 9, 'onelight')",
        copilot = "require('onedarkpro.helpers').lighten('gray', 8, 'onelight')",
        breadcrumbs = "require('onedarkpro.helpers').lighten('gray', 8, 'onelight')",
        lspsaga_winbar_folder_name_fg = '#f7bb3b',
      },
    }, -- Override default colors or create your own
    highlights = {
      HLIndentLine = { fg = '#b757c2' },
      CmpItemMenu = { fg = '#b757c2' },
      -- lspsaga
      LspSagaWinbarFolderName = { fg = '${lspsaga_winbar_folder_name_fg}' },
      -- telescope
      TelescopeBorder = {
        fg = '${telescope_results}',
        bg = '${telescope_results}',
      },
      TelescopePromptBorder = {
        fg = '${telescope_prompt}',
        bg = '${telescope_prompt}',
      },
      TelescopePromptCounter = { fg = '${fg}' },
      TelescopePromptNormal = { fg = '${fg}', bg = '${telescope_prompt}' },
      TelescopePromptPrefix = {
        fg = '${purple}',
        bg = '${telescope_prompt}',
      },
      TelescopePromptTitle = {
        fg = '${telescope_prompt}',
        bg = '${purple}',
      },
      TelescopePreviewTitle = {
        fg = '${telescope_results}',
        bg = '${green}',
      },
      TelescopeResultsTitle = {
        fg = '${telescope_results}',
        bg = '${telescope_results}',
      },
      TelescopeMatching = { fg = '${blue}' },
      TelescopeNormal = { bg = '${telescope_results}' },
      TelescopeSelection = { bg = '${telescope_selection}', fg = '#9a77cf' },
      TelescopePreviewNormal = { bg = '${telescope_preview}' },
      TelescopePreviewBorder = { fg = '${telescope_preview}', bg = '${telescope_preview}' },
    }, -- Override default highlight groups or create your own
    filetypes = { -- Override which filetype highlight groups are loaded
      -- See the 'Configuring filetype highlights' section for the available list
    },
    plugins = { -- Override which plugin highlight groups are loaded
      -- See the 'Supported plugins' section for the available list
    },
    styles = { -- For example, to apply bold and italic, use "bold,italic"
      types = 'NONE', -- Style that is applied to types
      numbers = 'NONE', -- Style that is applied to numbers
      strings = 'NONE', -- Style that is applied to strings
      comments = 'NONE', -- Style that is applied to comments
      keywords = 'NONE', -- Style that is applied to keywords
      constants = 'NONE', -- Style that is applied to constants
      functions = 'NONE', -- Style that is applied to functions
      operators = 'NONE', -- Style that is applied to operators
      variables = 'NONE', -- Style that is applied to variables
      conditionals = 'NONE', -- Style that is applied to conditionals
      virtual_text = 'NONE', -- Style that is applied to virtual text
    },
    options = {
      bold = true, -- Use bold styles?
      italic = true, -- Use italic styles?
      underline = true, -- Use underline styles?
      undercurl = true, -- Use undercurl styles?

      cursorline = true, -- Use cursorline highlighting?
      transparency = false, -- Use a transparent background?
      terminal_colors = true, -- Use the theme's colors for Neovim's :terminal?
      highlight_inactive_windows = false, -- When the window is out of focus, change the normal background?
    },
  })
end

function M.rose_pine()
  require('rose-pine').setup({
    --- @usage 'main' | 'moon'
    dark_variant = 'main',
    bold_vert_split = false,
    dim_nc_background = false,
    disable_background = false,
    disable_float_background = false,
    disable_italics = true,
    --- @usage string hex value or named color from rosepinetheme.com/palette

    groups = {
      background = 'base',
      panel = 'surface',
      border = 'highlight_med',
      comment = 'muted',
      link = 'iris',
      punctuation = 'subtle',
      error = 'love',
      hint = 'iris',
      info = 'foam',
      warn = 'gold',
      headings = {
        h1 = 'iris',
        h2 = 'foam',
        h3 = 'rose',
        h4 = 'gold',
        h5 = 'pine',
        h6 = 'foam',
      },
      -- or set all headings at once
      -- headings = 'subtle'
    },
    -- Change specific vim highlight groups
    highlight_groups = {
      ColorColumn = { bg = 'rose' },
      WildMenu = { bg = 'pine' },
    },
  })
end

function M.github_nvim_theme()
  -- Example config in Lua
  require('github-theme').setup({
    theme_style = 'dark',
    comment_style = 'NONE',
    function_style = 'NONE',
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

function M.everforest()
  require('everforest').setup({
    -- Controls the "hardness" of the background. Options are "soft", "medium" or "hard".
    -- Default is "medium".
    background = 'hard',
    -- How much of the background should be transparent. Options are 0, 1 or 2.
    -- Default is 0.
    --
    -- 2 will have more UI components be transparent (e.g. status line
    -- background).
    transparent_background_level = 0,
    -- Whether italics should be used for keywords, builtin types and more.
    italics = false,
    -- Disable italic fonts for comments. Comments are in italics by default, set
    -- this to `true` to make them _not_ italic!
    disable_italic_comments = true,
  })
end

return M
