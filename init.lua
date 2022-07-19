require('core')
local colorscheme = 'github_dark' -- github_light onedarker github_dark
local ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not ok then
  return
end
