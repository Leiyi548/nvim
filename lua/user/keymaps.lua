local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("n", "<C-h>", "<CMD>lua require('Navigator').left()<cr>", opts)
keymap("n", "<C-j>", "<CMD>lua require('Navigator').down()<cr>", opts)
keymap("n", "<C-k>", "<CMD>lua require('Navigator').up()<cr>", opts)
keymap("n", "<C-l>", "<CMD>lua require('Navigator').right()<cr>", opts)
-- Split window
keymap("n", "sv", "<cmd>vsplit<cr>", opts)
keymap("n", "sg", "<cmd>split<cr>", opts)
keymap("n", "sc", "<C-w>c", opts)

-- Better close buffer
keymap("n", "X", "<cmd>bdelete!<cr>", opts)

-- Better open .html in Chrome
keymap("n", "<M-b>", "<cmd>AsyncTask Application<cr>", opts)
keymap("i", "<M-b>", "<cmd>AsyncTask Application<cr>", opts)

-- Better easymotion (hop)
keymap("n", "E", "<cmd>HopChar1<cr>", opts)
keymap("v", "E", "<cmd>HopChar1<cr>", opts)
keymap("n", "ss", "<cmd>HopChar2<cr>", opts)
keymap("v", "ss", "<cmd>HopChar2<cr>", opts)
keymap("n", "sl", "<cmd>HopLineStart<cr>", opts)
keymap("v", "sl", "<cmd>HopLineStart<cr>", opts)
keymap("n", "sw", "<cmd>HopWord<cr>", opts)
keymap("v", "sw", "<cmd>HopWord<cr>", opts)

-- Better gitsign git_blame navigation
keymap("n", "[g", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", opts)
keymap("n", "]g", "<cmd>lua require 'gitsigns'.next_hunk()<cr>", opts)

-- Better snippets engine (luasnip)
-- choice node
vim.api.nvim_set_keymap("i", "<C-l>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-l>", "<Plug>luasnip-next-choice", {})
keymap("i", "<C-j>", "<cmd>lua require('luasnip').jump(1)<cr>", opts)
keymap("i", "<C-k>", "<cmd>lua require('luasnip').jump(-1)<cr>", opts)

-- Better toggle_colorscheme()
keymap("n", "|", "<cmd>lua toggle_colorscheme()<cr>", opts)
keymap("v", "|", "<cmd>lua toggle_colorscheme()<cr>", opts)

-- Better persistence (sessions management)
keymap("n", "<leader>sl", [[<cmd>lua require("persistence").load()<cr>]], opts)

-- Better file_browser use telescope.nvim
keymap("n", "<C-e>", [[<cmd> Telescope file_browser<cr>]], opts)

-- Better file navigation(harpoon)
keymap("n", "gn", '<cmd>lua require("harpoon.ui").nav_next()<cr>', opts)
keymap("n", "gp", '<cmd>lua require("harpoon.ui").nav_prev()<cr>', opts)

-- Better telescope find lsp symbol
keymap("n", "gs", '<cmd>Telescope lsp_document_symbols<cr>', opts)
-- Better copy and paste
keymap("n", "<leader>y", '"+y', opts)
keymap("n", "<leader>p", '"+p', opts)
keymap("v", "<leader>y", '"+y', opts)
keymap("v", "<leader>p", '"+p', opts)
keymap("n", "<leader>P", '"+P', opts)
keymap("v", "<leader>P", '"+P', opts)

-- Better Quit
keymap("n", "Q", ":qa!<cr>", opts)

-- Better ^ $
keymap("n", "H", "^", opts)
keymap("n", "L", "$", opts)
keymap("v", "H", "^", opts)
keymap("v", "L", "$", opts)

-- Better lazygit keybinding
keymap("n", "<C-g>", "<cmd>lua _LAZYGIT_TOGGLE()<CR> ", opts)

-- Better CodeAction (use telescope builtin code_action)
keymap("n", "ga", "<cmd>lua require('user.fancy_telescope').code_actions()<CR>", opts)

-- Resize with arrows(left right up down)
-- keymap("n", "<Up>", ":resize -2<CR>", opts)
-- keymap("n", "<Down>", ":resize +2<CR>", opts)
-- keymap("n", "<Left>", ":vertical resize -2<CR>", opts)
-- keymap("n", "<Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers(using tab and Shift-tab)
keymap("n", "<Tab>", ":bnext<CR>", opts)
keymap("n", "<S-Tab>", ":bprevious<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("n", ">", ">>", opts)
keymap("n", "<", "<<", opts)

-- have some troubles in luasnip (delete)
-- keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

if builtin.plugins.copilot.active then
	keymap("i", "<C-h>", [[copilot#Accept("\<CR>")]], { expr = true, script = true })
end

-- Better create file
keymap("n", "<leader>ne", ":edit ", opts)
-- Better rename file
vim.cmd([[
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        exec ':bd ' . old_name
        exec ':NvimTreeRefresh'
        redraw!
    endif
endfunction
nnoremap <leader>rn :call RenameFile()<cr>
]])
