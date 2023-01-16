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
-- require('leap').set_default_keymaps()

vim.keymap.set("n", "s", "<Plug>(leap-forward)")
vim.keymap.set("n", "S", "<Plug>(leap-backward)")
vim.keymap.set("x", "s", "<Plug>(leap-forward)")
vim.keymap.set("o", "z", "<Plug>(leap-forward)")
vim.keymap.set("o", "Z", "<Plug>(leap-backward)")
vim.keymap.set("o", "x", "<Plug>(leap-forward-x)")
vim.keymap.set("o", "X", "<Plug>(leap-backward-x)")
vim.keymap.set("n", "gs", "<Plug>(leap-cross-window)")
vim.keymap.set("x", "gs", "<Plug>(leap-cross-window)")
vim.keymap.set("o", "gs", "<Plug>(leap-cross-window)")
