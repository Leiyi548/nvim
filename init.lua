-- Available Colorscheme
-- | 'github_light' | 'github_dark' | 'onedarker' | 'catppuccin' | 'zephyr' | 'rose-pine' | 'kanagawa' | 'gruvbox-baby' | 'gruvbox-material' | 'catppuccin' | 'gruvbox' | 'material' | 'juliana'
_G_colorscheme = 'github_light'
require('core')
-- Custom textobject
vim.cmd([[source ~/.config/nvim/static/textobjects.vim]])

-- vim.cmd([[set background=dark]])
-- auto change colorscheme base on time.
-- local time = os.date('*t')
-- local min = time.min
-- local hour = time.hour
-- local limit_hour = 19
-- local limit_min = 0
-- if hour >= limit_hour then
--   if hour == limit_hour  and min < limit_min then
--     _G_colorscheme = 'github_light'
--   elseif hour == limit_hour and min >= limit_min then
--     _G_colorscheme = 'onedarker'
--   end
-- else
--     _G_colorscheme = 'onedarker'
-- end

local ok, _ = pcall(vim.cmd, 'colorscheme ' .. _G_colorscheme)
if not ok then
  return
end
