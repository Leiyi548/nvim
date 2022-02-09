--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--─────────────────────────────────────────────────--
--   Plugin:    LuaSnip
--   Github:    github.com/L3MON4D3/LuaSnip
--─────────────────────────────────────────────────--
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--

--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--━━━━━━━━━━━━━━━━━━━❰ configs ❱━━━━━━━━━━━━━━━━━━━--
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--

local luasnip_status_ok, ls = pcall(require, "luasnip")
if not luasnip_status_ok then
	return
end
-- some shorthands...
-- some nodes
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

-- luasnip setup
ls.config.set_config({
	history = true,
	-- Update more often, :h events for more info.
	updateevents = "TextChanged,TextChangedI",
})
-- virtual text to nodes
--[[ local types = require("luasnip.util.types")

require("luasnip").config.setup({
	ext_opts = {
		[types.choiceNode] = {
			active = {
				virt_text = { { "●", "GruvboxOrange" } },
			},
		},
		[types.insertNode] = {
			active = {
				virt_text = { { "●", "GruvboxBlue" } },
			},
		},
	},
}) ]]

-- functions
local author_cpp = [[

]]
-- end of functions

ls.snippets = {
	-- Every unspecified option will be set to the default.
	all = {},

	cpp = {
		s("author", {
			t({ "/*", "" }),
			t({ "author: Leiyi548", "" }),
			t({ "Lences: MIT", "" }),
			t("date: "),
			t(os.date("%Y年-%m月-%d日")),
			t({ "", "*/", " " }),
		}),
	},

	python = {
		s("author", {
			t({ '"""', "" }),
			t({ "author: Leiyi548", "" }),
			t({ "Lences: MIT", "" }),
			t("date: "),
			--d(1,date_input, {}, "%A,%B %d of %Y"),
			t(os.date("%Y年-%m月-%d日")),
			t({ "", '"""', "" }),
		}),
		s("def", {
			t("def "),
			i(1, "myFunc"),
			t("("),
			i(2),
			t(")"),
			t({ " {", "\t" }),
			i(0),
			t({ "", "}" }),
		}),
	},
}

-- load vscode style snippets
require("luasnip/loaders/from_vscode").lazy_load({ paths = { "~/.config/nvim/snippets" } })

--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--━━━━━━━━━━━━━━━━━❰ end configs ❱━━━━━━━━━━━━━━━━━--
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
