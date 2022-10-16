local plugin = require('core.pack').register_plugin

plugin({ 'neovim/nvim-lspconfig' })
-- plugin({ 'williamboman/nvim-lsp-installer' })
plugin({ 'jose-elias-alvarez/null-ls.nvim' })
plugin({ 'RRethy/vim-illuminate' })
plugin({ 'SmiteshP/nvim-navic' })
plugin({ 'williamboman/mason.nvim' })
plugin({ 'williamboman/mason-lspconfig.nvim' })
plugin({ 'glepnir/lspsaga.nvim', branch = 'main' })
plugin({
  'j-hui/fidget.nvim',
  config = function()
    require('fidget').setup({})
  end,
})
plugin({ 'ray-x/lsp_signature.nvim', disable = true })
-- plugin({ 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' })
