--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--━━━━━━━━━━━━━━━━━━━━━━━❰ builtin configs ❱━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
builtin = {}
builtin.lsp = {}
builtin.custom = {}
builtin.colorscheme = {}
builtin.plugins = {}
builtin.plugins.emmet = { active = false } -- enable to use emmet-vim plugins
builtin.plugins.tabnine = { active = false } -- enable to use emmet plugins
builtin.plugins.persistence = { active = false } -- enable to open persistence for session management
builtin.plugins.neorg = { active = false } -- enable to open neorg to noteTaking
builtin.plugins.orgmode = { active = false } -- enable to use orgmode plugins
builtin.plugins.cmp_autopairs = { active = true } -- enable to open cmp_autopairs.on_confirm_done
builtin.plugins.telescope_project = { active = true } -- enable to use project.nvim plugin
builtin.plugins.templates = { active = false } -- enable to use vim-template plugins to set file header
builtin.plugins.telescope_frceny = { active = false } -- enable to use telescope-france.nvim plugins
builtin.plugins.notify = { active = true } -- enable to use nvim-notify plugins
builtin.plugins.dap = { active = false } -- enable to use dap plugins to debug
builtin.plugins.dap_virtual_text = { active = false } -- enable to use dap plugins to debug add dap_virtual_text
builtin.plugins.copilot = { active = false } -- enable to use copilot plugins to completion
builtin.plugins.cursorWord = { active = false } -- enable to use vim-cursorword plugins to completion
builtin.plugins.outline = { active = true } -- enable to use aerial plugins to display information in outline
builtin.plugins.zenMode = { active = true } -- enable to use zenmode plugins
builtin.plugins.smartIm = { active = false } -- enable to use smartIm plugins
builtin.plugins.dashboard = { active = true } -- enable to use dashboard
builtin.plugins.dashboard.simpleHead = { active = false } -- enable to use sample header
builtin.lsp.print_diagnostics_message = { active = false } -- enable to use lsp_print_diagnostic_message
builtin.lsp.automatical_show_line_diagnostics = { active = false }
builtin.custom.smartNumber = { active = false } -- enable to open smartNumber, insert mode close relative number,normal mode open relative number
builtin.custom.oneNumber = { active = false } -- enable to use one number
builtin.colorscheme.rose_pine = { active = false } -- enable to use colorscheme rose-pine
builtin.colorscheme.dracula = { active = false } -- enable to use colorscheme dracula
builtin.colorscheme.onedarkpro = { active = true } -- enable to use colorscheme onedarkpro
builtin.colorscheme.tj = { active = flase } -- enable to use tj colorscheme
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
-- wsl yanking to windows clipboard from nvim
if vim.fn.has("wsl") == 1 then
	builtin.plugins.smartIm = { active = false }
	vim.g.clipboard = {
		name = "win32yank-wsl",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --crlf",
			["*"] = "win32yank.exe -o --crlf",
		},
		cache_enable = 0,
	}
end
