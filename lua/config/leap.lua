local leap = require('leap')
local labels = {
  's',
  'f',
  'j',
  'd',
  'k',
  'l',
  'a',
  ';',
  'n',
  'v',
  'c',
  'm',
  'x',
  'q',
  'w',
  'u',
  'i',
  'o',
  'e',
  'r',
  'h',
  'g',
}

leap.setup({
  case_sensitive = false,
  labels = labels,
  -- disable auto-jumping to the first match
  safe_labels = {},
})
-- leap default keymap
-- require('leap').set_default_keymaps()

vim.keymap.set('n', 's', '<cmd>lua require("leap").leap { target_windows = { vim.fn.win_getid() } }<cr>')
vim.keymap.set('n', 'S', function()
  require('leap').leap({
    target_windows = vim.tbl_filter(function(win)
      return vim.api.nvim_win_get_config(win).focusable
    end, vim.api.nvim_tabpage_list_wins(0)),
  })
end)
vim.keymap.set('o', 'z', '<cmd>lua require("leap").leap { target_windows = { vim.fn.win_getid() } }<cr>')
vim.keymap.set('o', 'x', '<cmd>lua require("leap").leap { target_windows = { vim.fn.win_getid() } }<cr>')
vim.keymap.set('n', 'gs', '<Plug>(leap-cross-window)')
