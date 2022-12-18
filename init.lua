-- justify system
require('core')
-- My favorite Colorscheme
-- | 'github_light' | 'onedark_vivid'  | 'tokyonight' | 'darkplus' | 'catppuccin' | 'zephyr' | 'rose-pine' | 'kanagawa' | 'gruvbox-baby' | 'gruvbox-material' | 'catppuccin' | 'gruvbox' | 'material' | 'juliana'
local _time = os.date('*t')
if _time.hour >= 16 or _time.hour < 8 then
  _G_colorscheme = 'onedark_vivid'
else
  _G_colorscheme = 'onelight'
end
_G_colorscheme = 'vscode'
local ok, _ = pcall(vim.cmd, 'colorscheme ' .. _G_colorscheme)
if not ok then
  return
end
