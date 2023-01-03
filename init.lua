require("option")
require("keymap")
require("autocommand")
require("config.lazy")

local _time = os.date('*t')
if _time.hour >= 17 or _time.hour < 8 then
  -- _G_colorscheme = 'github_dark_default'
  _G_colorscheme = 'onedark_vivid'
else
  _G_colorscheme = 'onelight'
  -- _G_colorscheme = 'github_light_default'
end
_G_colorscheme = 'onedark_vivid'
local ok, _ = pcall(vim.cmd, 'colorscheme ' .. _G_colorscheme)
if not ok then
  return
end
