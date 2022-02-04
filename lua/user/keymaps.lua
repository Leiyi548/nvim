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

-- Better easymotion (hop)
keymap("n", "E", "<cmd>HopChar1<cr>", opts)
keymap("v", "E", "<cmd>HopChar1<cr>", opts)
keymap("n", "ss", "<cmd>HopChar2<cr>", opts)
keymap("v", "ss", "<cmd>HopChar2<cr>", opts)
keymap("n", "sl", "<cmd>HopLineStart<cr>", opts)
keymap("v", "sl", "<cmd>HopLineStart<cr>", opts)
keymap("n", "sw", "<cmd>HopWord<cr>", opts)
keymap("v", "sw", "<cmd>HopWord<cr>", opts)

-- Better toggle_colorscheme()
keymap("n", "|", "<cmd>lua toggle_colorscheme()<cr>", opts)
keymap("v", "|", "<cmd>lua toggle_colorscheme()<cr>", opts)

-- Better file navigation(harpoon)
keymap("n", "gn", '<cmd>lua require("harpoon.ui").nav_next()<cr>', opts)
keymap("n", "gp", '<cmd>lua require("harpoon.ui").nav_prev()<cr>', opts)

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
keymap("i", "<C-g>", "<cmd>lua _LAZYGIT_TOGGLE()<CR> ", opts)

-- Better CodeAction (use telescope builtin code_action)
keymap("n", "ga", "<cmd>lua require('user.fancy_telescope').code_actions()<CR>", opts)

-- Resize with arrows(left right up down)
keymap("n", "<Up>", ":resize -2<CR>", opts)
keymap("n", "<Down>", ":resize +2<CR>", opts)
keymap("n", "<Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<Right>", ":vertical resize +2<CR>", opts)

-- Navigate buffers(using tab and Shift-tab)
keymap("n", "<Tab>", ":bnext<CR>", opts)
keymap("n", "<S-Tab>", ":bprevious<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)
keymap("n", ">", ">>", opts)
keymap("n", "<", "<<", opts)

keymap("v", "p", '"_dP', opts)

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)

-- Terminal --
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)
