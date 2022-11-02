local plugin = require('core.pack').register_plugin

plugin({ 'neovim/nvim-lspconfig' })
plugin({ 'jose-elias-alvarez/null-ls.nvim' })
plugin({ 'RRethy/vim-illuminate', disable = true })
plugin({ 'SmiteshP/nvim-navic' })
plugin({ 'williamboman/mason.nvim' })
plugin({ 'williamboman/mason-lspconfig.nvim' })
plugin({ 'glepnir/lspsaga.nvim', branch = 'main' })
plugin({
  'j-hui/fidget.nvim',
  config = function()
    require('fidget').setup({
      window = {
        relative = 'win', -- where to anchor, either "win" or "editor"
        blend = 0, -- &winblend for the window
        zindex = nil, -- the zindex value for the window
        border = 'none', -- style of border for the fidget window
      },
    })
  end,
})
plugin({ 'ray-x/lsp_signature.nvim', disable = true })
-- plugin({ 'https://git.sr.ht/~whynothugo/lsp_lines.nvim' })
