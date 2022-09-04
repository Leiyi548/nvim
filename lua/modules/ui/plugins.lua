-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local plugin = require('core.pack').register_plugin
local conf = require('modules.ui.config')

-- colorscheme
-- plugin({ 'Leiyi548/onedarker.nvim' })
-- plugin({ 'lunarvim/onedarker.nvim' })
-- plugin({ 'lunarvim/horizon.nvim' })
-- plugin({ 'lunarvim/darkplus.nvim' })
-- plugin({ 'lunarvim/synthwave84.nvim' })
plugin({ 'olimorris/onedarkpro.nvim', disable = true })
plugin({ 'Leiyi548/github-nvim-theme', config = conf.github })
plugin({ 'rebelot/kanagawa.nvim', config = conf.kanagawa })
-- 给插件的名字取别名 原本是叫 nvim 被改成叫 catppuccin
plugin({ 'catppuccin/nvim', as = 'catppuccin', config = conf.catppuccin })
plugin({ 'rose-pine/neovim', as = 'rose-pine' })
plugin({
  'sainnhe/gruvbox-material',
  config = conf.gruvbox_material,
})
plugin({
  'luisiacc/gruvbox-baby',
  config = conf.gruvbox_baby,
})
plugin({
  'marko-cerovac/material.nvim',
  config = conf.material,
})
plugin({ 'Leiyi548/zephyr-nvim' })
plugin({ 'kaiuri/nvim-juliana' })
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
})

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
