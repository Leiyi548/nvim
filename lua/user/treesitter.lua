local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

-- use ssh to download parser
require("nvim-treesitter.install").prefer_git = true
local parsers = require("nvim-treesitter.parsers").get_parser_configs()
for _, p in pairs(parsers) do
	p.install_info.url = p.install_info.url:gsub("https://github.com/", "git@github.com:")
end

-- add othre parser
local parser_configs = require("nvim-treesitter.parsers").get_parser_configs()
if builtin.neorg.active then
	-- These two are optional and provide syntax highlighting
	-- for Neorg tables and the @document.meta tag
	parser_configs.norg_meta = {
		install_info = {
			url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
			files = { "src/parser.c" },
			branch = "main",
		},
	}
	parser_configs.norg_table = {
		install_info = {
			url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
			files = { "src/parser.c" },
			branch = "main",
		},
	}
end

if builtin.orgmode.active then
	parser_configs.org = {
		install_info = {
			url = "https://github.com/milisims/tree-sitter-org",
			revision = "f110024d539e676f25b72b7c80b0fd43c34264ef",
			files = { "src/parser.c", "src/scanner.cc" },
		},
		filetype = "org",
	}
end

-- treesitter config
configs.setup({
	-- ensure_installed = { "lua", "python", "html", "javascript", "cpp", "org", "norg", "norg_meta", "norg_table" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	ensure_installed = { "lua", "python", "html", "javascript", "cpp", "org" }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
	sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
	ignore_install = { "" }, -- List of parsers to ignore installing
	matchup = {
		enable = false, -- mandatory, false will disable the whole extension
		-- disable = { "c", "ruby" },  -- optional, list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "" }, -- list of language that will be disabled
		additional_vim_regex_highlighting = true,
	},
	indent = { enable = true, disable = { "yaml", "python" } },
	context_commentstring = {
		enable = true,
		config = {
			-- Languages that have a single comment style
			typescript = "// %s",
			css = "/* %s */",
			scss = "/* %s */",
			html = "<!-- %s -->",
			svelte = "<!-- %s -->",
			vue = "<!-- %s -->",
			json = "",
		},
	},
	rainbow = {
		enable = true,
		extended_mode = true, -- Highlight also non-parentheses delimiters, boolean or table: lang -> boolean
		max_file_lines = 1000, -- Do not enable for files with more than 1000 lines, int
	},
	textobjects = {
		lookahead = true,
		select = {
			enable = true,
			keymaps = {
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["aC"] = "@conditional.outer",
				["iC"] = "@conditional.inner",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["]w"] = "@parameter.inner",
			},
			swap_previous = {
				["[w"] = "@parameter.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
			},
		},
		lsp_interop = {
			enable = true,
			border = "rounded",
			peek_definition_code = {
				["df"] = "@function.outer",
				["dF"] = "@class.outer",
			},
		},
	},
})
