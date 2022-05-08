local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>o", '<cmd>lua require("structrue-go").toggle()<cr>', opts)
