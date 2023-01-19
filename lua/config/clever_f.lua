vim.api.nvim_set_hl(0, 'CleverChar', { underline = false, bold = true, fg = '#282c34', bg = '#89ca78' })
vim.g.clever_f_mark_char_color = 'CleverChar'
vim.g.clever_f_mark_direct_color = 'CleverChar'
vim.g.clever_f_ = false
vim.g.clever_f_mark_direct = false
vim.g.clever_f_timeout_ms = 1500
vim.g.clever_f_chars_match_any_signs = ';'
vim.g.clever_f_across_no_line = true
vim.g.clever_f_across_no_line = true
vim.g.clever_f_ignore_case = false
vim.g.clever_f_smart_case = true

local keymap = vim.keymap.set
keymap({ 'n', 'v' }, ';', '<Plug>(clever-f-repeat-forward)')
keymap({ 'n', 'v' }, ',', '<Plug>(clever-f-repeat-back)')
