-- author: Leiyi548 https://github.com/Leiyi548
-- date: 2023-01-24
-- License: MIT

local M = {}

function M.startify()
  local alpha = require('alpha')
  local startify = require('alpha.themes.startify_center')

  -- startify.section.header.val = {
  --   [[                           ▓▓▓▓▓▓▓     ]],
  --   [[                       ▓▓▓▓▓▓▓▓▓▓▓▓▓▓  ]],
  --   [[                     ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓]],
  --   [[                   ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓]],
  --   [[  ▓▓             ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓]],
  --   [[▓▓▓▓▓▓▓        ▓▓▓▓▓▓▓▓▓▓▓▓▓ ▒▓▓▓▓▓▓▓▓▓]],
  --   [[▓▓▓▓▓▓▓▓▓▓   ▓▓▓▓▓▓▓▓▓▓▓▓    ░▓▓▓▓▓▓▓▓▓]],
  --   [[  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓      ░▓▓▓▓▓▓▓▓▓]],
  --   [[    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓         ▓▓▓▓▓▓▓▓▓▓]],
  --   [[      ▓▓▓▓▓▓▓▓▓▓▓▓           ▓▓▓▓▓▓▓▓▓▓]],
  --   [[    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓         ▓▓▓▓▓▓▓▓▓▓]],
  --   [[  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓      ▒▓▓▓▓▓▓▓▓▓]],
  --   [[▓▓▓▓▓▓▓▓▓▓   ▓▓▓▓▓▓▓▓▓▓▓▓    ▒▓▓▓▓▓▓▓▓▓]],
  --   [[▓▓▓▓▓▓▓        ▓▓▓▓▓▓▓▓▓▓▓▓▓ ▒▓▓▓▓▓▓▓▓▓]],
  --   [[  ▓▓             ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓]],
  --   [[                   ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓]],
  --   [[                     ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓]],
  --   [[                        ▓▓▓▓▓▓▓▓▓▓▓▓▓  ]],
  --   [[                          ▓▓▓▓▓▓▓      ]],
  --   [[                                       ]],
  -- }

  -- alphaHeader highlight
  -- vim.api.nvim_set_hl(0, 'alphaHeader', { underline = false, bold = true, fg = '#0082cf', bg = 'NONE' })
  vim.api.nvim_set_hl(0, 'alphaHeader', { underline = false, bold = true, fg = '#ef596f', bg = 'NONE' })

  startify.section.header.opts = {
    hl = 'alphaHeader',
    position = 'center',
    shrink_margin = false,
    -- wrap = "overflow";
  }

  startify.section.top_buttons.val = {
    -- startify.button('e', '  New file', ':ene <BAR> startinsert <cr>'),
  }

  startify.section.mru_cwd.val = {
    { type = 'padding', val = 1 },
    {
      type = 'group',
      val = function()
        return { startify.mru(1, vim.fn.getcwd(), 9) }
      end,
      opts = { shrink_margin = false },
    },
  }

  startify.section.bottom_buttons.val = {
    startify.icon_button(
      'f',
      '',
      'Fuzzy Find',
      "lua require('config.fancy_telescope').find_project_files()",
      '@function'
    ),
    startify.icon_button('r', '', 'Recent File', 'Telescope oldfiles', '@function'),
    startify.icon_button('e', '', 'NeoTree', 'NeoTreeFloatToggle', '@class'),
    startify.icon_button('F', '', 'Fugitive', 'enew | G', 'SpecialComment'),
    startify.icon_button('L', '', 'Fugitive Log', 'enew | G log', 'SpecialComment'),
    startify.icon_button('h', '', 'Harpoon', 'lua require("harpoon.ui").toggle_quick_menu()', 'Operator'),
    startify.icon_button('t', '', 'Live Grep', 'Telescope live_grep', '@class'),
    startify.icon_button(
      'T',
      '',
      'Live grep [By Type]',
      "lua require('config.fancy_telescope').grep_string_by_filetype()",
      'Keyword'
    ),
    startify.icon_button(
      'c',
      '',
      'Fuzzy Git Status',
      "lua require('config.fancy_telescope').git_status()",
      '@character'
    ),
    startify.icon_button('p', '', 'Fuzzy Projects', 'Telescope projects', '@function'),
    startify.icon_button('z', '', 'Lazy', 'Lazy', 'String'),
    startify.icon_button('q', '', 'Quit NVIM', 'q', 'DiagnosticError'),
  }

  startify.section.footer = {
    { type = 'text', val = 'footer' },
  }

  alpha.setup(startify.config)
end

function M.theta()
  local alpha = require('alpha')
  local theta = require('alpha.themes.theta')
  local dashboard = require('alpha.themes.dashboard')
  local cdir = vim.fn.getcwd()

  theta.header.val = {
    "        `       --._    `-._   `-.   `.     :   /  .'   .-'   _.-'    _.--'                 ",
    "        `--.__     `--._   `-._  `-.  `. `. : .' .'  .-'  _.-'   _.--'     __.--'           ",
    "           __    `--.__    `--._  `-._ `-. `. :/ .' .-' _.-'  _.--'    __.--'    __         ",
    "            `--..__   `--.__   `--._ `-._`-.`_=_'.-'_.-' _.--'   __.--'   __..--'           ",
    "          --..__   `--..__  `--.__  `--._`-q(-_-)p-'_.--'  __.--'  __..--'   __..--         ",
    "                ``--..__  `--..__ `--.__ `-'_) (_`-' __.--' __..--'  __..--''               ",
    "          ...___        ``--..__ `--..__`--/__/  --'__..--' __..--''        ___...          ",
    "                ```---...___    ``--..__`_(<_   _/)_'__..--''    ___...---'''               ",
    "           ```-----....._____```---...___(____|_/__)___...---'''_____.....-----'''          ",
    '    ',
    'Virtue is what you do when nobody is looking. The rest is marketing. - Nassim Nicholas Taleb',
  }

  theta.header.opts = {
    position = 'center',
    hl = 'SpecialComment',
    -- wrap = "overflow";
  }

  theta.buttons.val = {
    dashboard.button('t', '  Telescope Live grep', '<cmd>Telescope live_grep<cr>'),
    dashboard.button('T', '  Telescope Live grep [By type]', '<cmd><cr>'),
    dashboard.button('s', '  Telescope git Status', "<cmd>lua require('config.fancy_telescope').git_status()<cr>"),
    dashboard.button('f', '  Fugitive', '<cmd>enew | G<cr>'),
    dashboard.button('q', '  Quit NVIM', '<cmd>q<cr>'),
  }

  theta.section_mru.val = {
    {
      type = 'text',
      val = 'MRU ' .. cdir,
      opts = {
        hl = 'error',
        shrink_margin = false,
        position = 'center',
      },
    },
    -- { type = 'padding', val = 1 },
    {
      type = 'group',
      val = function()
        return { theta.mru(1, cdir, 9) }
      end,
      opts = { shrink_margin = false },
    },
  }

  alpha.setup(theta.config)
end

return M
