-- My favorite Colorscheme
-- | 'github_light' | 'vscode' | 'tokyonight' | 'onedarker' | 'catppuccin' | 'zephyr' | 'rose-pine' | 'kanagawa' | 'gruvbox-baby' | 'gruvbox-material' | 'catppuccin' | 'gruvbox' | 'material' | 'juliana'
_G_colorscheme = 'onedarkpro'
require('core')
local ok, _ = pcall(vim.cmd, 'colorscheme ' .. _G_colorscheme)
if not ok then
  return
end
