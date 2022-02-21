local templates_daily = "/Users/macos/Nutstore Files/我的坚果云/学习使用OBSIDIAN/templates/diary_template.md"
local daily_path = "/Users/macos/Nutstore Files/我的坚果云/学习使用OBSIDIAN/0.日记/"
-- Judge file is exist?
local function file_exists(path)
    local file = io.open(path, "rb")
    if file then
        file:close()
    end
    return file ~= nil
end

-- copy file
-- source: be copied file
-- destination: copy file destination
local function copyfile(source, destination)
    print(destination)
    print(source)
    -- open file
    local sourcefile = io.open(source, "r")
    local destinationfile = io.open(destination, "w")
    destinationfile:write(sourcefile:read("*all"))
    -- close file
    sourcefile:close()
    destinationfile:close()
end

-- get today daily filename
local daily_name = function()
    local today = os.date("%W_%Y-%m-%d")
    return daily_path .. today .. ".md"
end

local notify_information = function()
    vim.notify = require("notify")
    vim.notify("The diary has not been created yet. start to create it.", "info", {
  title = "Diary",
  timeout = 5000,
    })
end

local notify_telescope = function()
    vim.notify = require("notify")
    vim.notify("Find diary file", "info", {
  title = "Telescope",
  timeout = 500,
    })
end
if file_exists(daily_name()) then
    -- open file to edit
    vim.api.nvim_command("lua require('user.fancy_telescope').find_diarys()")
    notify_telescope()
    -- vim.api.nvim_command("edit" .. daily_name())
else
    copyfile(templates_daily, daily_name())
    vim.api.nvim_command("edit" .. daily_name())
    notify_information()
end
