local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

-- require ("modules.lsp.lsp-signature")
require ("modules.lsp.lsp-installer")
-- require ("modules.lsp.mason")
require ("modules.lsp.handles").setup()
require ("modules.lsp.null-ls")
require ("modules.lsp.navic")
