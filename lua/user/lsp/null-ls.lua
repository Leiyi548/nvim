local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/code_actions
local code_actions = null_ls.builtins.code_actions
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/completion
local completion = null_ls.builtins.completion

null_ls.setup({
  debug = false,
  sources = {
    formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
    -- formatting.prettier.with({ extra_args = { "--single-quote", "--jsx-single-quote" } }),
    formatting.black.with({ extra_args = { "--fast" } }), -- python format
    -- formatting.clang_format, -- enable for cpp format
    formatting.stylua, -- enable for lua format
    formatting.goimports, -- enable for Update your Go import lines,adding missing ones and removing unreferenced ones
    -- diagnostics.flake8, -- enable for python diagnostic
    -- diagnostics.luacheck, -- enable for lua diagnostic
    -- diagnostics.cppcheck, -- enable for cpp diagnostic
    -- diagnostics.golangci_lint, -- enable for go diagnostic
    code_actions.gitsigns, -- enable code_action for gitsigns
    -- completion.luasnip, -- enable to use builtins completion sources for luasnip
    -- completion.spell, -- enable to use builtins completion sources for spell
  },
  on_attach = function(client) end,
})
