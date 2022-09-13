-- author: Leiyi548 https://github.com/Leiyi548
-- date: 2022-09-13
-- License: MIT

local plugin = require('core.pack').register_plugin
local conf = require('modules.coc.config')

plugin({ 'neoclide/coc.nvim', branch = 'release', config = conf.coc })
plugin({ 'windwp/nvim-autopairs', config = conf.autopairs, event = 'InsertEnter' })
plugin({ 'fannheyward/telescope-coc.nvim' })
plugin({
  'kevinhwang91/nvim-ufo',
  requires = 'kevinhwang91/promise-async',
  config = conf.ufo,
})
plugin({ 'sbdchd/neoformat', config = conf.neoformat })
