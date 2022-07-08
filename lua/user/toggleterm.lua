local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end

toggleterm.setup({
	size = 20,
	open_mapping = [[<M-i>]],
	hide_numbers = true,
	shade_filetypes = {},
	shade_terminals = true,
	shading_factor = 2,
	start_in_insert = true,
	insert_mappings = true,
	persist_size = true,
	direction = "float",
	close_on_exit = true,
	shell = vim.o.shell,
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

function _G.set_terminal_keymaps()
	local opts = { noremap = true }
	vim.api.nvim_buf_set_keymap(0, "t", "<esc>", [[<C-\><C-n>]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<M-h>", "<cmd>ToggleTerm size=10 direction=horizontal<cr>", opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<M-v>", "<cmd>ToggleTerm size=80 direction=vertical<cr>", opts)
	vim.api.nvim_buf_set_keymap(0, "t", "<M-i>", "<cmd>ToggleTerm direction=float<cr>", opts)
end

vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new({
	cmd = "lazygit",
	hidden = true,
	direction = "float",
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(0, "t", "<esc>", "<cmd>close<CR>", { silent = false, noremap = true })
		if vim.fn.mapcheck("<esc>", "t") ~= "" then
			vim.api.nvim_buf_del_keymap(term.bufnr, "t", "<esc>")
		end
	end,
})

function _LAZYGIT_TOGGLE()
	lazygit:toggle()
end

local gotop = Terminal:new({
	cmd = "gotop",
	hidden = true,
	direction = "float",
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(0, "t", "<esc>", "<cmd>close<CR>", { silent = false, noremap = true })
		if vim.fn.mapcheck("<esc>", "t") ~= "" then
			vim.api.nvim_buf_del_keymap(term.bufnr, "t", "<esc>")
		end
	end,
})

function _GOTOP_TOGGLE()
	gotop:toggle()
end

local node = Terminal:new({
	cmd = "node",
	hidden = true,
	direction = "float",
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
	end,
})
function _NODE_TOGGLE()
	node:toggle()
end

local python = Terminal:new({
	cmd = "python3",
	hidden = true,
	direction = "float",
	on_open = function(term)
		vim.cmd("startinsert!")
		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
	end,
})
function _PYTHON_TOGGLE()
	python:toggle()
end

-- local ncdu = Terminal:new({ cmd = "ncdu", hidden = true })
--
-- function _NCDU_TOGGLE()
-- 	ncdu:toggle()
-- end

-- local htop = Terminal:new({ cmd = "htop", hidden = true })
--
-- function _HTOP_TOGGLE()
-- 	htop:toggle()
-- end
