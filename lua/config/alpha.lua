-- author: Leiyi548 https://github.com/Leiyi548
-- date: 2023-01-17
-- License: MIT

local M = {}

function M.startify()
  local alpha = require 'alpha'
  local startify = require 'alpha.themes.startify_center'

  startify.section.header.val = {
    [[                                   __                ]],
    [[      ___     ___    ___   __  __ /\_\    ___ ___    ]],
    [[     / _ `\  / __`\ / __`\/\ \/\ \\/\ \  / __` __`\  ]],
    [[    /\ \/\ \/\  __//\ \_\ \ \ \_/ |\ \ \/\ \/\ \/\ \ ]],
    [[    \ \_\ \_\ \____\ \____/\ \___/  \ \_\ \_\ \_\ \_\]],
    [[     \/_/\/_/\/____/\/___/  \/__/    \/_/\/_/\/_/\/_/]],
  }

  startify.section.top_buttons.val = {
    startify.button("e", "  New file", ":ene <BAR> startinsert <cr>"),
  }

  startify.section.mru_cwd.val = {
    { type = "padding", val = 1 },
    {
      type = "group",
      val = function()
        return { startify.mru(1, vim.fn.getcwd(), 9) }
      end,
      opts = { shrink_margin = false },
    },
  }

  startify.section.bottom_buttons.val = {
    startify.button("t", "  Telescope Live grep", ":Telescope live_grep<cr>"),
    startify.button("s", "  Telescope git Status", ":lua require('config.fancy_telescope').git_status()<cr>"),
    startify.button("f", "  Fugitive", ":enew | G<cr>"),
    startify.button("q", "  Quit NVIM", ":q<cr>"),
  }

  startify.section.footer = {
    { type = "text", val = "footer" },
  }

  alpha.setup(startify.config)
end

function M.theta()
  local alpha = require 'alpha'
  local theta = require 'alpha.themes.theta'
  local dashboard = require("alpha.themes.dashboard")
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
    hl = "SpecialComment",
    -- wrap = "overflow";
  }

  theta.buttons.val = {
    dashboard.button("t", "  Telescope Live grep", ":Telescope live_grep<cr>"),
    dashboard.button("s", "  Telescope git Status", ":lua require('config.fancy_telescope').git_status()<cr>"),
    dashboard.button("f", "  Fugitive", ":enew | G<cr>"),
    dashboard.button("q", "  Quit NVIM", ":q<cr>"),
  }



  theta.section_mru.val = {
    {
      type = "text",
      val = "MRU " .. cdir,
      opts = {
        hl = "error",
        shrink_margin = false,
        position = "center",
      },
    },
    { type = "padding", val = 1 },
    {
      type = "group",
      val = function()
        return { theta.mru(1, cdir, 9) }
      end,
      opts = { shrink_margin = false },
    },
  }

  alpha.setup(theta.config)
end

return M
