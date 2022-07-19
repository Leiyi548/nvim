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
  },
})
plugin({ 'L3MON4D3/LuaSnip', config = conf.lua_snip })
plugin({ 'rafamadriz/friendly-snippets' })
plugin({ '~/study/neovim/cmp-flypy' })
plugin({
  'windwp/nvim-autopairs',
  config = conf.auto_pairs
})
