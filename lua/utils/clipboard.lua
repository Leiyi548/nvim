local notify = require('utils.notify')
local filename= require("utils.filename")


local M = {}

M.use_system_clipboard = false

local function add_to_clipboard(content)
  if M.use_system_clipboard then
    vim.fn.setreg('+', content)
    vim.fn.setreg('"', content)
    return notify.info(string.format('Copied %s to system clipboard!', content))
  else
    vim.fn.setreg('"', content)
    vim.fn.setreg('1', content)
    return notify.info(string.format('Copied %s to vim clipboard!', content))
  end
end

function M.copy_filename()
  add_to_clipboard(filename.get_filename())
end

function M.copy_relative_path()
  add_to_clipboard(filename.get_relative_path())
end

function M.copy_absolute_path()
  add_to_clipboard(filename.get_absolute_path())
end

function M.copy_absolute_path_with_tilde()
  add_to_clipboard(filename.get_absolute_path_with_tilde())
end

return M
