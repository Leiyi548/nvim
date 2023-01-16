local alpha = require 'alpha'
local startify = require 'alpha.themes.startify'

local function mru_title()
  return "Test MRU " .. vim.fn.getcwd()
end

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
  { type = "text", val = mru_title, opts = { hl = "SpecialComment", shrink_margin = false } },
  { type = "padding", val = 1 },
  {
    type = "group",
    val = function()
      return { startify.mru(1, vim.fn.getcwd()) }
    end,
    opts = { shrink_margin = false },
  },
}

startify.section.bottom_buttons.val = {
  startify.button("t", "  Telescope git Status", ":Telescope live_grep<cr>"),
  startify.button("s", "  Telescope git Status", ":lua require('config.fancy_telescope').git_status()<cr>"),
  startify.button("f", "  Fugitive", ":tabnew | G<cr>"),
  startify.button("q", "  Quit NVIM", ":q<cr>"),
}

startify.section.footer = {
  { type = "text", val = "footer" },
}

alpha.setup(startify.config)
