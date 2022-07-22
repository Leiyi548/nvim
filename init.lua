require('core')
-- textobject
vim.cmd([[source ~/.config/nvim/static/textobjects.vim]])

vim.cmd([[set background=dark]])
-- auto change colorscheme base on time.
_G_colorscheme = '' -- github_light github_dark onedarker catppuccin
local time = os.date('*t')
local min = time.min
local hour = time.hour
if hour <= 18 then
  if hour == 18  and min < 30 then
    _G_colorscheme = 'github_light'
  elseif hour == 18 and min > 30 then
    _G_colorscheme = 'onedarker'
  end
else
    _G_colorscheme = 'onedarker'
end

local ok, _ = pcall(vim.cmd, 'colorscheme ' .. _G_colorscheme)
if not ok then
  return
end
