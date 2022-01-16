local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = false,
	color = {},
	update_in_insert = false,
	always_visible = true,
}

local fakeMode = {
	function()
		return " "
	end,
	padding = { left = 0, right = 0 },
	color = {},
	cond = nil,
}

local colors = {
	bg = "#202328",
	fg = "#bbc2cf",
	yellow = "#ECBE7B",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	purple = "#c678dd",
	blue = "#51afef",
	red = "#ec5f67",
	git = { change = "#0c7d9d", add = "#587c0c", delete = "#94151b", conflict = "#bb7a61" },
}

local diff = {
	"diff",
	colored = true,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	-- cond = hide_in_width,
	cond = nil,
	always_visible = true,
	diff_color = {
		added = { fg = colors.green },
		modified = { fg = colors.yellow },
		removed = { fg = colors.red },
	},
	padding = { left = 0, right = 0 },
}

local mode = {
	"mode",
	fmt = function(str)
		return "-- " .. str .. " --"
	end,
	color = {},
}

local filetype = {
	"filetype",
	icons_enabled = false,
	padding = 0,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
}

local location = {
	"location",
	padding = 0,
	color = { fg = colors.yellow },
}

local encoding = {
	"encoding",
	padding = { left = 0, right = 1 },
}

local treesitter = {
	function()
		local b = vim.api.nvim_get_current_buf()
		if next(vim.treesitter.highlighter.active[b]) then
			return "  "
		end
		return ""
	end,
	color = { fg = colors.green },
	cond = hide_in_width,
}

-- cool function for progress
local progress = {
	function()
		local current_line = vim.fn.line(".")
		local total_lines = vim.fn.line("$")
		local chars = { "__", "▁▁", "▂▂", "▃▃", "▄▄", "▅▅", "▆▆", "▇▇", "██" }
		local line_ratio = current_line / total_lines
		local index = math.ceil(line_ratio * #chars)
		return chars[index]
	end,
	-- color = { fg = colors.yellow, bg = colors.bg },
	color = { fg = colors.yellow },
	padding = { left = 0, right = 0 },
}

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { branch },
		lualine_b = {},
		lualine_c = { diagnostics, mode },
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = { treesitter, diff, spaces, encoding, filetype },
		lualine_y = { location },
		lualine_z = { progress },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
