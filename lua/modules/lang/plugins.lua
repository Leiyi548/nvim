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
plugin({ 'nvim-treesitter/nvim-treesitter-textobjects'})
plugin({ 'nvim-treesitter/playground'})
plugin({ 'p00f/nvim-ts-rainbow'})
plugin({ 'windwp/nvim-ts-autotag'})

