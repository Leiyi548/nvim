local status_ok, mason = pcall(require, 'mason')
if not status_ok then
  return
end

local status_ok_1, mason_lspconfig = pcall(require, 'mason-lspconfig')
if not status_ok_1 then
  return
end

local servers = {
  'sumneko_lua',
  'pyright',
  -- npm i -g vscode-langservers-extracted
  'html',
  'cssls',
  -- npm install -g emmet-ls
  'emmet_ls',
  'clangd',
  -- npm i -g bash-language-server
  'bashls',
  -- npm install -g typescript typescript-language-server
  'tsserver',
}

local settings = {
  ui = {
    border = 'rounded',
    icons = {
      package_pending = ' ',
      package_installed = ' ',
      package_uninstalled = ' ﮊ',
    },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup({
  ensure_installed = servers,
  automatic_installation = true,
})

local lspconfig_status_ok, lspconfig = pcall(require, 'lspconfig')
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require('modules.lsp.handles').on_attach,
    capabilities = require('modules.lsp.handles').capabilities,
    -- capabilities = require("modules.lsp.handlers").capabilities,
  }

  server = vim.split(server, '@')[1]
  if server == 'sumneko_lua' then
    local l_status_ok, lua_dev = pcall(require, 'lua-dev')
    if not l_status_ok then
      return
    end
    local luadev = lua_dev.setup({
      --   -- add any options here, or leave empty to use the default settings
      -- lspconfig = opts,
      lspconfig = {
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
        --   -- settings = opts.settings,
      },
    })
    lspconfig.sumneko_lua.setup(luadev)
    goto continue
  end

  if server == 'pyright' then
    local pyright_opts = require('modules.lsp.settings.pyright')
    opts = vim.tbl_deep_extend('force', pyright_opts, opts)
  end

  if server == 'emmet_ls' then
    local emmet_ls_opts = require('modules.lsp.settings.emmet_ls')
    opts = vim.tbl_deep_extend('force', emmet_ls_opts, opts)
  end

  lspconfig[server].setup(opts)
  ::continue::
end

-- TODO: add something to installer later
-- require("lspconfig").motoko.setup {}
