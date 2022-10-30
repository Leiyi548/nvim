require('core')
-- My favorite Colorscheme
-- | 'github_light' | 'onedarkpro'  | 'tokyonight' | 'darkplus' | 'catppuccin' | 'zephyr' | 'rose-pine' | 'kanagawa' | 'gruvbox-baby' | 'gruvbox-material' | 'catppuccin' | 'gruvbox' | 'material' | 'juliana'
local _time = os.date('*t')
if _time.hour > 18 or _time.hour < 6 then
  _G_colorscheme = 'tokyonight-night'
else
  _G_colorscheme = 'tokyonight-day'
end
local ok, _ = pcall(vim.cmd, 'colorscheme ' .. _G_colorscheme)
if not ok then
  return
end
