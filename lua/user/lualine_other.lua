local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	vim.notify("lualine not found!")
	return
end

local status_gps_ok, gps = pcall(require, "nvim-gps")
if not status_gps_ok then
	vim.notify("nvim-gps not found!")
	return
end

local icons = require("user.icons")

local hide_in_width = function()
	return vim.fn.winwidth(0) > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = icons.diagnostics.Error, warn = icons.diagnostics.Warning },
	colored = false,
	update_in_insert = false,
	always_visible = true,
}

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

local diff = {
	"diff",
	colored = true,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
	cond = hide_in_width,
}

local mode = {
	"mode",
	fmt = function(str)
		return "-- " .. str .. " --"
	end,
}

local filetype = {
	"filetype",
	icons_enabled = true,
	icon = nil,
}

local branch = {
	"branch",
	icons_enabled = true,
	icon = icons.git.SourceControl,
}

local location = {
	"location",
	padding = 0,
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
	-- color = { fg = colors.fg },
	padding = { left = 0, right = 0 },
}

local spaces = function()
	return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local nvim_gps = function()
	local gps_location = gps.get_location()
	if gps_location == "error" then
		return ""
	else
		return gps.get_location()
	end
end

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		component_separators = { left = "", right = "" },
		section_separators = { left = "", right = "" },
		-- component_separators = { left = "", right = "" },
		-- section_separators = { left = "", right = "" },
		disabled_filetypes = { "alpha", "dashboard", "Outline", "startify", "TelescopePrompt" },
		always_divide_middle = true,
		globalstatus = true,
	},
	sections = {
		lualine_a = { branch },
		lualine_b = { diagnostics },
		lualine_c = {
			-- { nvim_gps, cond = hide_in_width },
		},
		-- lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_x = { diff, spaces, "encoding", filetype },
		lualine_y = { location },
		lualine_z = { progress },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		-- lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
