vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
vim.g.copilot_filetypes = {
	["*"] = false,
	python = true,
	lua = true,
	go = true,
	rust = true,
	html = true,
	c = true,
	cpp = true,
	java = true,
	javascript = true,
	typescript = true,
	javascriptreact = true,
	typescriptreact = true,
	terraform = true,
}
vim.api.nvim_set_keymap("i", "<C-h>", [[copilot#Accept("\<CR>")]], { expr = true, script = true })
