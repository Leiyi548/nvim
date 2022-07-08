local saga = require("lspsaga")

-- use custom config
saga.init_lsp_saga({
	-- "single" | "double" | "rounded" | "bold" | "plus"
	border_style = "single",
	-- when cursor in saga window you config these to move
	move_in_saga = { prev = "k", next = "j" },
	-- Error, Warn, Info, Hint

	-- use emoji like

	-- { "🙀", "😿", "😾", "😺" }
	-- or
	-- { "😡", "😥", "😤", "😐" }

	-- and diagnostic_header can be a function type
	-- must return a string and when diagnostic_header
	-- is function type it will have a param `entry`

	-- entry is a table type has these filed
	-- { bufnr, code, col, end_col, end_lnum, lnum, message, severity, source }
	diagnostic_header = { " ", " ", " ", "ﴞ " },
	-- show diagnostic source
	show_diagnostic_source = true,
	-- add bracket or something with diagnostic source, just have 2 elements
	diagnostic_source_bracket = {},
	-- use emoji lightbulb in default
	code_action_icon = "💡",
	-- if true can press number to execute the codeaction in codeaction window
	code_action_num_shortcut = true,
	-- same as nvim-lightbulb but async
	code_action_lightbulb = {
		enable = true,
		sign = true,
		sign_priority = 20,

		virtual_text = true,
	},
	-- separator in finder
	finder_separator = "  ",
	-- preview lines of lsp_finder and definition preview
	max_preview_lines = 10,
	finder_action_keys = {
		open = "o",
		vsplit = "s",
		split = "i",
		tabe = "t",
		quit = "q",
		scroll_down = "<C-d>",
		scroll_up = "<C-u>", -- quit can be a table
	},
	code_action_keys = {
		quit = "q",
		exec = "<CR>",
	},
	rename_action_quit = "<C-c>",
	definition_preview_icon = "  ",
	-- if you don't use nvim-lspconfig you must pass your server name and

	-- the related filetypes into this table
	-- like server_filetype_map = { metals = { "sbt", "scala" } }
	server_filetype_map = {},
})

-- set keymap here
vim.keymap.set("n", "gr", require("lspsaga.finder").lsp_finder, { silent = true, noremap = true })
vim.keymap.set("n", "ga", "<cmd>Lspsaga code_action<CR>", { silent = true, noremap = true })
vim.keymap.set("n", "<leader>lr", "<cmd>Lspsaga rename<CR>", { silent = true, noremap = true })
