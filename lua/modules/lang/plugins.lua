-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local plugin = require('core.pack').register_plugin
local conf = require('modules.lang.config')

-- treesitter plugins
plugin({
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  config = conf.nvim_treesitter,
})
plugin({ 'nvim-treesitter/nvim-treesitter-textobjects' })
plugin({ 'nvim-treesitter/playground' })
plugin({
  'nvim-treesitter/nvim-treesitter-context',
  config = conf.nvim_treesitter_content,
})
plugin({ 'p00f/nvim-ts-rainbow' })
plugin({ 'windwp/nvim-ts-autotag' })

-- lua
plugin({ 'christianchiarulli/lua-dev.nvim' })

-- markdown
plugin({
  'iamcco/markdown-preview.nvim',
  run = 'cd app && npm install',
  ft = 'markdown',
  config = function()
    -- set to 1,nvim will open the preview window after entering the markdown buffer
    vim.g.mkdp_auto_start = 0
    -- set to 1, the nvim will auto close current preview window when change
    -- from markdown buffer to another buffer
    vim.g.mkdp_auto_close = 0
    -- " set default theme (dark or light)
    -- " By default the theme is define according to the preferences of the system
    vim.g.mkdp_theme = 'light'
  end,
})

-- neorg
plugin({ 'nvim-neorg/neorg', config = conf.neorg })
