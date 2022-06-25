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
builtin.plugins.orgmode = { active = false } -- enable to use orgmode plugins
builtin.plugins.cmp_autopairs = { active = true } -- enable to open cmp_autopairs.on_confirm_done
builtin.plugins.telescope_project = { active = true } -- enable to use project.nvim plugin
builtin.plugins.telescope_packer = { active = false }
builtin.plugins.telescope_frceny = { active = false } -- enable to use telescope-france.nvim plugins
builtin.plugins.notify = { active = true } -- enable to use nvim-notify plugins
builtin.plugins.dap = { active = false } -- enable to use dap plugins to debug
builtin.plugins.dap_virtual_text = { active = false } -- enable to use dap plugins to debug add dap_virtual_text
builtin.plugins.copilot = { active = false } -- enable to use copilot plugins to completion
builtin.plugins.cursorWord = { active = false } -- enable to use vim-cursorword plugins to completion
builtin.plugins.outline = { active = true } -- enable to use aerial plugins to display information in outline
builtin.plugins.zenMode = { active = true } -- enable to use zenmode plugins
builtin.plugins.smartIm = { active = true } -- enable to use smartIm plugins
builtin.plugins.dashboard = { active = false } -- enable to use dashboard
builtin.plugins.dashboard.simpleHead = { active = true } -- enable to use sample header
builtin.plugins.startify = { active = not builtin.plugins.dashboard.active } -- enable to use startify plugins
builtin.plugins.markdown_preview = { active = true } -- enable to open markdown_preview.nvim
builtin.plugins.im_select = { active = false } -- enable to open im-select.vim
builtin.plugins.indent_line = { active = true } -- enable to open indent_line
builtin.plugins.paste_image = { active = true }
builtin.plugins.gonvim = { active = false }
builtin.custom.smartNumber = { active = false } -- enable to open smartNumber, insert mode close relative number,normal mode open relative number
builtin.custom.oneNumber = { active = false } -- enable to use one number
builtin.custom.lualine_vscode = { active = false } -- enable to use style like vscode statue line
builtin.colorscheme.rose_pine = { active = true } -- enable to use colorscheme rose-pine
builtin.colorscheme.dracula = { active = false } -- enable to use colorscheme dracula
builtin.colorscheme.onedarkpro = { active = true } -- enable to use colorscheme onedarkpro
builtin.colorscheme.monokai = { active = false } -- enable to use colorscheme monokai
builtin.colorscheme.tj = { active = false } -- enable to use tj colorscheme
builtin.colorscheme.darcula = { active = false } -- enable to use IntelijIdea builtin colorscheme
builtin.colorscheme.catppuccin = { active = false } -- enable to use IntelijIdea builtin colorscheme
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--━━━━━━━━━━━━━━━━━━━━━❰ end  builtin configs ❱━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
-- wsl yanking to windows clipboard from nvim
if vim.fn.has("wsl") == 1 then
	builtin.plugins.smartIm = { active = false }
	builtin.plugins.paste_image = { active = false }
	builtin.plugins.markdown_preview = { active = false }
	builtin.plugins.im_select = { active = false }
	vim.g.clipboard = {
		name = "win32yank-wsl",
		copy = {
			["+"] = "win32yank.exe -i --crlf",
			["*"] = "win32yank.exe -i --crlf",
		},
		paste = {
			["+"] = "win32yank.exe -o --lf",
			["*"] = "win32yank.exe -o --lf",
		},
		cache_enable = 0,
	}
end

require("user.options")
require("user.keymaps")
require("user.plugins")
require("impatient")
require("user.theme")
require("user.impatient")
require("user.autocommands")
require("user.lsp")
if builtin.custom.lualine_vscode.active then
	require("user.lualine")
else
	require("user.lualine_other")
end
-- Textobjects
-- =========================================
vim.cmd([[source ~/.config/nvim/textobjects.vim]])
vim.o.background = "dark" -- to load onedark
