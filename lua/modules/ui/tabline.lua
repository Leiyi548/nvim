local bufferline_ok, bufferline = pcall(require, 'bufferline')
if not bufferline_ok then
  return
end

bufferline.setup({
  options = {
    mode = 'buffers',
    numbers = 'ordinal', -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    close_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
    right_mouse_command = 'NvimTreeToggle', -- can be a string | function, see "Mouse actions"
    left_mouse_command = 'buffer %d', -- can be a string | function, see "Mouse actions"
    middle_mouse_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
    indicator = {
      icon = '▎', -- this should be omitted if indicator style is not 'icon'
      style = 'none', -- | 'underline' | 'none',
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
        filetype = 'NvimTree',
        text = 'File Explorer',
        text_align = 'center',
        highlight = 'BufferLineOffset',
      },
    },
    ---@diagnostic disable-next-line: unused-local
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      return '(' .. count .. ')'
    end,
    color_icons = true,
    show_buffer_icons = true,
    show_buffer_close_icons = true,
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    separator_style = 'slant', -- slant | padded_slant | thick | thin
    enforce_regular_tabs = true,
    always_show_bufferline = true,
    -- sort will change number,I don't need this.
    -- sort_by = 'insert_after_current', --insert_after_current' |'insert_at_end' | 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
    -- custom_areas = {},
  },
})

-- keymap
local key = require('core.keymap')
local nmap = key.nmap
local silent, noremap = key.silent, key.noremap
local opts = key.new_opts
local cmd = key.cmd
nmap{
  { '<leader>1', cmd('lua require("bufferline").go_to_buffer(1, true)<cr>'), opts(noremap, silent) },
  { '<leader>2', cmd('lua require("bufferline").go_to_buffer(2, true)<cr>'), opts(noremap, silent) },
  { '<leader>3', cmd('lua require("bufferline").go_to_buffer(3, true)<cr>'), opts(noremap, silent) },
  { '<leader>4', cmd('lua require("bufferline").go_to_buffer(4, true)<cr>'), opts(noremap, silent) },
  { '<leader>5', cmd('lua require("bufferline").go_to_buffer(5, true)<cr>'), opts(noremap, silent) },
  { '<leader>6', cmd('lua require("bufferline").go_to_buffer(6, true)<cr>'), opts(noremap, silent) },
  { '<leader>7', cmd('lua require("bufferline").go_to_buffer(7, true)<cr>'), opts(noremap, silent) },
  { '<leader>8', cmd('lua require("bufferline").go_to_buffer(8, true)<cr>'), opts(noremap, silent) },
  { '<leader>9', cmd('lua require("bufferline").go_to_buffer(9, true)<cr>'), opts(noremap, silent) },
  { ';s', cmd('BufferLinePick'), opts(noremap, silent) },
  { '<Tab>', cmd('BufferLineCycleNext'), opts(noremap) },
  { '<S-Tab>', cmd('BufferLineCyclePrev'), opts(noremap) },
}
