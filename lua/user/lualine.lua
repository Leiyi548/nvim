local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local colors = {
	bg = "#007acc",
	fg = "#d4d4d4",
	yellow = "#ECBE7B",
	cyan = "#008080",
	darkblue = "#081633",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	purple = "#c678dd",
	blue = "#027acc",
	red = "#ec5f67",
	git = { change = "#0c7d9d", add = "#587c0c", delete = "#94151b", conflict = "#bb7a61" },
}

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	-- cond = hide_in_width,
	colored = false,
	color = { bg = colors.blue },
	update_in_insert = false,
	always_visible = true,
}

local fakeMode = {
	function()
		return " "
	end,
	padding = { left = 0, right = 0 },
	color = { bg = colors.blue },
	cond = nil,
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
	color = { bg = colors.blue },
	padding = { left = 0, right = 0 },
}

local mode = {
	"mode",
	fmt = function(str)
		return "-- " .. str .. " --"
	end,
	color = { bg = colors.blue },
}

local filetype = {
	"filetype",
	icons_enabled = false,
	padding = { left = 0, right = 1 },
	color = { bg = colors.blue },
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = "",
	color = { bg = colors.blue },
}

local encoding = {
	"encoding",
	fmt = string.upper,
	padding = { left = 0, right = 1 },
	color = { bg = colors.blue },
	cond = hide_in_width,
}

local treesitter = {
	function()
		local b = vim.api.nvim_get_current_buf()
		if next(vim.treesitter.highlighter.active[b]) then
			return "  "
		end
		return ""
	end,
	color = { fg = colors.green, bg = colors.blue },
	cond = hide_in_width,
}

local location = {
	"location",
	padding = 0,
	-- color = { fg = colors.yellow, bg = colors.blue },
	color = { fg = colors.fg, bg = colors.blue },
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
	-- color = { fg = colors.yellow, bg = colors.blue },
	color = { fg = colors.fg, bg = colors.blue },
	padding = { left = 0, right = 0 },
}

local spaces = {
	function()
		return "Space: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
	end,
	color = { fg = colors.fg, bg = colors.blue },
}

local filename = {
	"filename",
	path = 2,
	color = { bg = colors.blue },
	always_visible = true,
}

-- mid sections
local mid = {
	color = { bg = colors.blue },
}
lualine.setup({
	options = {
		icons_enabled = true,
		theme = {
			normal = { c = { fg = colors.fg, bg = colors.bg } },
			inactive = { c = { fg = colors.fg, bg = colors.bg } },
		},
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline", "packer" },
		always_divide_middle = true,
		globalstatusa = true,
	},
	sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {
			branch,
			diagnostics,
			--[[mode,]]
			mid,
		},
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = { filename, treesitter, diff, spaces, encoding, filetype, location, progress },
		lualine_y = {},
		lualine_z = {},
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
