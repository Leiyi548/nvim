require('mason').setup({
  ui = {
    icons = {
      package_installed = '✓',
      package_pending = '➜',
      package_uninstalled = '✗',
    },
  },
})

local ensure_installed = {
  'stylua',
  'goimports',
  'prettier',
}

-- install format on lint tool
local mr = require('mason-registry')

for _, tool in ipairs(ensure_installed) do
  local p = mr.get_package(tool)
  if not p:is_installed() then
    p:install()
  end
end
