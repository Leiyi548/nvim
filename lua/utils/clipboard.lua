local notify = require('utils.notify')
local content = 'This is copied content'

local M = {}

local function addToCilpboard(content)
  vim.fn.setreg('+', content)
  vim.fn.setreg('"', content)
  notify.info(string.format('Copied %s to system clipboard!', content))
end

function M.copyFileName()
  addToCilpboard(content)
end

return M
