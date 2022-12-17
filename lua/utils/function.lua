local M = {}

-- more reference: https://github.com/ChristianChiarulli/nvim/blob/master/lua/user/bfs/init.lua
-- 获得buffer的数量，如果只有一个返回空，多个返回buffer个数
function M.get_bufs_num()
  local bufs = {}
  local cwd_path = vim.fn.getcwd() .. '/'
  for _, id in ipairs(vim.api.nvim_list_bufs()) do
    local buf_info = vim.fn.getbufinfo(id)[1]
    if buf_info.listed == 1 then
      -- print(vim.inspect(buf_info.bufnr))
      -- print(vim.inspect(buf_info))
      -- TODO: this is unecessary
      table.insert(bufs, {
        id = id,
        name = string.gsub(buf_info.name, cwd_path, ''),
        changed = buf_info.changed,
        hidden = buf_info.hidden,
        lnum = buf_info.lnum,
        lastused = buf_info.lastused,
        bufnr = buf_info.bufnr,
      })
    end
  end

  if #bufs == 1 then
    return ''
  else
    return ' (' .. #bufs .. ')'
  end
end

function M.smart_quit()
  local bufnr = vim.api.nvim_get_current_buf()
  local modified = vim.api.nvim_buf_get_option(bufnr, 'modified')
  if modified then
    vim.ui.input({
      prompt = 'You have unsaved changes. Quit anyway? (y/n) ',
    }, function(input)
      if input == 'y' then
        vim.cmd('qa!')
      end
    end)
  else
    vim.cmd('qa!')
  end
end

function M.isempty(s)
  return s == nil or s == ''
end

function M.get_buf_option(opt)
  local status_ok, buf_option = pcall(vim.api.nvim_buf_get_option, 0, opt)
  if not status_ok then
    return nil
  else
    return buf_option
  end
end

function M.toggle_line_numbers()
  if vim.wo.relativenumber then
    vim.wo.relativenumber = false
  else
    vim.wo.relativenumber = true
  end
end

function M.toggle_onedarkpro_theme()
  if vim.o.background == 'dark' then
    vim.cmd([[colorscheme onelight]])
  else
    vim.cmd([[colorscheme onedark_vivid]])
  end
end

function M.change_filetype()
  vim.ui.input({ prompt = 'change filetype to:' }, function(new_ft)
    if new_ft ~= nil then
      vim.bo.filetype = new_ft
    end
  end)
end

return M
