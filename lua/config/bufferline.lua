local bufferline_ok, bufferline = pcall(require, 'bufferline')
if not bufferline_ok then
  return
end

bufferline.setup({
  options = {
    mode = 'buffers', -- tabs | buffers
    numbers = 'ordinal', -- none | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    close_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
    right_mouse_command = function()
      -- vim.cmd('Lazy load neo-tree.nvim')
      -- vim.cmd('NeoTreeFloatToggle')
      vim.cmd('lua print(require("utils").show_buffers())')
    end, -- can be a string | function, see "Mouse actions"
    left_mouse_command = 'buffer %d', -- can be a string | function, see "Mouse actions"
    middle_mouse_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
    indicator = {
      icon = '▎', -- this should be omitted if indicator style is not 'icon'
      style = 'icon', -- | 'underline' | 'none',
    },
    buffer_close_icon = '',
    modified_icon = '●',
    close_icon = '',
    left_trunc_marker = '',
    right_trunc_marker = '',
    name_formatter = function(buf) -- buf contains a "name", "path" and "bufnr"
      -- remove extension from markdown files for example
      if buf.name:match('%.md') then
        return vim.fn.fnamemodify(buf.name, ':t:r')
      end
    end,
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics = 'nvim_lsp', -- | "nvim_lsp" | "coc" | "none" ,
    diagnostics_update_in_insert = false,
    custom_filter = function(buf_number, buf_numbers)
      -- filter out filetypes you don't want to see
      if vim.bo[buf_number].filetype ~= '<i-dont-want-to-see-this>' then
        return true
      end
      -- filter out by buffer name
      if vim.fn.bufname(buf_number) ~= '<buffer-name-I-dont-want>' then
        return true
      end
      -- filter out based on arbitrary rules
      -- e.g. filter out vim wiki buffer from tabline in your work repo
      if vim.fn.getcwd() == '<work-repo>' and vim.bo[buf_number].filetype ~= 'wiki' then
        return true
      end
      -- filter out by it's index number in list (don't show first buffer)
      if buf_numbers[1] ~= buf_number then
        return true
      end
    end,
    offsets = {
      {
        filetype = 'neo-tree',
        text = 'File Explorer',
        text_align = 'center',
        highlight = 'BufferLineOffset',
      },
    },
    ---@diagnostic disable-next-line: unused-local
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = ' '
      for e, n in pairs(diagnostics_dict) do
        local sym = e == 'error' and ' ' or (e == 'warning' and ' ' or ' ')
        s = s .. n .. sym
      end
      return s
    end,
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = true,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- more information please see bufferline-styling
    separator_style = 'thin', -- slant | padded_slant | thick | thin (default)
    enforce_regular_tabs = false,
    always_show_bufferline = true,
    -- sort will change number,I don't need this.
    -- sort_by = 'insert_after_current', --insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
    -- custom_areas = {},
  },
})

local keymap = vim.keymap.set
vim.api.nvim_create_user_command('BufferLineCloseOthers', function()
  vim.cmd('BufferLineCloseLeft')
  vim.cmd('BufferLineCloseRight')
end, {})

keymap('n', '<leader>bp', '<cmd>BufferLineCyclePrev<cr>')
keymap('n', '<leader>bn', '<cmd>BufferLineCycleNext<cr>')
keymap('n', '<leader>bo', '<cmd>BufferLineCloseOthers<cr>')
keymap('n', '<leader>bl', '<cmd>BufferLineCloseLeft<cr>')
keymap('n', '<leader>br', '<cmd>BufferLineCloseRight<cr>')
keymap('n', '[b', '<cmd>BufferLineCyclePrev<cr>')
keymap('n', ']b', '<cmd>BufferLineCycleNext<cr>')
keymap('n', '<leader>1', '<cmd>lua require("bufferline").go_to_buffer(1, true)<cr>')
keymap('n', '<leader>2', '<cmd>lua require("bufferline").go_to_buffer(2, true)<cr>')
keymap('n', '<leader>3', '<cmd>lua require("bufferline").go_to_buffer(3, true)<cr>')
keymap('n', '<leader>4', '<cmd>lua require("bufferline").go_to_buffer(4, true)<cr>')
keymap('n', '<leader>5', '<cmd>lua require("bufferline").go_to_buffer(5, true)<cr>')
keymap('n', '<leader>6', '<cmd>lua require("bufferline").go_to_buffer(6, true)<cr>')
keymap('n', '<leader>7', '<cmd>lua require("bufferline").go_to_buffer(7, true)<cr>')
keymap('n', '<leader>8', '<cmd>lua require("bufferline").go_to_buffer(8, true)<cr>')
keymap('n', '<leader>9', '<cmd>lua require("bufferline").go_to_buffer(9, true)<cr>')
