local M = {}

local username = 'ewell'
local diary_base_path = '/home/' .. username .. '/OB/Now/00-每日日记/DailyNote/'
local diary_weekly_base_path = '/home/' .. username .. '/OB/Now/00-每日日记/WeeklyNote/'
local diary_time_template = '%W_%Y-%m-%d'
local diary_weekly_time_template = '%W_%Y'
local diary_template = '/home/' .. username .. '/OB/Now/90-模板/00-日记/日记模块.md'
local diary_weekly_template = '/home/' .. username .. '/OB/Now/90-模板/00-日记/周日记模块.md'

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

local function get_diary_weekly_name(diary_weekly_time_template)
  local today = os.date(diary_weekly_time_template)
  return diary_weekly_base_path .. today .. '.md'
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
    vim.notify('destination_file or source_file not exist', vim.log.levels.WARN, { title = 'diary' })
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
    vim.cmd('tabnew')
    vim.cmd(open_cmd)
  else
    generate_diary_template(diary_template, filename)
    vim.cmd('tabnew')
    vim.cmd(open_cmd)
    vim.notify('生成新模板'..filename, vim.log.levels.INFO, { title = 'diary' })
  end
end

function M.open_weekly_diary()
  local filename = get_diary_weekly_name(diary_weekly_time_template)
  local open_cmd = 'edit' .. filename
  if file_exists(filename) then
    vim.cmd('tabnew')
    vim.cmd(open_cmd)
  else
    generate_diary_template(diary_weekly_template, filename)
    vim.cmd('tabnew')
    vim.cmd(open_cmd)
    vim.notify('生成新模板'..filename, vim.log.levels.INFO, { title = 'diary' })
  end
end
return M
