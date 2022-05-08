local icons = require("user.icons")

require("structrue-go").setup({
	show_others_method = true, -- bool show methods of struct whose not in current file
	show_filename = false, -- bool
	number = "no", -- show number: no | nu | rnu
	-- fold_open_icon = icons.ui.TriangleDown,
	-- fold_close_icon = icons.ui.TriangleRight,
	-- fold_open_icon = " ",
	-- fold_close_icon = " ",
	fold_open_icon = " ",
	fold_close_icon = " ",
	cursor_symbol_hl = "guibg=#393f48 ", -- symbol hl under cursor,
	indent = "┠", -- Hierarchical indent icon, nil or empty will be a tab
	position = "botright", -- window position,default botright,also can set float
	symbol = { -- symbol style
		filename = {
			hl = "guifg=White", -- highlight symbol,value can set by help highlight-gui
			icon = icons.documents.File, -- symbol icon
		},
		package = {
			hl = "guifg=#6addff",
			icon = icons.ui.Package,
		},
		import = {
			hl = "guifg=#ff9849",
			icon = icons.kind.Module,
		},
		const = {
			hl = "guifg=#75BEFF",
			icon = icons.kind.Constant,
		},
		variable = {
			hl = "guifg=#75BEFF",
			icon = icons.kind.Variable,
		},
		func = {
			hl = "guifg=#B180D7",
			icon = icons.kind.Function,
		},
		interface = {
			hl = "guifg=#0195f7",
			icon = icons.kind.Interface,
		},
		type = {
			hl = "guifg=#D4D4D4",
			icon = icons.kind.TypeParameter,
		},
		struct = {
			hl = "guifg=#E8AB53",
			icon = icons.kind.Struct,
		},
		field = {
			hl = "guifg=#75BEFF",
			icon = icons.kind.Field,
		},
		method_current = {
			hl = "guifg=#DCDCAA",
			icon = icons.kind.Method,
		},
		method_others = {
			hl = "guifg=#DCDCAA",
			icon = icons.kind.Method,
		},
	},
	keymap = {
		toggle = "<C-g>", -- toggle structure-go window
		show_others_method_toggle = "H", -- show or hidden the methods of struct whose not in current file
		symbol_jump = "<CR>", -- jump to then symbol file under cursor
		fold_toggle = "o",
		refresh = "R", -- refresh symbols
		preview_open = "p", -- preview  symbol context open
		preview_close = "q", -- preview  symbol context close
	},
	fold = { -- fold symbols
		import = false,
		const = false,
		variable = false,
		type = false,
		interface = false,
		func = false,
	},
})
