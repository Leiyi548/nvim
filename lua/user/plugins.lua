local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"git@github.com:wbthomason/packer.nvim.git",
		-- "https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
-- autocmd BufWritePost plugins.lua source <afile> | PackerSync
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile>
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	-- git = { clone_timeout = 288 },
	git = { clone_timeout = 288, default_url_format = "git@github.com:%s" },
	-- git = { clone_timeout = 288, default_url_format = "https://github.91chi.fun//https://github.com/%s" },
	-- git = {clone_timeout = 288, default_url_format = "https://github.cnpmjs.org/%s" },
	-- git = { clone_timeout = 288, default_url_format = "https://hub.fastgit.org/%s" },
	max_jobs = 10,
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" }) -- single rounded
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	-- My plugins here
	use({ "wbthomason/packer.nvim" }) -- Have packer manage itself
	use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
	use("nvim-lua/plenary.nvim") -- Useful lua functions used ny lots of plugins
	-- Autopairs, integrates with both cmp and treesitter
	use({
		"windwp/nvim-autopairs",
		config = function()
			require("user.autopairs")
		end,
		after = "nvim-cmp",
	})
	-- Easily comment stuff
	use({
		"numToStr/Comment.nvim",
		config = function()
			require("user.comment")
		end,
		event = "BufRead",
	})
	use("kyazdani42/nvim-web-devicons")
	use({
		"kyazdani42/nvim-tree.lua",
		cmd = "NvimTreeToggle",
		config = function()
			require("user.nvim-tree")
		end,
	})
	use({
		"akinsho/bufferline.nvim",
		-- event = "BufRead",
		config = function()
			require("user.bufferline")
		end,
	})
	use({ "Asheq/close-buffers.vim" })
	use({ "nvim-lualine/lualine.nvim" })
	use({
		"itchyny/vim-cursorword",
		event = { "BufReadPre", "BufNewFile" },
	})
	use({
		"p00f/nvim-ts-rainbow",
		after = "nvim-treesitter",
	})
	use({
		"nvim-treesitter/nvim-treesitter-textobjects",
		before = "nvim-treesitter",
	})

	-- toggleterm
	use({
		"akinsho/toggleterm.nvim",
		event = "BufWinEnter",
		config = function()
			require("user.toggleterm")
		end,
	})
	-- Improve startup time for Neovim
	use("lewis6991/impatient.nvim")
	use("nathom/filetype.nvim")
	use({
		"lukas-reineke/indent-blankline.nvim",
		event = "BufRead",
		config = function()
			require("user.indentline")
		end,
	})
	use({
		"goolord/alpha-nvim",
		event = "BufWinEnter",
		config = function()
			require("user.dashboard").config()
		end,
	})
	use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
	use({
		"folke/which-key.nvim",
		config = function()
			require("user.whichkey")
		end,
		event = "BufWinEnter",
	})

	-- Colorschemes
	-- use "lunarvim/colorschemes" -- A bunch of colorschemes you can try out
	-- use("lunarvim/darkplus.nvim")
	use("Mofiqul/vscode.nvim")
	use({ "olimorris/onedarkpro.nvim" })
	use("Mofiqul/dracula.nvim")
	use("projekt0n/github-nvim-theme")
	-- use("sainnhe/gruvbox-material")
	use({
		"rose-pine/neovim",
		as = "rose-pine",
	})
	-- use({ "ellisonleao/gruvbox.nvim" })
	-- cmp plugins
	use({
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdLineEnter" },
		config = function()
			require("user.cmp")
		end,
	}) -- The completion plugin
	use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" }) -- buffer completions
	use({ "hrsh7th/cmp-path", after = "nvim-cmp" }) -- path completions
	use({
		"hrsh7th/cmp-cmdline",
		after = "nvim-cmp",
		config = function()
			require("cmp").setup.cmdline(":", { sources = { { name = "cmdline" } } })
		end,
	}) -- cmdline completions
	use({ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp", after = "cmp_luasnip" })
	use({
		"tzachar/cmp-tabnine",
		run = "./install.sh",
		config = function()
			local tabnine = require("cmp_tabnine.config")
			tabnine:setup({
				max_lines = 1000,
				max_num_results = 10,
				sort = true,
			})
		end,
		event = "InsertEnter",
		disable = builtin.tabnine,
	})

	-- snippets
	use({
		"L3MON4D3/LuaSnip",
		after = "nvim-cmp",
		config = function()
			require("user.luasnip")
		end,
	}) --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP
	use({
		"neovim/nvim-lspconfig",
		-- event = "BufReadPre",
		config = function()
			require("user.lsp")
		end,
	}) -- enable LSP
	use({ "williamboman/nvim-lsp-installer" }) -- simple to use language server installer
	use({ "tamago324/nlsp-settings.nvim" }) -- language server settings defined in json for
	use({
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			require("user.lsp.null-ls")
		end,
	}) -- for formatters and linters
	use({
		"ray-x/lsp_signature.nvim",
		event = "BufRead",
		config = function()
			require("user.lsp_signature").config()
		end,
	})

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("user.telescope")
		end,
		cmd = "Telescope",
	})
	use({
		"ahmedkhalf/project.nvim",
		config = function()
			require("user.project")
		end,
		disable = true,
	})
	-- use({ "nvim-telescope/telescope-file-browser.nvim" })
	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("user.treesitter")
		end,
	})
	use({ "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPost" })

	-- Git
	use({
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		config = function()
			require("user.gitsigns")
		end,
	})

	-- Startuptime
	use({
		"dstein64/vim-startuptime",
		cmd = "Startuptime",
	})
	-- vim-surround
	use({
		"tpope/vim-surround",
		keys = { "c", "d", "y", "s", "S" },
	})

	-- Color
	use({
		"norcalli/nvim-colorizer.lua",
		event = "BufRead",
		config = function()
			require("user.colorizer").config()
		end,
	})

	-- Smartim
	use({
		"ybian/smartim",
		event = { "InsertEnter" },
		config = function()
			vim.g.smartim_default = "com.apple.keylayout.ABC"
		end,
	})

	-- emmet
	use({
		"mattn/emmet-vim",
		ft = { "html", "css", "php", "jsp", "markdown" },
		disable = not builtin.emmet.active,
		-- disable = true,
	})

	-- Run code
	use({
		"voldikss/vim-floaterm",
		cmd = { "FloatermNew" },
		config = function()
			vim.cmd([[hi FloatermNC guibg=gray]])
			vim.g.floaterm_width = 0.9
			vim.g.floaterm_wintype = "float"
			vim.g.floaterm_height = 0.9
			vim.g.floaterm_title = ""
			vim.g.floaterm_borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" }
		end,
	})
	use({
		"skywind3000/asyncrun.vim",
		cmd = { "AsyncRun" },
	})
	use({
		"skywind3000/asynctasks.vim",
		cmd = { "AsyncTask" },
		config = function()
			vim.g.asynctasks_term_pos = "bottom"
			vim.g.asynctasks_term_cols = 60
			vim.g.asynctasks_term_rows = 12
			vim.g.asyncrun_open = 6
			vim.g.asynctasks_system = "macos"
			vim.cmd([[
        let g:asynctasks_extra_config = [
    \ '~/.config/nvim/tasks.ini',
    \ ]
        ]])
		end,
	})
	-- Tmux navigation
	use({
		"numToStr/Navigator.nvim",
		event = "BufRead",
		config = function()
			require("Navigator").setup()
		end,
	})
	-- easymotion
	use({
		"phaazon/hop.nvim",
		as = "hop",
		event = "BufRead",
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require("hop").setup({
				keys = "etovxqpdygfblzhckisuran",
			})
		end,
	})
	-- harpoon
	use("ThePrimeagen/harpoon")
	-- persistence (session management)
	use({
		"folke/persistence.nvim",
		event = "BufReadPre", -- this will only start session saving when an actual file was opened
		module = "persistence",
		config = function()
			require("persistence").setup({
				-- dir = ~/.config/nvim/sessions
				-- dir = vim.fn.expand(get_cache_dir() .. "/sessions/"), -- directory where session files are saved
				-- options = { "buffers", "curdir", "tabpages", "winsize" }, -- sessionoptions used for saving
			})
		end,
		disable = not builtin.persistence.active,
	})
	-- markdown preview in google Chrome
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		ft = "markdown",
	})
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
