local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local sorters = require("telescope.sorters")

local colorthemes = vim.fn.getcompletion("", "color")

local function enter(prompt_bufnr)
	local selected = action_state.get_selected_entry()
	local cmd = "colorscheme " .. selected[1]
	vim.cmd(cmd)
	local lvimColor = "vim.cmd([[colorscheme " .." " ..selected[1] .."]])"
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

local colors = function(opts)
	pickers.new(opts, {
		prompt_title = "Colorscheme",
		results_title = "Change colorscheme",
		finder = finders.new_table(colorthemes),
		--layout_strategy = "vertical",
		layout_strategy = "horizontal",
		winblend = 20,
		-- layout_strategy = "center",
		--layout_strategy = "cursor",
		layout_config = {
			height = 0.5,
			width = 0.5,
			-- preview_cutoff = 1,
			-- preview_height = 0.7,
			prompt_position = "top", -- top bottom
		},
		attach_mappings = function(prompt_bufnr, map)
			map("i", "<cr>", enter)
      map("i","<Tab>",next_color)
      map("i","<S-Tab>",prev_color)
      map("i","<C-n>",next_color)
      map("i","<C-p>",prev_color)
			return true
		end,
		sorter = sorters.get_generic_fuzzy_sorter({}),
	}):find()
end
colors()
