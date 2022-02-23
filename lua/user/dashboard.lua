local M = {}

M.config = function()
	local present, alpha = pcall(require, "alpha")
	if not present then
		return
	end
	local header = {
		type = "text",
		val = require("user.banners").dashboard(),
		opts = {
			position = "center",
			hl = "Comment",
		},
	}
	local num_plugins_loaded = #vim.fn.globpath("/Users/macos/.local/share/nvim/site/pack/packer/start", "*", 0, 1)

	-- local thingy = io.popen('echo "$(date +%a) $(date +%b) $(date +%d)" | tr -d "\n"')
	local thingy = io.popen('echo "$(date +%b月)$(date +%d日~)$(date +星期%a)" | tr -d "\n"')
	local date = thingy:read("*a")
	thingy:close()
	--local date = os.date("%a")

	--  plugins = plugins:gsub("^%s*(.-)%s*$", "%1")

	local plugin_count = {
		type = "text",
		val = "Neovim loading..." .. num_plugins_loaded .. " plugins  ",
		opts = {
			position = "center",
			hl = "String",
		},
	}

	local heading = {
		type = "text",
		-- val = "  Today is " .. date .. "",
		val = " 2022年" .. date,
		opts = {
			position = "center",
			hl = "Whichkey",
		},
	}

	-- local fortune = require("alpha.fortune")
	local fortune = require("user.fortune")
	local footer = {
		type = "text",
		val = fortune(),
		opts = {
			position = "center",
			-- hl = "Comment",
			hl = "String",
		},
	}

	local function button(sc, txt, keybind)
		local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

		local opts = {
			position = "center",
			text = txt,
			shortcut = sc,
			cursor = 5,
			width = 24,
			align_shortcut = "right",
			hl_shortcut = "Number",
			hl = "Type",
		}
		if keybind then
			opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
		end

		return {
			type = "button",
			val = txt,
			on_press = function()
				local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
				vim.api.nvim_feedkeys(key, "normal", false)
			end,
			opts = opts,
		}
	end

	local buttons = {
		type = "group",
		val = {
			button("w", "   Find word", "<cmd>Telescope live_grep<cr>"),
			button("f", "   Find File ", ":Telescope find_files<cr>"),
			button("p", "   Find project ", ":Telescope projects<cr>"),
			button("r", "   Recent Files", ":Telescope oldfiles<cr>"),
			button("s", "   Last session", [[<cmd>lua require("persistence").load({last = true})<cr>]]),
			button("o", "   Configure", ":e ~/.config/nvim/init.lua<cr>"),
			-- button("q", "   Quit", ":q<cr>"),
		},
		opts = {
			spacing = 1,
		},
	}

	local section = {
		header = header,
		buttons = buttons,
		plugin_count = plugin_count,
		heading = heading,
		footer = footer,
	}

	local opts = {
		layout = {
			{ type = "padding", val = 3 },
			section.header,
			{ type = "padding", val = 2 },
			section.heading,
			section.footer,
			{ type = "padding", val = 1 },
			section.buttons,
			section.plugin_count,
		},
		opts = {
			margin = 5,
		},
	}
	alpha.setup(opts)
end

return M
