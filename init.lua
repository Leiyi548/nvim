require('option')
require('keymap')
require('autocommand')
require('statuscolumn')
require('config.lazy')

local _time = os.date('*t')
if _time.hour >= 16 or _time.hour < 8 then
  -- _G_colorscheme = 'github_dark_default'
  -- _G_colorscheme = 'onedark_vivid'
  _G_colorscheme = 'rose-pine'
else
  _G_colorscheme = 'onelight'
  -- _G_colorscheme = 'github_light_default'
end
local ok, _ = pcall(vim.cmd, 'colorscheme ' .. _G_colorscheme)
if not ok then
  return
end
