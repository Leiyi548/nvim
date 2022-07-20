require('core')
vim.cmd([[set background=dark]])
-- auto change colorscheme base on time.
_G_colorscheme = '' -- github_light github_dark onedarker catppuccin
local time = os.date('*t')
if time.hour < 19 then
  _G_colorscheme = 'github_light'
else
  _G_colorscheme = 'onedarkpro'
end

local ok, _ = pcall(vim.cmd, 'colorscheme ' .. _G_colorscheme)
if not ok then
  return
end
