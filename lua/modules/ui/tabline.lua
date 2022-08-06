local bufferline_ok, bufferline = pcall(require, 'bufferline')
if not bufferline_ok then
  return
end

bufferline.setup({
  options = {
    mode = "buffers",
    numbers = 'ordinal', -- | "ordinal" | "buffer_id" | "both" | function({ ordinal, id, lower, raise }): string,
    close_command = 'bdelete! %d', -- can be a string | function, see "Mouse actions"
    right_mouse_command = "bdelete! %d", -- can be a string | function, see "Mouse actions"
    left_mouse_command = "buffer %d",    -- can be a string | function, see "Mouse actions"
    middle_mouse_command = 'nil', -- can be a string | function, see "Mouse actions"
    indicator_icon = '▎',
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
    max_name_length = 30,
    max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
    tab_size = 10,
    diagnostics = 'nvim_lsp', -- | "nvim_lsp" | "coc",
    diagnostics_update_in_insert = false,
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
    separator_style = 'thin', -- | "thick" | "thin" | { 'any', 'any' },
    enforce_regular_tabs = true,
    always_show_bufferline = false,
    -- custom_areas = {},
  },
})
