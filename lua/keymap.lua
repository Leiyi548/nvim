-- vim api
local keymap = vim.keymap.set

-- navigate window
keymap("n", "<BS>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- select all
keymap("n", "vae", "ggVG")
keymap("n", "yae", "ggVGy")
keymap("n", "dae", "ggVGd")

-- resize window
keymap("n", "<A-[>", "<cmd>vertical resize-5<cr>")
keymap("n", "<A-]>", "<cmd>vertical resize+5<cr>")
keymap("n", "<A-,>", "<cmd>resize-5<cr>")
keymap("n", "<A-.>", "<cmd>resize+5<cr>")

-- buffer
keymap("n", "<leader>bs", "<cmd>buffers<cr>")
keymap("n", "<leader>bk", "<cmd>bdelete<cr>")
keymap("n", "[b", "<cmd>bp<cr>")
keymap("n", "]b", "<cmd>bn<cr>")
keymap("n", "<leader><Tab>", "<cmd>e #<cr>")

-- move Lines
keymap("n", "<A-j>", ":m .+1<CR>==")
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv")
keymap("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
keymap("n", "<A-k>", ":m .-2<CR>==")
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv")
keymap("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- enhance jk
keymap({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- 防止剪贴版被复制内容给替代
keymap("x", "p", [["_dp]])

-- add undo break-points
keymap("i", ",", ",<c-g>u")
keymap("i", ".", ".<c-g>u")
keymap("i", ";", ";<c-g>u")

-- save in insert mode
keymap("i", "<C-s>", "<cmd>:w<cr><esc>")
keymap("n", "<C-s>", "<cmd>:w<cr><esc>")
keymap("n", "<C-c>", "<cmd>normal ciw<cr>a")

-- better indenting
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- remove highlight
keymap("n", "<leader>h", "<cmd>nohl<cr>")

-- I hide click this key
keymap("n", "H", "^")
keymap("n", "L", "$")
keymap("x", "H", "^")
keymap("x", "L", "$")
keymap("o", "H", "^")
keymap("o", "L", "$")

-- 适配 ahk 改键
keymap("n", "<Home>", "<C-a>")
keymap("n", "<end>", "<C-e>")
keymap("x", "g<Home>", "g<C-a>")
keymap("n", "<right>", "<C-f>")
keymap("n", "<left>", "<C-b>")

-- alpha(dashboard)
keymap("n", "<leader>;", "<cmd>Alpha<cr>")

-- telesope
keymap("n", "<leader>bb", "<cmd>Telescope buffers<cr>")
keymap("n", "<leader>fd", "<cmd>lua require('config.fancy_telescope').find_dotfile()<cr>")
keymap("n", "<leader>fb", "<cmd>Telescope<cr>")
keymap("n", "<leader>fc", "<cmd>Telescope commands<cr>")
keymap("n", "<leader>ff", "<cmd>lua require('config.fancy_telescope').find_files()<cr>")
keymap({ "n", "i", "v" }, "<C-p>", "<cmd>Telescope find_files<cr>")
keymap({ "n", "i", "v" }, "<C-b>", "<cmd>Telescope buffers<cr>")
keymap("n", "<leader>ft", "<cmd>Telescope live_grep<cr>")
keymap("n", "<leader>fT", "<cmd>lua require('config.fancy_telescope').grep_string_by_filetype()<cr>")
keymap("n", "<leader>fo", "<cmd>lua require('config.fancy_telescope').grep_string_open_files()<cr>")
keymap("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
keymap("n", "<leader>fk", "<cmd>Telescope keymaps<cr>")
keymap("n", "<leader>fh", "<cmd>Telescope highlights<cr>")
keymap("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>")
keymap("n", "<leader>gf", "<cmd>Telescope git_files<cr>")
keymap("n", "<leader>gs", "<cmd>lua require('config.fancy_telescope').git_status()<cr>")
keymap("n", "<leader>sh", "<cmd>Telescope help_tags<cr>")
keymap("n", "<leader>sc", "<cmd>Telescope colorscheme<cr>")
keymap("v", "<leader>f", "<cmd>lua require('config.fancy_telescope').grep_string_visual()<cr>")

-- fugitive
keymap("n", "<leader>ga", "<cmd>Git stage " .. vim.fn.expand("%:p") .. "<cr>")
keymap("n", "<leader>gg", "<cmd>G<cr>")

-- neotree
keymap("n", "<leader>ob", "<cmd>NeoTreeFocusToggle buffers<cr>")
keymap("n", "<leader>og", "<cmd>NeoTreeFocusToggle git_status<cr>")

-- lazy
keymap("n", "<leader>lz", "<cmd>Lazy<cr>")

-- gitsign
keymap("n", "[g", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>")
keymap("n", "]g", "<cmd>lua require 'gitsigns'.next_hunk()<cr>")
keymap("n", "<leader>gk", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>")
keymap("n", "<leader>gj", "<cmd>lua require 'gitsigns'.next_hunk()<cr>")
keymap("n", "gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>")
keymap("n", "<leader>rh", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>")
keymap("n", "<leader>rb", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>")

-- toggleterm
keymap("n", "<M-h>", "<cmd>ToggleTerm size=10 direction=horizontal<cr>")

-- lazygit
keymap("n", "<leader>lg", "<cmd>lua require('config.fancy_toggleterm').lazygit_toggle()<cr>")
keymap("n", "<leader>gl", "<cmd>lua require('config.fancy_toggleterm').lazygit_log_toggle()<cr>")

-- coc
keymap("n", "<leader>oo", "<cmd>CocOutline<cr>")
keymap("n", "<leader>ls", "<cmd>Telescope coc document_symbols<cr>")
keymap("n", "<leader>lw", "<cmd>Telescope coc workspace_symbols<cr>")

-- wsl2 copy
keymap({ "n", "v" }, "<leader>y", '"+y"')
keymap({ "n", "v" }, "<leader>p", '"+p"')
