local colors = {
	bg = "#007acc",
	fg = "#d4d4d4",
	yellow = "#ECBE7B",
	cyan = "#008080",
	dark = "#1e1e1e",
	lightdark = "#252931",
	darkblue = "#081633",
	purpledark = "#1b1f27",
	green = "#98be65",
	orange = "#FF8800",
	violet = "#a9a1e1",
	magenta = "#c678dd",
	purple = "#c678dd",
	blue = "#027acc",
	red = "#ec5f67",
	vscPopupHighlightBlue = "#004b72",
	vscFront = "#D4D4D4",
	git = { change = "#0c7d9d", add = "#587c0c", delete = "#94151b", conflict = "#bb7a61" },
}

local highlight_groups = {
	-- telescope
	-- { "TelescopeSelection", { bg = colors.vscPopupHighlightBlue } },
	-- { "TelescopeNormal", { fg = colors.vscFront, bg = colors.purpledark } },
	{ "TelescopePromptPrefix", { fg = colors.red, bg = nil } },
	-- { "TelescopePromptNormal", { fg = colors.fg, bg = colors.lightdark } },
	-- { "TelescopePromptBorder", { fg = nil, bg = colors.lightdark } },
	{ "TelescopePromptTitle", { fg = colors.lightdark, bg = colors.red } },
	{ "TelescopeResultsTitle", { fg = colors.dark, bg = colors.yellow } },
	-- { "TelescopeResultsBorder", { fg = colors.purpledark, bg = colors.purpledark } },
	{ "TelescopePreviewTitle", { fg = colors.dark, bg = colors.green } },
	-- { "TelescopePreviewBorder", { fg = colors.lightdark, bg = colors.purpledark } },
}
for _, hl in pairs(highlight_groups) do
	vim.api.nvim_set_hl(0, hl[1], hl[2])
end
