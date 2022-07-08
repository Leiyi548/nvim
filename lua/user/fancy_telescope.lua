local M = {}
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local action_set = require("telescope.actions.set")
local sorters = require("telescope.sorters")
local pickers = require("telescope.pickers")
local themes = require("telescope.themes")
local builtin = require("telescope.builtin")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

local file_ignore_patterns = {
	"vendor/*",
	"font/",
	".git/",
	"node_modules",
	"%.jpg",
	"%.jpeg",
	"%.png",
	"%.svg",
	"%.otf",
	"%.ttf",
}

local function enter(prompt_bufnr)
	local selected = action_state.get_selected_entry()
	local cmd = "colorscheme " .. selected[1]
	vim.cmd(cmd)
	local lvimColor = "vim.cmd([[colorscheme " .. " " .. selected[1] .. "]])"
	local config_dir = vim.fn.expand("/home/chris/.config/nvim/lua/user/nvimColorScheme.lua")
	local job_cmd = "sed -i '$d' " .. config_dir .. " && echo '" .. lvimColor .. "'>>" .. config_dir
	vim.fn.jobstart(job_cmd)
	vim.api.nvim_command("luafile ~/.config/nvim/lua/user/highlight.lua")
	actions.close(prompt_bufnr)
end

local function next_color(prompt_bufnr)
	actions.move_selection_next(prompt_bufnr)
	local selection = action_state.get_selected_entry()
	local cmd = "colorscheme " .. selection[1]
	vim.cmd(cmd)
end

local function prev_color(prompt_bufnr)
	actions.move_selection_previous(prompt_bufnr)
	local selection = action_state.get_selected_entry()
	local cmd = "colorscheme " .. selection[1]
	vim.cmd(cmd)
end

local function preview(prompt_bufnr)
	local selection = action_state.get_selected_entry()
	local cmd = "colorscheme " .. selection[1]
	vim.cmd(cmd)
end

-- custom telescope cmd to change colorscheme
function M.colorscheme()
	local before_color = vim.api.nvim_exec("colorscheme", true)
	local need_restore = true

	local colors = { before_color }
	if not vim.tbl_contains(colors, before_color) then
		table.insert(colors, 1, before_color)
	end

	colors = vim.list_extend(
		colors,
		vim.tbl_filter(function(color)
			return color ~= before_color
		end, vim.fn.getcompletion("", "color"))
	)
	local opts = {
		prompt_title = " Select a Theme",
		results_title = "Change colorscheme",
		path_display = { "smart" },
		-- finder = finders.new_table(colorthemes),
		finder = finders.new_table({
			results = colors,
		}),
		prompt_position = "top",
		previewer = false,
		winblend = 0,
		layout_config = {
			width = 0.5,
			height = 0.5,
			prompt_position = "top", -- top bottom
		},
		attach_mappings = function(prompt_bufnr, map)
			map("i", "<cr>", enter)
			map("i", "<S-Tab>", prev_color)
			map("i", "<Tab>", next_color)
			map("n", "p", preview)
			map("n", "<cr>", enter)
			return true
		end,
		-- sorter = sorters.get_generic_fuzzy_sorter({}),
		sorter = conf.generic_sorter({}),
	}
	-- themes.get_ivy() themes.get_cursor
	local colorschemes = pickers.new(themes.get_dropdown(), opts)
	colorschemes:find()
end

function M.findDotfile()
	local opts = {
		prompt_title = "Find custom Dotfile",
		hidden = true,
		prompt_prefix = " > ",
		path_display = { "shorten" },
		prompt_position = "top",
		sorting_strategy = "ascending",
		search_dirs = { "~/.config/nvim" },
		previewer = false,
		layout_config = {
			width = 0.5,
			height = 0.8,
			horizontal = { width = { padding = 0.15 } },
			vertical = { preview_height = 0.75 },
		},
		file_ignore_patterns = file_ignore_patterns,
	}
	builtin.find_files(themes.get_dropdown(opts))
end

function M.lsp_definitions()
	local opts = {
		sorting_strategy = "ascending",
		ignore_filename = false,
		initial_mode = "normal",
		loyout_config = {
			width = 0.3,
			height = 0.5,
			prompt_position = "top",
			mirrot = true,
		},
	}
	builtin.lsp_definitions(themes.get_cursor(opts))
end

function M.lsp_references()
	local opts = {
		sorting_strategy = "ascending",
		ignore_filename = false,
		initial_mode = "normal",
		loyout_config = {
			width = 0.3,
			height = 0.5,
			prompt_position = "top",
			mirrot = true,
		},
	}
	builtin.lsp_references(themes.get_cursor(opts))
end

-- show implementations of the current thingy using language server
function M.lsp_implementations()
	local opts = {
		layout_strategy = "vertical",
		layout_config = {
			prompt_position = "top",
		},
		sorting_strategy = "ascending",
		ignore_filename = false,
	}
	builtin.lsp_implementations(opts)
end

function M.grep_last_search(opts)
	opts = opts or {}

	-- \<getreg\>\C
	-- -> Subs out the search things
	local register = vim.fn.getreg("/"):gsub("\\<", ""):gsub("\\>", ""):gsub("\\C", "")

	opts.path_display = { "shorten" }
	opts.word_match = "-w"
	opts.search = register

	builtin.grep_string(opts)
end

function M.git_status()
	local opts = themes.get_dropdown({
		winblend = 10,
		border = true,
		previewer = false,
		shorten_path = false,
	})

	-- Can change the git icons using this.
	opts.git_icons = {
		added = "A",
		changed = "M",
		copied = ">",
		deleted = "D",
		renamed = "➡",
		unmerged = "",
		untracked = "?",
	}

	builtin.git_status(opts)
end

function M.builtin()
	builtin.builtin()
end

function M.git_files()
	local path = vim.fn.expand("%:h")
	if path == "" then
		path = nil
	end

	local width = 0.35
	if path and string.find(path, "sourcegraph.*sourcegraph", 1, false) then
		width = 0.6
	end

	local opts = themes.get_dropdown({
		winblend = 5,
		previewer = false,
		prompt_prefix = " > ",
		shorten_path = false,
		cwd = path,
		layout_config = {
			width = width,
		},
		file_ignore_patterns = file_ignore_patterns,
	})

	opts.file_ignore_patterns = {
		"^[.]vale/",
	}
	builtin.git_files(opts)
end

function M.grep_string_visual()
	local visual_selection = function()
		local save_previous = vim.fn.getreg("a")
		vim.api.nvim_command('silent! normal! "ay')
		local selection = vim.fn.trim(vim.fn.getreg("a"))
		vim.fn.setreg("a", save_previous)
		return vim.fn.substitute(selection, [[\n]], [[\\n]], "g")
	end
	require("telescope.builtin").live_grep({
		default_text = visual_selection(),
	})
end

function M.find_notes()
	local opts = {
		prompt_title = "Find Notes",
		prompt_prefix = " ",
		selection_caret = " ", -- selection_caret = " ",
		path_display = { "tail" },
		prompt_position = "top",
		search_dirs = { "~/Dropbox/Orgzly/" },
		sorting_strategy = "ascending",
		layout_config = {
			width = 0.5,
			height = 0.8,
			horizontal = { width = { padding = 0.15 } },
			vertical = { preview_height = 0.75 },
		},
		file_ignore_patterns = file_ignore_patterns,
	}
	builtin.find_files(themes.get_ivy(opts))
end

local function now()
	local today = os.date("%W_%Y-%m-%d")
	return today
end

local function Sleep(n)
	local t0 = os.clock()
	while os.clock() - t0 <= n do
	end
end

local function notify_enter(prompt_bufnr)
	local selected = action_state.get_selected_entry()
	-- /Users/macos/Nutstore Files/我的坚果云/学习使用OBSIDIAN/0.日记/08_2022-02-23.md
	local pattern = "%d+_%d+%-%d+%-%d+"
	local pattern_result = selected[1]:match(pattern)
	local msg = pattern_result .. "号的日记"
	local path = selected[1]:gsub("/Users/macos", "~")
	vim.notify = require("notify")
	vim.notify("打开" .. msg, "info", {
		title = "Diary",
		timeout = 10000,
	})
	return action_set.select(prompt_bufnr, "default")
end

function M.find_diarys()
	local opts = {
		prompt_title = "Find diarys",
		prompt_prefix = " > ",
		default_text = now(),
		selection_caret = " ",
		sorting_strategy = "ascending",
		path_display = { "tail" },
		prompt_position = "top",
		previewer = false,
		search_dirs = { "~/Nutstore Files/我的坚果云/学习使用OBSIDIAN/0.日记" },
		layout_config = {
			width = 0.5,
			height = 0.8,
			horizontal = { width = { padding = 0.15 } },
			vertical = { preview_height = 0.75 },
		},
		file_ignore_patterns = file_ignore_patterns,
		attach_mappings = function(prompt_bufnr, map)
			map("i", "<cr>", notify_enter)
			map("n", "<cr>", notify_enter)
			return true
		end,
	}
	builtin.find_files(themes.get_dropdown(opts))
end

function M.startify()
	local opts = {
		prompt_title = "vscode style find file",
		path_display = { "smart" },
		previewer = false,
		layout_config = {
			width = 0.5,
			height = 0.8,
			horizontal = { width = { padding = 0.15 } },
			vertical = { preview_height = 0.75 },
		},
		file_ignore_patterns = file_ignore_patterns,
	}
	builtin.find_files(themes.get_dropdown(opts))
end

function M.findBuffer()
	local opts = {
		prompt_title = " Find Buffer",
		path_display = { "tail" },
		prompt_position = "top",
		previewer = false,
		layout_config = {
			width = 0.5,
			height = 0.5,
			horizontal = { width = { padding = 0.15 } },
			vertical = { preview_height = 0.75 },
		},
	}
	builtin.buffers(themes.get_dropdown(opts))
end

return M
