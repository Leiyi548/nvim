-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local plugin = require('core.pack').register_plugin
local conf = require('modules.ui.config')

-- colorscheme
plugin({ 'Leiyi548/github-nvim-theme', config = conf.github })
plugin({ 'Leiyi548/zephyr-nvim', disable = true })
plugin({ 'folke/tokyonight.nvim', config = conf.tokyonight, disable = true })
plugin({ 'Mofiqul/vscode.nvim', config = conf.vscode })
plugin({ 'olimorris/onedarkpro.nvim', config = conf.onedarkpro })
plugin({ 'catppuccin/nvim', as = 'catppuccin', config = conf.catppuccin, disable = true })

-- startup plugin
plugin({
  'glepnir/dashboard-nvim',
  config = conf.dashboard,
  requires = 'kyazdani42/nvim-web-devicons',
  disable = true,
})

-- icon
plugin({ 'kyazdani42/nvim-web-devicons' })
plugin({
  'yamatsum/nvim-nonicons',
  requires = { 'kyazdani42/nvim-web-devicons' },
  disable = true,
})

-- statusline
plugin({
  'nvim-lualine/lualine.nvim',
  config = conf.lualine,
  disable = false,
})

-- tabline
plugin({
  'akinsho/nvim-bufferline.lua',
  config = conf.bufferline,
  requires = 'kyazdani42/nvim-web-devicons',
  disable = true,
})

plugin({
  'kyazdani42/nvim-tree.lua',
  config = conf.nvim_tree,
  requires = 'kyazdani42/nvim-web-devicons',
  disable = true,
})

plugin({
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v2.x',
  requires = {
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  config = conf.neo_tree,
  disable = false,
})

plugin({
  'lukas-reineke/indent-blankline.nvim',
  config = conf.indent_blankline,
  event = 'BufRead',
  disable = false,
})

plugin({
  'NvChad/nvim-colorizer.lua',
  config = conf.colorizer,
})
