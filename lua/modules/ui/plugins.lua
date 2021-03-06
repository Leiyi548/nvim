-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local plugin = require('core.pack').register_plugin
local conf = require('modules.ui.config')

-- colorscheme
plugin({ 'Leiyi548/onedarker.nvim' })
plugin({ 'lunarvim/darkplus.nvim', disable = true })
plugin({ 'projekt0n/github-nvim-theme', config = conf.github })
plugin({ 'olimorris/onedarkpro.nvim',disable = true })
-- plugin({ '~/study/neovim/onedarkpro' })

-- startup plugin
plugin({ 'glepnir/dashboard-nvim', config = conf.dashboard, disable = true })
plugin({ 'goolord/alpha-nvim', config = conf.alpha_dashboard, requires = 'kyazdani42/nvim-web-devicons' })

-- statusline
plugin({
  'nvim-lualine/lualine.nvim',
  config = conf.lualine,
})

-- tabline
plugin({
  'akinsho/nvim-bufferline.lua',
  config = conf.bufferline,
  requires = 'kyazdani42/nvim-web-devicons',
})

plugin({
  'kyazdani42/nvim-tree.lua',
  config = conf.nvim_tree,
  requires = 'kyazdani42/nvim-web-devicons',
})

plugin({
  'lukas-reineke/indent-blankline.nvim',
  config = conf.indent_blankline,
})

plugin({
  'NvChad/nvim-colorizer.lua',
  config = conf.colorizer,
})
