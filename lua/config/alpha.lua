local alpha = require 'alpha'
local startify = require 'alpha.themes.startify'

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

startify.section.bottom_buttons.val = {
  startify.button("f", "  Fugitive", ":tabnew | G<cr>"),
  startify.button("q", "  Quit NVIM", ":qa<cr>"),
}

startify.section.footer = {
  { type = "text", val = "footer" },
}

alpha.setup(startify.config)
