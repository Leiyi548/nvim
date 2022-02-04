--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--━━━━━━━━━━━━━━━━━━━━━━━❰ builtin configs ❱━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
builtin = {}
builtin.emmet = { active = false } -- enable to use emmet plugins
builtin.tabnine = { active = false } -- enable to use emmet plugins
builtin.smartNumber = { active = true } -- enable to open smartNumber, insert mode close relative number,normal mode open relative number

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
