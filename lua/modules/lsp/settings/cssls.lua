-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#cssls
-- npm i -g vscode-langservers-extracted

return {
  css = {
    validate = true,
  },
  less = {
    validate = true,
  },
  scss = {
    validate = true,
  },
}
