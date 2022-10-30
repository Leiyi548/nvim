local fn = vim.fn
local M = {}


--- 获得当前的文件的相对路径
function M.get_relative_path()
  return fn.expand('%:~:.')
end

--- 获得当前的文件的绝对路径
function M.get_absolute_path()
  return fn.expand('%:~:.')
end

--- 获得当前的文件的绝对路径
-- 家目录用~代替
function M.get_absolute_path_with_tilde()
  return fn.expand('%:p:~')
end

--- 获得当前的文件的文件名
function M.get_filename(  )
  return fn.expand('%:t')
end

return M
