require('core')
local colorscheme = 'github_light' -- github_light onedarker
local ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not ok then
  return
end
