local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "single", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 20,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	["/"] = { "<cmd>Telescope live_grep<cr>", "Grep" },
	-- [";"] = { "<cmd>Alpha<cr>", "Dashboard" },
	[";"] = { "<cmd>Startify<cr>", "Startify" },
	["o"] = { "<cmd>AerialToggle<cr>", "Outline" },
	["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	["z"] = { "<cmd>ZenMode<cr>", "ZenMode" },
	["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
	-- Whichkey-p
	p = {
		name = "Packer",
		C = { "<cmd>PackerClean<cr>", "Clean" },
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
	},

	-- Whichkey-F
	F = {
		name = "Custom Find",
		b = { "<cmd>lua require('user.fancy_telescope').builtin()<cr>", "Builtin" },
		f = { "<cmd>lua require('user.fancy_telescope').curbuf()<cr>", "Current Buffer" },
		g = { "<cmd>lua require('user.fancy_telescope').git_files()<cr>", "Git Files" },
		s = { "<cmd>lua require('user.fancy_telescope').git_status()<cr>", "Git Status" },
		z = { "<cmd>lua require('user.fancy_telescope').search_only_certain_files()<cr>", "Certain Filetype" },
	},
	-- Whichkey-f
	f = {
		name = "Find",
		--[[ f = {
			"<cmd>lua require('telescope.builtin').find_files(require('telescope.themes').get_dropdown{previewer = false})<cr>",
      "Files"
		},
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" }, ]]
		b = { "<cmd>lua require('user.fancy_telescope').curbuf()<cr>", "FuzzyFind" },
		e = { "<cmd>Telescope file_browser<cr>", "File_browser" },
		d = { "<cmd>lua require('user.fancy_telescope').findDotfile()<cr>", "Dotfiles" },
		f = { "<cmd>Telescope find_files<cr>", "Files" },
		c = { "<cmd>lua require('user.fancy_telescope').colorscheme()<cr>", "Colorschemes" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
		g = { "<cmd>Telescope live_grep<cr>", "Grep" },
		p = { "<cmd>Telescope projects<cr>", "Project" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		N = { "<cmd>enew<cr>", "New File" },
		r = {
			"<cmd>lua require'telescope.builtin'.oldfiles()<cr>",
			"Recent File",
		},
		j = {
			"<cmd>lua require'telescope.builtin'.jumplist(require('telescope.themes').get_dropdown({}))<cr>",
			"Jumplist",
		},
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		m = {
			"<cmd>lua require'telescope.builtin'.marks(require('telescope.themes').get_dropdown({}))<cr>",
			"Marks",
		},
		n = {
			"<cmd>lua require('user.fancy_telescope').find_notes()<cr>",
			"Notes",
		},
	},

	-- Whichkey-b
	b = {
		name = "Buffer",
		["1"] = { "<Cmd>BufferLineGoToBuffer 1<CR>", "goto 1" },
		["2"] = { "<Cmd>BufferLineGoToBuffer 2<CR>", "goto 2" },
		["3"] = { "<Cmd>BufferLineGoToBuffer 3<CR>", "goto 3" },
		["4"] = { "<Cmd>BufferLineGoToBuffer 4<CR>", "goto 4" },
		["5"] = { "<Cmd>BufferLineGoToBuffer 5<CR>", "goto 5" },
		["6"] = { "<Cmd>BufferLineGoToBuffer 6<CR>", "goto 6" },
		["7"] = { "<Cmd>BufferLineGoToBuffer 7<CR>", "goto 7" },
		["8"] = { "<Cmd>BufferLineGoToBuffer 8<CR>", "goto 8" },
		["9"] = { "<Cmd>BufferLineGoToBuffer 9<CR>", "goto 9" },
		f = { "<cmd>lua require('user.fancy_telescope').findBuffer()<cr>", "Find" },
		c = { "<Cmd>BufferLinePickClose<CR>", "delete buffer" },
		p = { "<Cmd>BufferLinePick<CR>", "pick buffer" },
		o = { "<cmd>Bdelete other<cr>", "Close other buffer" },
		h = { "<cmd>BufferLineCloseLeft<cr>", "Close left buffer" },
		l = { "<cmd>BufferLineCloseRight<cr>", "Close right buffer" },
		v = { "<cmd>lua require('vscode').change_style('light')<cr>", "Light theme" },
	},
	-- Whichkey-r
	r = {
		name = "Run",
		-- a = { "<cmd>RnvimrToggle<cr>", "Ranger" },
		r = { "<cmd>AsyncTask file-run<cr>", "Run on Terminal" },
		n = { "Rename file" },
		f = { "<cmd>AsyncTask file-run-floaterm<cr>", "Run on floaterm" },
	},

	-- Whichkey-g
	g = {
		name = "Git",
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
	},

	-- Whichkey-l
	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = {
			"<cmd>Telescope lsp_document_diagnostics<cr>",
			"Document Diagnostics",
		},
		w = {
			"<cmd>Telescope lsp_workspace_diagnostics<cr>",
			"Workspace Diagnostics",
		},
		f = { "<cmd>lua vim.lsp.buf.formatting()<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		j = {
			"<cmd>lua vim.diagnostic.goto_next()<cr>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.diagnostic.goto_prev()<cr>",
			"Prev Diagnostic",
		},
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
	},

	-- whichkey -d
	d = {
		name = "Debug",
		t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
		b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
		c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
		C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
		d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
		g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
		i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
		o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
		u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
		p = { "<cmd>lua require'dap'.pause.toggle()<cr>", "Pause" },
		r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
		s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
		q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
	},
	-- Whichkey-s
	s = {
		name = "Search",
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		l = { [[<cmd>lua require("persistence").load({last = true})<cr>]], "last session" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		t = { "<cmd>TodoQuickFix<cr>", "Todo" },
		r = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		c = { "<cmd>nohlsearch<CR>", "No Highlight" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
		-- p = { "<cmd>Telescope packer<cr>", "plugins" },
		-- d = { "<cmd>luafile" .. "~/.config/nvim/lua/user/diary.lua" .. "<cr>", "diary" },
	},

	-- Whichkey-t
	t = {
		name = "Terminal",
		n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
		-- u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
		-- t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		g = { "<cmd>lua _GOTOP_TOGGLE()<CR>", "gotop" },
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
		t = { "<cmd>ToggleTerm direction=tab<cr>", "New Tab" },
	},

	-- whichkey-i
	i = {
		name = "Insert",
		i = { "<cmd>PasteImg<cr>", "PasteImg" },
		s = {
			"<cmd>lua require('telescope').extensions.luasnip.luasnip(require('telescope.themes').get_cursor({}))<cr>",
			"Snippet",
		},
		m = { "<cmd>PasteImg<cr>", "Image" },
	},
	-- Whichkey-n
	n = {
		name = "New",
		e = { "New element" },
	},
}

which_key.setup(setup)
which_key.register(mappings, opts)
