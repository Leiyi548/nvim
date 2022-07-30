local ok, lsp_installer = pcall(require, 'nvim-lsp-installer')
if not ok then
  return
end
local servers = {
  'sumneko_lua',
  'pyright',
  'html',
  'emmet_ls',
  'cssls',
  "clangd",
  "bashls"
}
local settings = {
  ensure_installed = servers,
  automatic_installation = true, -- automatically detect which servers to install (based on which servers are set up via lspconfig)
  ui = {
    icons = {
      server_installed = ' ',
      server_pending = ' ',
      server_uninstalled = ' ﮊ',
    },
    keymaps = {
      toggle_server_expand = '<CR>',
      install_server = 'i',
      update_server = 'u',
      check_server_version = 'c',
      update_all_servers = 'U',
      check_outdated_servers = 'C',
      uninstall_server = 'X',
    },
  },
}

lsp_installer.setup(settings)

local lspconfig_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require('modules.lsp.handles').on_attach,
    capabilities = require('modules.lsp.handles').capabilities,
  }

  server = vim.split(server, '@')[1]

  if server == 'sumneko_lua' then
    local sumneko_opts = require('modules.lsp.settings.sumneko_lua')
    opts = vim.tbl_deep_extend('force', sumneko_opts, opts)
  end

  if server == 'pyright' then
    local pyright_opts = require('modules.lsp.settings.pyright')
    opts = vim.tbl_deep_extend('force', pyright_opts, opts)
  end

  if server == 'emmet_ls' then
    local emmet_ls_opts = require('modules.lsp.settings.emmet_ls')
    opts = vim.tbl_deep_extend('force', emmet_ls_opts, opts)
  end

  if server == 'html' then
    local html_opts = require('modules.lsp.settings.html')
    opts = vim.tbl_deep_extend('force', html_opts, opts)
  end

  if server == 'cssls' then
    local cssls_opts = require('modules.lsp.settings.cssls')
    opts = vim.tbl_deep_extend('force', cssls_opts, opts)
  end

  if server == 'clangd' then
    opts.capabilities.offsetEncoding = { "utf-16" }
  end
  lspconfig[server].setup(opts)
  ---@diagnostic disable-next-line: unused-label
  ::continue::
end
