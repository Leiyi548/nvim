local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
	return
end

local actions = require("telescope.actions")
-- local fb_action = require("telescope").extensions.file_browser.actions

telescope.setup({
	defaults = {
		path_display = { "truncate" }, -- hidden tail absolute smart shorten truncate
		dynamic_preview_title = true, -- 动态更改预览窗口的名称 例如:预览窗口可以显示完整的文件名
		prompt_prefix = " ", --     
		selection_caret = " ", -- selection_caret = " ",
		selection_strategy = "reset", -- Determines how the cursor acts after each sort iteration.
		sorting_strategy = "ascending", -- 按照升序排序
		entry_prefix = " ",
		initial_mode = "insert",
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		winblend = 0, -- Transparency
		-- border = {},
		-- borderchars = { " ", " ", " ", " ", " ", " ", " ", " " },
		color_devicons = true,
		use_less = true,
		set_env = nil, -- default = nil
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
		preview = {
			-- filesize_limit:The maximum file size in MB attempted to be previewed.
			-- Set to false to attempt to preview any file size.
			-- Default: 25
			filesize_limit = 5,
			-- timeout:Timeout the previewer if the preview did not
			-- complete within `timeout` milliseconds.
			-- Set to false to not timeout preview.
			-- Default: 250
			timeout = 300,
			treesitter = true,
		},
		history = {
			-- path:The path to the telescope history as string. default: stdpath("data")/telescope_history
			-- path = defaults (~/.local/share/nvim/telescope_history)
			-- limit:   The amount of entries that will be written in the history.
			limit = 100,
		},
		layout_strategy = "horizontal",
		layout_config = {
			-- preview_cutoff: When columns are less than this value, the preview will be disabled
			-- preview_width: Change the width of Telescope's preview window
			horizontal = {
				prompt_position = "top",
				preview_width = 0.55,
				results_width = 0.8,
			},
			vertical = {
				mirror = false,
			},
			width = 0.87,
			height = 0.80,
			preview_cutoff = 120,
		},
		mappings = {
			i = {
				["<C-j>"] = actions.cycle_history_next,
				["<C-k>"] = actions.cycle_history_prev,

				["<C-n>"] = actions.move_selection_next,
				["<C-p>"] = actions.move_selection_previous,

				-- ["<C-c>"] = actions.close,

				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,

				["<C-Down>"] = actions.cycle_history_next,
				["<C-Up>"] = actions.cycle_history_prev,

				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,

				-- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				-- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<Tab>"] = actions.move_selection_next,
				["<S-Tab"] = actions.move_selection_previous,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-l>"] = actions.complete_tag,
				["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
			},

			n = {
				["<esc>"] = actions.close,
				["q"] = actions.close,
				["<CR>"] = actions.select_default,
				["o"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,

				-- ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				-- ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<Tab>"] = actions.move_selection_next,
				["<S-Tab"] = actions.move_selection_previous,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["H"] = actions.move_to_top,
				["M"] = actions.move_to_middle,
				["L"] = actions.move_to_bottom,

				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,
				["gg"] = actions.move_to_top,
				["G"] = actions.move_to_bottom,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,

				["?"] = actions.which_key,
			},
		},
		file_ignore_patterns = {
			"vendor/*",
			"%.lock",
			"__pycache__/*",
			"%.sqlite3",
			"%.ipynb",
			"node_modules/*",
			"%.jpg",
			"%.jpeg",
			"%.png",
			"%.svg",
			"%.otf",
			"%.ttf",
			".git/",
			"%.webp",
			".dart_tool/",
			".github/",
			".gradle/",
			".idea/",
			".settings/",
			".vscode/",
			"__pycache__/",
			"build/",
			"env/",
			"gradle/",
			"node_modules/",
			"target/",
			"%.pdb",
			"%.dll",
			"%.class",
			"%.exe",
			"%.cache",
			"%.ico",
			"%.pdf",
			"%.dylib",
			"%.jar",
			"%.docx",
			"%.met",
			"smalljre_*/*",
			".vale/",
			"font/",
		},
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		--[[ file_browser = {
			-- theme = "dropdown", -- ivy,dropdown,cursor
			initial_mode = "normal",
			path_display = { "absolute" }, -- hidden tail absolute smart shorten truncate
			hide_parent_dir = true,
			mappings = {
				["i"] = {
					-- your custom insert mode mappings
					["<C-e>"] = actions.close,
					["<C-c>"] = fb_action.create,
				},
				["n"] = {
					-- your custom normal mode mappings
					-- toggle file_browser.nvim
					["<C-e>"] = actions.close,
					["a"] = fb_action.create,
					["r"] = fb_action.rename,
					["l"] = actions.select_default,
					["h"] = fb_action.goto_parent_dir,
					["p"] = fb_action.goto_parent_dir,
					["<BS>"] = fb_action.toggle_hidden,
					-- remove defaults keybindings
					["<esc>"] = false,
					["c"] = false,
					["e"] = false,
				},
			},
		},
		packer = {
			-- theme = "dropdown", -- ivy,dropdown,cursor
		}, ]]
		["ui-select"] = {
			require("telescope.themes").get_dropdown({
				-- even more opts
			}),
		},

		projects = {
			mappings = {
				["n"] = {},
			},
		},
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})
-- require("telescope").load_extension("file_browser")
-- require("telescope").load_extension("packer")
require("telescope").load_extension("fzf")
require("telescope").load_extension("vim_bookmarks")
require("telescope").load_extension("ui-select")
