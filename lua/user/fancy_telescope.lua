local M = {}
local action_state = require("telescope.actions.state")
local actions = require("telescope.actions")
local sorters = require("telescope.sorters")
local pickers = require("telescope.pickers")
local themes = require("telescope.themes")
local builtin = require("telescope.builtin")
local finders = require("telescope.finders")
local conf = require("telescope.config").values

function M._multiopen(prompt_bufnr, open_cmd)
  local picker = action_state.get_current_picker(prompt_bufnr)
  ---@diagnostic disable-next-line: undefined-field
  local num_selections = table.getn(picker:get_multi_selection())
  local border_contents = picker.prompt_border.contents[1]
  if not (string.find(border_contents, "Find Files") or string.find(border_contents, "Git Files")) then
    actions.select_default(prompt_bufnr)
    return
  end
  if num_selections > 1 then
    vim.cmd "bw!"
    for _, entry in ipairs(picker:get_multi_selection()) do
      vim.cmd(string.format("%s %s", open_cmd, entry.value))
    end
    vim.cmd "stopinsert"
  else
    if open_cmd == "vsplit" then
      actions.file_vsplit(prompt_bufnr)
    elseif open_cmd == "split" then
      actions.file_split(prompt_bufnr)
    elseif open_cmd == "tabe" then
      actions.file_tab(prompt_bufnr)
    else
      actions.file_edit(prompt_bufnr)
    end
  end
end
function M.multi_selection_open_vsplit(prompt_bufnr)
  M._multiopen(prompt_bufnr, "vsplit")
end
function M.multi_selection_open_split(prompt_bufnr)
  M._multiopen(prompt_bufnr, "split")
end
function M.multi_selection_open_tab(prompt_bufnr)
  M._multiopen(prompt_bufnr, "tabe")
end
function M.multi_selection_open(prompt_bufnr)
  M._multiopen(prompt_bufnr, "edit")
end
-- beautiful default layout for telescope prompt
function M.layout_config()
	return {
		width = 0.90,
		height = 0.85,
		preview_cutoff = 120,
		prompt_position = "bottom",
		horizontal = {
			preview_width = function(_, cols, _)
				if cols > 200 then
					return math.floor(cols * 0.5)
				else
					return math.floor(cols * 0.6)
				end
			end,
		},
		vertical = {
			width = 0.9,
			height = 0.95,
			preview_height = 0.5,
		},

		flex = {
			horizontal = {
				preview_width = 0.9,
			},
		},
	}
end

local function enter(prompt_bufnr)
	local selected = action_state.get_selected_entry()
	local cmd = "colorscheme " .. selected[1]
	vim.cmd(cmd)
	local lvimColor = "vim.cmd([[colorscheme " .. " " .. selected[1] .. "]])"
	local config_dir = vim.fn.expand("~/.config/nvim/lua/user/nvimColorScheme.lua")
	local job_cmd = "sed -i '' '$d' " .. config_dir .. " && echo '" .. lvimColor .. "'>>" .. config_dir
	vim.fn.jobstart(job_cmd)
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

-- custom colorscheme
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
		prompt_title = " Find colorscheme",
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

function M.findBuffer()
	local opts = {
		prompt_title = " Find Buffer",
		path_display = { "smart" },
		prompt_position = "top",
		cwd = "~/.config/nvim",
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

function M.findDotfile()
	local opts = {
		prompt_title = " Find Dotfile",
		path_display = { "smart" },
		prompt_position = "top",
		cwd = "~/.config/nvim",
		previewer = false,
		layout_config = {
			width = 0.5,
			height = 0.8,
			horizontal = { width = { padding = 0.15 } },
			vertical = { preview_height = 0.75 },
		},
	}
	-- layout_strategy = "horizontal",
	-- layout_config = { preview_width = 0.65, width = 0.75 },
	builtin.find_files(themes.get_dropdown(opts))
end
-- another file string search
function M.find_string()
	local opts = {
		border = true,
		previewer = false,
		shorten_path = false,
		layout_strategy = "flex",
		layout_config = {
			width = 0.9,
			height = 0.8,
			horizontal = { width = { padding = 0.15 } },
			vertical = { preview_height = 0.75 },
		},
		file_ignore_patterns = {
			"vendor/*",
			"node_modules",
			"%.jpg",
			"%.jpeg",
			"%.png",
			"%.svg",
			"%.otf",
			"%.ttf",
		},
	}
	builtin.live_grep(opts)
end

-- show code actions in a fancy floating window
function M.code_actions()
	local opts = {
		winblend = 15,
		layout_config = {
			prompt_position = "top",
			width = 80,
			height = 12,
		},
		borderchars = {
			prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
			results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
			preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		},
		border = {},
		previewer = false,
		shorten_path = false,
	}
	builtin.lsp_code_actions(themes.get_dropdown(opts))
end

function M.codelens_actions()
	local opts = {
		winblend = 15,
		layout_config = {
			prompt_position = "top",
			width = 80,
			height = 12,
		},
		borderchars = {
			prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
			results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
			preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		},
		border = {},
		previewer = false,
		shorten_path = false,
	}
	builtin.lsp_codelens_actions(themes.get_dropdown(opts))
end

-- show refrences to this using language server
function M.lsp_references()
	local opts = {
		layout_strategy = "vertical",
		layout_config = {
			prompt_position = "top",
		},
		sorting_strategy = "ascending",
		ignore_filename = false,
	}
	builtin.lsp_references(opts)
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

-- find files in the upper directory
function M.find_updir()
	local up_dir = vim.fn.getcwd():gsub("(.*)/.*$", "%1")
	local opts = {
		cwd = up_dir,
	}

	builtin.find_files(opts)
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

function M.project_search()
	builtin.find_files({
		previewer = false,
		layout_strategy = "vertical",
		cwd = require("lsp.config/utils").root_pattern(".git")(vim.fn.expand("%:p")),
	})
end

function M.curbuf()
	local opts = themes.get_dropdown({
		winblend = 10,
		border = true,
		previewer = false,
		shorten_path = false,
	})
	builtin.current_buffer_fuzzy_find(opts)
end

function M.git_status()
	local opts = themes.get_dropdown({
		winblend = 10,
		border = true,
		previewer = false,
		shorten_path = false,
	})

	-- Can change the git icons using this.
	-- opts.git_icons = {
	--   changed = "M"
	-- }

	builtin.git_status(opts)
end

function M.search_only_certain_files()
	builtin.find_files({
		find_command = {
			"rg",
			"--files",
			"--type",
			vim.fn.input("Type: "),
		},
	})
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
		shorten_path = false,
		cwd = path,
		layout_config = {
			width = width,
		},
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

return M
