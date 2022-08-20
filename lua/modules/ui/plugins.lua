-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local plugin = require('core.pack').register_plugin
local conf = require('modules.ui.config')

-- colorscheme
-- plugin({ 'Leiyi548/onedarker.nvim' })
plugin({ 'lunarvim/onedarker.nvim' })
plugin({ 'lunarvim/horizon.nvim' })
-- plugin({ 'lunarvim/darkplus.nvim' })
-- plugin({ 'lunarvim/synthwave84.nvim' })
plugin({ 'projekt0n/github-nvim-theme', config = conf.github })
plugin({ 'olimorris/onedarkpro.nvim', disable = true })
plugin({ 'rebelot/kanagawa.nvim' })
plugin({ 'catppuccin/nvim', config = conf.catppuccin })
plugin({ 'rose-pine/neovim' })
plugin({
  'sainnhe/gruvbox-material',
  config = conf.gruvbox_material,
})
plugin({
  'luisiacc/gruvbox-baby',
  config = conf.gruvbox_baby,
})
-- plugin({ 'glepnir/zephyr-nvim'})
-- plugin({ '~/study/neovim/onedarkpro' })

-- startup plugin
plugin({
  'glepnir/dashboard-nvim',
  config = conf.dashboard,
  requires = 'kyazdani42/nvim-web-devicons',
  disable = false,
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
})

plugin({
  'kyazdani42/nvim-tree.lua',
  config = conf.nvim_tree,
  requires = 'kyazdani42/nvim-web-devicons',
  disable = false,
})

plugin({
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v2.x',
  requires = {
    'nvim-lua/plenary.nvim',
    'kyazdani42/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  config = conf.neo_tree,
  disable = true,
})

plugin({
  'MunifTanjim/nui.nvim',
})

plugin({
  'lukas-reineke/indent-blankline.nvim',
  config = conf.indent_blankline,
  event = 'BufRead',
  -- after = 'nvim-treesitter',
})

plugin({
  'NvChad/nvim-colorizer.lua',
  config = conf.colorizer,
})
