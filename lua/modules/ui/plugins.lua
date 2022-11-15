local plugin = require('core.pack').register_plugin
local conf = require('modules.ui.config')

-- colorscheme
plugin({ 'Leiyi548/github-nvim-theme', config = conf.github, disable = true })
plugin({ 'Leiyi548/zephyr-nvim', disable = true })
plugin({ 'Lunarvim/darkplus.nvim', disable = true })
plugin({ 'folke/tokyonight.nvim', config = conf.tokyonight })
plugin({ 'rebelot/kanagawa.nvim', config = conf.kanagawa, disable = true })
plugin({ 'olimorris/onedarkpro.nvim', config = conf.onedarkpro, disable = true })
plugin({ 'catppuccin/nvim', as = 'catppuccin', config = conf.catppuccin, disable = false })
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

-- change vim builtin style
plugin({
  'stevearc/dressing.nvim',
  config = conf.dressing,
})

-- winbar
plugin({
  'utilyre/barbecue.nvim',
  config = conf.barbecue,
})
-- tabline
plugin({
  'Leiyi548/nvim-tabline',
  config = conf.tabline,
  disable = true,
})

-- statusline
plugin({
  'nvim-lualine/lualine.nvim',
  config = conf.lualine,
  disable = false,
})

plugin({
  -- 'kyazdani42/nvim-tree.lua',
  'Leiyi548/nvim-tree.lua',
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

plugin({
  'nvim-zh/colorful-winsep.nvim',
  config = conf.colorful_winsep,
  branch = 'dev',
  disable = true,
})

plugin({
  'kevinhwang91/nvim-ufo',
  requires = {
    'kevinhwang91/promise-async',
  },
  config = conf.ufo,
  disable = true,
})
