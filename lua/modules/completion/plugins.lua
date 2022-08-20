-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local plugin = require('core.pack').register_plugin
local conf = require('modules.completion.config')

plugin({
  'hrsh7th/nvim-cmp',
  config = conf.nvim_cmp,
  requires = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-buffer' },
    { 'saadparwaiz1/cmp_luasnip' },
    { 'hrsh7th/cmp-cmdline' },
    { 'hrsh7th/cmp-emoji' },
    -- { 'Leiyi548/cmp-flypy.nvim', run = 'make', config = conf.flypy },
  },
})
plugin({ 'L3MON4D3/LuaSnip', config = conf.lua_snip })
plugin({ 'Leiyi548/friendly-snippets' })
plugin({
  'windwp/nvim-autopairs',
  config = conf.auto_pairs,
})
