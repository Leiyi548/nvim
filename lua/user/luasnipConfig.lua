--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--─────────────────────────────────────────────────--
--   Plugin:    LuaSnip
--   Github:    github.com/L3MON4D3/LuaSnip
--─────────────────────────────────────────────────--
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--

--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--━━━━━━━━━━━━━━━━━━━❰ configs ❱━━━━━━━━━━━━━━━━━━━--
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--

local ls = require("luasnip")
-- some shorthands...
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

local types = require("luasnip.util.types")

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
})

--functions
local date_input = function(args, state, fmt)
	local fmt = fmt or "%Y-%m-%d"
	return sn(nil, i(1, os.date(fmt)))
end
local date_output = function(format)
	local format = format or "%Y-%m-%d"
	return os.date(format)
end
-- Every unspecified option will be set to the default.
ls.config.set_config({
	history = true,
	-- Update more often, :h events for more info.
	updateevents = "TextChanged,TextChangedI",
})

ls.snippets = {

	all = {
		s("novel", {
			t("It was a dark and stormy night on "),
			d(1, date_input, {}, "%A, %B %d of %Y"),
			t(" and the clocks were striking thirteen."),
		}),
		s("class", {
			-- Choice: Switch between two different Nodes, first parameter is its position, second a list of nodes.
			c(1, {
				t("public "),
				t("private "),
			}),
			t("class "),
			i(2),
			t(" "),
			c(3, {
				t("{"),
				-- sn: Nested Snippet. Instead of a trigger, it has a position, just like insert-nodes. !!! These don't expect a 0-node!!!!
				-- Inside Choices, Nodes don't need a position as the choice node is the one being jumped to.
				sn(nil, {
					t("extends "),
					i(1),
					t(" {"),
				}),
				sn(nil, {
					t("implements "),
					i(1),
					t(" {"),
				}),
			}),
			t({ "", "\t" }),
			i(0),
			t({ "", "}" }),
		}),
	},

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

--[[
-- Beside defining your own snippets you can also load snippets from "vscode-like" packages
-- that expose snippets in json files, for example <https://github.com/rafamadriz/friendly-snippets>.
-- Mind that this will extend  `ls.snippets` so you need to do it after your own snippets or you
-- will need to extend the table yourself instead of setting a new one.
]]

--require("luasnip/loaders/from_vscode").load({ include = { "python" } }) -- Load only python snippets
--require("luasnip/loaders/from_vscode").load({ paths = { "~/.config/nvim/extra/snippets" } }) -- Load snippets from my-snippets folder

-- You can also use lazy loading so you only get in memory snippets of languages you use
require("luasnip/loaders/from_vscode").lazy_load({ paths = { "~/.config/lvim/vscodesnips" } })

--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
--━━━━━━━━━━━━━━━━━❰ end configs ❱━━━━━━━━━━━━━━━━━--
--━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━--
