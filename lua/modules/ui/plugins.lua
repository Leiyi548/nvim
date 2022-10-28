local plugin = require('core.pack').register_plugin
local conf = require('modules.ui.config')

-- colorscheme
plugin({ 'Leiyi548/github-nvim-theme', config = conf.github, disable = true })
plugin({ 'Leiyi548/zephyr-nvim', disable = true })
plugin({ 'Lunarvim/darkplus.nvim', disable = true })
plugin({ 'folke/tokyonight.nvim', config = conf.tokyonight })
plugin({ 'rebelot/kanagawa.nvim', config = conf.kanagawa, disable = true })
plugin({ 'olimorris/onedarkpro.nvim', config = conf.onedarkpro, disable = true })
plugin({ 'catppuccin/nvim', as = 'catppuccin', config = conf.catppuccin, disable = true })
plugin({ 'rose-pine/neovim', as = 'rose-pine', disable = true })
plugin({
  'sainnhe/gruvbox-material',
  config = conf.gruvbox_material,
  disable = true,
})
plugin({
  'luisiacc/gruvbox-baby',
  config = conf.gruvbox_baby,
  disable = true,
})
plugin({
  'marko-cerovac/material.nvim',
  config = conf.material,
  disable = true,
})

-- startup plugin
plugin({
  'glepnir/dashboard-nvim',
  config = conf.dashboard,
  requires = 'kyazdani42/nvim-web-devicons',
  disable = false,
})

-- icon
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
  disable = 'true',
})

plugin({
  'kyazdani42/nvim-tree.lua',
  config = conf.nvim_tree,
  requires = 'kyazdani42/nvim-web-devicons',
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

plugin({
  'kevinhwang91/nvim-ufo',
  requires = {
    'kevinhwang91/promise-async',
  },
  config = conf.ufo,
  disable = true,
})
