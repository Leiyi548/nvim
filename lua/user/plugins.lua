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
	git = { clone_timeout = 288, default_url_format = "git@github.com:%s" },
	max_jobs = 50,
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
		-- cmd = { "NvimTreeToggle", "NvimTreeOpen" },
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
		disable = not builtin.plugins.cursorWord.active,
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
		-- event = "BufRead",
		config = function()
			require("user.indentline")
		end,
		disable = not builtin.plugins.indent_line.active,
	})
	use({
		"goolord/alpha-nvim",
		event = "BufWinEnter",
		config = function()
			require("user.dashboard").config()
			vim.cmd("language en_US.UTF-8")
		end,
		disable = not builtin.plugins.dashboard.active,
	})
	use({
		"mhinz/vim-startify",
		-- event = "BufWinEnter",
		-- branch = "center",
		config = function()
			vim.cmd([[source ~/.config/nvim/lua/user/startify.vim ]])
		end,
		disable = not builtin.plugins.startify.active,
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
	use("Lunarvim/darkplus.nvim")
	use("marko-cerovac/material.nvim")
	use("luisiacc/gruvbox-baby")
	use({ "Leiyi548/gruvy.nvim", disable = not builtin.colorscheme.tj.active })
	use({ "Leiyi548/darcula-solid.nvim", disable = not builtin.colorscheme.darcula.active })
	use("Leiyi548/vscode.nvim")
	-- use("Mofiqul/vscode.nvim")
	use("projekt0n/github-nvim-theme")
	use({ "Leiyi548/monokai.nvim", disable = not builtin.colorscheme.monokai.active })
	use({ "olimorris/onedarkpro.nvim", disable = not builtin.colorscheme.onedarkpro.active })
	use({ "Mofiqul/dracula.nvim", disable = not builtin.colorscheme.dracula.active })
	use({ "Leiyi548/rose-pine", disable = not builtin.colorscheme.rose_pine.active })
	use({
		"catppuccin/nvim",
		as = "catppuccin",
		disable = not builtin.colorscheme.catppuccin.active,
	})
	use("glepnir/zephyr-nvim")

	-- cmp plugins (completion)
	use({
		"hrsh7th/nvim-cmp",
		event = { "InsertEnter", "CmdLineEnter" },
		config = function()
			require("user.cmp")
		end,
		-- commit = "bba6fb67fdafc0af7c5454058dfbabc2182741f4",
	}) -- The completion plugin
	use({ "hrsh7th/cmp-buffer", after = "nvim-cmp" }) -- buffer completions
	use({ "hrsh7th/cmp-path", after = "nvim-cmp" }) -- path completions
	use({ "hrsh7th/cmp-nvim-lsp-signature-help", after = "nvim-cmp", disable = true }) -- path completions
	use({
		"hrsh7th/cmp-cmdline",
		after = "nvim-cmp",
	}) -- cmdline completions
	use({ "saadparwaiz1/cmp_luasnip", after = "LuaSnip" }) -- snippet completions
	use({ "hrsh7th/cmp-nvim-lsp", after = "cmp_luasnip" })
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
	}) -- enable LSP
	use({ "williamboman/nvim-lsp-installer" }) -- simple to use language server installer
	use({ "tamago324/nlsp-settings.nvim" }) -- language server settings defined in json for
	use({ "b0o/schemastore.nvim" })
	use({ "jose-elias-alvarez/null-ls.nvim" }) -- for formatters and linters
	use({
		"ray-x/lsp_signature.nvim",
		-- event = "BufRead",
		config = function()
			require("user.lsp_signature").config()
		end,
	})
	use({
		"glepnir/lspsaga.nvim",
		branch = "main",
		config = function()
			require("user.lspsaga")
		end,
	})

	-- Telescope
	use({
		"nvim-telescope/telescope.nvim",
		config = function()
			require("user.telescope")
		end,
	})
	-- use({ "nvim-telescope/telescope-ui-select.nvim" })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	use({ "Leiyi548/telescope-packer.nvim", disable = not builtin.plugins.telescope_packer.active })
	use({
		"ahmedkhalf/project.nvim", -- ahmedkhalf/project.nvim
		config = function()
			require("user.project")
		end,
		disable = not builtin.plugins.telescope_project,
	})
	use("tom-anders/telescope-vim-bookmarks.nvim")
	use("MattesGroeger/vim-bookmarks")
	-- Treesitter
	use({
		"nvim-treesitter/nvim-treesitter",
		run = ":TSUpdate",
		config = function()
			require("user.treesitter")
		end,
	})
	use("nvim-treesitter/playground")
	use({ "JoosepAlviste/nvim-ts-context-commentstring", event = "BufReadPost" })
	use({
		"lewis6991/gitsigns.nvim",
		event = "BufRead",
		config = function()
			require("user.gitsigns")
		end,
	})
	use({
		"dstein64/vim-startuptime",
		cmd = "Startuptime",
	})
	use({
		"tpope/vim-surround",
		keys = { "c", "d", "y", "s", "S" },
	})
	use("tpope/vim-repeat")
	use({
		"norcalli/nvim-colorizer.lua",
		-- event = "BufRead",
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
		disable = not builtin.plugins.smartIm.active,
	})

	-- im-select
	use({
		"Leiyi548/vim-im-select",
		-- event = { "InsertEnter" },
		disable = not builtin.plugins.im_select.active,
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

	-- markdown preview in google Chrome
	use({
		"iamcco/markdown-preview.nvim",
		run = "cd app && npm install",
		ft = "markdown",
		config = function()
			vim.g.mkdp_auto_start = 0
			vim.g.mkdp_auto_close = 1
			vim.g.mkdp_refresh_slow = 0
			vim.g.mkdp_command_for_global = 0
			vim.g.mkdp_browser = ""
			vim.g.mkdp_highlight_css = ""
			vim.g.mkdp_page_title = "「${name}」"
			vim.g.mkdp_filetypes = { "markdown" }
			vim.g.mkdp_preview_options = { hide_yaml_meta = 1, disable_filename = 1, theme = "light" }
			-- vim.g.mkdp_markdown_css = "/Users/macos/.config/nvim/UI/markdown_style_github.css"
			vim.g.vmt_auto_update_on_save = 1
		end,
		disable = not builtin.plugins.markdown_preview.active,
	})

	-- paste image from clipboard
	use({
		"ekickx/clipboard-image.nvim",
		cmd = { "PasteImg" },
		ft = { "markdown" },
		config = function()
			require("user.clipboard-image")
		end,
		disable = not builtin.plugins.markdown_preview.active,
	})
	use({
		"folke/todo-comments.nvim",
		event = "BufRead",
		config = function()
			require("user.todo-comments")
		end,
	})
	-- vim.notify
	use({
		"rcarriga/nvim-notify",
		config = function()
			require("user.notify")
			vim.notify = require("notify")
		end,
		event = "BufRead",
		disable = not builtin.plugins.notify.active,
	})

	-- debug by dap
	use({
		"mfussenegger/nvim-dap",
		config = function()
			require("user.dap")
		end,
		disable = not builtin.plugins.dap.active,
	})

	use({
		"Pocco81/DAPInstall.nvim",
		disable = not builtin.plugins.dap.active,
	})
	use({
		"rcarriga/nvim-dap-ui",
		config = function()
			require("dapui").setup()
		end,
		disable = not builtin.plugins.dap.active,
	})

	use({
		"theHamsta/nvim-dap-virtual-text",
		config = function()
			require("user.dapVirtualText")
		end,
		disable = not builtin.plugins.dap_virtual_text.active,
	})

	use({
		"stevearc/aerial.nvim",
		-- cmd = { "AerialToggle!", "AerialToggle" },
		config = function()
			require("user.outline")
		end,
		disable = not builtin.plugins.outline.active,
	})

	use({
		"folke/zen-mode.nvim",
		disable = not builtin.plugins.zenMode.active,
		config = function()
			require("user.zenMode").config()
		end,
	})

	use({
		"folke/twilight.nvim",
		config = function()
			require("user.twilight")
		end,
	})

	use({ "kana/vim-textobj-entire", requires = { "kana/vim-textobj-user" } })

	use("wellle/targets.vim")

	use({
		"SmiteshP/nvim-gps",
		config = function()
			require("user.gps")
		end,
	})

	use({
		"folke/trouble.nvim",
		config = function()
			require("user.trouble")
		end,
	})

	use({
		"mg979/vim-visual-multi",
		branch = "master",
		disable = true,
		config = function()
			vim.cmd([[ 
        let g:VM_maps['Find Under']         = '<M-n>'           " replace C-n
        let g:VM_maps['Find Subword Under'] = '<M-n>'           " replace visual C-n
      ]])
		end,
	})

	use({
		"crusj/structrue-go.nvim",
		branch = "main",
		config = function()
			require("user.structrue-go")
		end,
	})
	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
