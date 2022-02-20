--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--━━━━━━━━━━━━━━━━━━━━━━━❰ builtin configs ❱━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
builtin = {}
builtin.emmet = { active = false } -- enable to use emmet-vim plugins
builtin.tabnine = { active = false } -- enable to use emmet plugins
builtin.smartNumber = { active = false } -- enable to open smartNumber, insert mode close relative number,normal mode open relative number
builtin.persistence = { active = true } -- enable to open persistence for session management
builtin.neorg = { active = false } -- enable to open neorg to noteTaking
builtin.orgmode = { active = true } -- enable to use orgmode plugins
builtin.cmp_autopairs = { active = true } -- enable to open cmp_autopairs.on_confirm_done
builtin.telescope_project = { active = true } -- enable to use project.nvim plugin
builtin.templates = { active = true } -- enable to use vim-template plugins to set file header
builtin.telescope_frceny = { active = false } -- enable to use telescope-france.nvim plugins
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--━━━━━━━━━━━━━━━━━━━━━❰ end  builtin configs ❱━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--

require("user.options")
require("user.keymaps")
require("user.plugins")
require("user.colorscheme")
require("user.lualine")
require("user.impatient")
require("user.autocommands")

-- Textobjects
-- =========================================
vim.cmd([[source ~/.config/nvim/textobjects.vim]])
