local has_notify, notify = pcall(require, 'notify')

local function notify_level(level)
  return function(msg)
    vim.schedule(function()
      if has_notify then
        notify(msg, level, { title = "Utils" })
      else
        vim.notify('[Utils]' .. msg, level)
      end
    end)
  end
end

local M = {}

M.notify.warn = notify_level(vim.log.levels.WARN)
M.notify.error = notify_level(vim.log.levels.ERROR)
M.notify.info = notify_level(vim.log.levels.INFO)
M.notify.debug = notify_level(vim.log.levels.DEBUG)

return M
