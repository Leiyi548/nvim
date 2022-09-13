-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local plugin = require('core.pack').register_plugin
local conf = require('modules.completion.config')

plugin({ 'neoclide/coc.nvim', branch = "release", config = conf.coc })
plugin({ 'fannheyward/telescope-coc.nvim' })
plugin({ 'sbdchd/neoformat',config = conf.neoformat  })
