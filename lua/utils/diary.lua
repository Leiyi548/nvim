local M = {}

local username = 'ewell'
local diary_base_path = '/home/' .. username .. '/NOTE/Now/00-每日日记/DailyNote/'
local diary_time_template = '%W_%Y-%m-%d'
local diary_template = '/home/' .. username .. '/NOTE/Now/90-模板/00-日记/日记模块.md'

local function file_exists(filename)
  local file = io.open(filename, 'rb')
  if file then
    file:close()
  end
  return file ~= nil
end

-- get diary path
-- base on diary_time_template
local function get_diary_name(diary_time_template)
  local today = os.date(diary_time_template)
  return diary_base_path .. today .. '.md'
end

-- generate_diary_template
-- source: be copied file
-- destination: copy file destination
local function generate_diary_template(source, destination)
  -- open file
  local sourcefile = io.open(source, 'r')
  local destinationfile = io.open(destination, 'w')
  -- check nil
  if destinationfile == nil or sourcefile == nil then
    vim.notify('destination_file or source_file not exist')
    return
  end
  destinationfile:write(sourcefile:read('*all'))
  -- close file
  sourcefile:close()
  destinationfile:close()
end

-- open diary
function M.open_diary()
  local filename = get_diary_name(diary_time_template)
  local open_cmd = 'edit' .. filename
  if file_exists(filename) then
    vim.cmd(open_cmd)
  else
    generate_diary_template(diary_template, filename)
    vim.cmd(open_cmd)
  end
end

return M
