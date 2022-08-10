local null_ls_status_ok, null_ls = pcall(require, 'null-ls')
if not null_ls_status_ok then
  return
end

local lsp_formatting = function(bufnr)
  vim.lsp.buf.format({

    filter = function(clients)
      return vim.tbl_filter(function(client)
        return client.name == 'null-ls' or client.name == 'clangd'
      end, clients)
    end,
    bufnr = bufnr,
  })
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/completion
---@diagnostic disable-next-line: unused-local
local completion = null_ls.builtins.completion

-- https://github.com/prettier-solidity/prettier-plugin-solidity
-- npm install --save-dev prettier prettier-plugin-solidity
null_ls.setup({
  debug = false,
  sources = {
    formatting.prettier.with({
      extra_filetypes = { 'toml', 'solidity' },
      extra_args = { '--no-semi', '--single-quote', '--jsx-single-quote' },
    }), -- enable for html and markdown format
    formatting.black.with({ extra_args = { '--fast' } }), -- enable for python format
    formatting.stylua, -- enable for lua format
    formatting.goimports, -- enable for Update your Go import lines,adding missing ones and removing unreferenced ones
    -- formatting.google_java_format, -- enable for java format

    diagnostics.flake8, -- enable for python diagnostics

    -- code_actions.gitsigns, -- enable code_action for gitsigns
  },
})

local unwrap = {
  method = null_ls.methods.DIAGNOSTICS,
  filetypes = { 'rust' },
  generator = {
    fn = function(params)
      local diagnostics = {}
      -- sources have access to a params object
      -- containing info about the current file and editor state
      for i, line in ipairs(params.content) do
        local col, end_col = line:find('unwrap()')
        if col and end_col then
          -- null-ls fills in undefined positions
          -- and converts source diagnostics into the required format
          table.insert(diagnostics, {
            row = i,
            col = col,
            end_col = end_col,
            source = 'unwrap',
            message = 'hey ' .. os.getenv('USER') .. ", don't forget to handle this",
            severity = 2,
          })
        end
      end
      return diagnostics
    end,
  },
}

null_ls.register(unwrap)
