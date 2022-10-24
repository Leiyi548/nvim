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
    { 'hrsh7th/cmp-path', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' },
    { 'saadparwaiz1/cmp_luasnip', after = 'nvim-cmp' },
    { 'hrsh7th/cmp-cmdline', after = 'nvim-cmp' },
    -- { 'hrsh7th/cmp-emoji' },
    -- { 'Leiyi548/cmp-flypy.nvim', run = 'make', config = conf.flypy ,after="nvim_cmp"},
  },
  event = { 'InsertEnter', 'CmdLineEnter' },
})
plugin({ 'L3MON4D3/LuaSnip', config = conf.lua_snip })
plugin({ 'Leiyi548/friendly-snippets' })
plugin({
  'windwp/nvim-autopairs',
  config = conf.auto_pairs,
  after = 'nvim-cmp',
})
