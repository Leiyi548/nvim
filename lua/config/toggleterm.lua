local ok, toggleterm = pcall(require, 'toggleterm')
if not ok then
  return
end

toggleterm.setup({
  size = 20,
  open_mapping = [[<C-\>]],
  hide_numbers = true,
  shade_filetypes = {},
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = 'float',
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = 'curved',
    winblend = 0,
    highlights = {
      border = 'Normal',
      background = 'Normal',
    },
  },
})

function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<A-v>', '<cmd>ToggleTerm size=10 direction=vertical<cr>', opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<A-h>', '<cmd>ToggleTerm size=80 direction=horizontal<cr>', opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<A-i>', '<cmd>ToggleTerm direction=float<cr>', opts)
end

vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')
