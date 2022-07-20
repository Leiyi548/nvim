-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#html
-- npm i -g vscode-langservers-extracted

return {
  configurationSection = { 'html', 'css', 'javascript' },
  embeddedLanguages = {
    css = true,
    javascript = true,
  },
  provideFormatter = true,
}
