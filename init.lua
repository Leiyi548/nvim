-- My favorite Colorscheme
-- | 'github_light' | 'onedarker' | 'catppuccin' | 'zephyr' | 'rose-pine' | 'kanagawa' | 'gruvbox-baby' | 'gruvbox-material' | 'catppuccin' | 'gruvbox' | 'material' | 'juliana'
_G_colorscheme = 'zephyr'
require('core')
local ok, _ = pcall(vim.cmd, 'colorscheme ' .. _G_colorscheme)
if not ok then
  return
end
