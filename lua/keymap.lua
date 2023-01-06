-- navigate window
vim.keymap.set("n", "<BS>", "<C-w>h")
vim.keymap.set("n", "<C-j>", "<C-w>j")
vim.keymap.set("n", "<C-k>", "<C-w>k")
vim.keymap.set("n", "<C-l>", "<C-w>l")

-- resize window
vim.keymap.set("n", "<A-[>", "<cmd>vertical resize-5<cr>")
vim.keymap.set("n", "<A-]>", "<cmd>vertical resize+5<cr>")
vim.keymap.set("n", "<A-,>", "<cmd>resize-5<cr>")
vim.keymap.set("n", "<A-.>", "<cmd>resize+5<cr>")

-- buffer
vim.keymap.set("n", "<leader>bs", "<cmd>buffers<cr>")
vim.keymap.set("n", "[b", "<cmd>bp<cr>")
vim.keymap.set("n", "]b", "<cmd>bn<cr>")
vim.keymap.set("n", "<leader><Tab>", "<cmd>e #<cr>")

-- move Lines
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi")
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi")

-- enhance jk
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- 防止剪贴版被复制内容给替代
vim.keymap.set("x", "p", [["_dp]])

-- add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- save in insert mode
vim.keymap.set("i", "<C-s>", "<cmd>:w<cr><esc>")
vim.keymap.set("n", "<C-s>", "<cmd>:w<cr><esc>")
vim.keymap.set("n", "<C-c>", "<cmd>normal ciw<cr>a")

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- remove highlight
vim.keymap.set("n", "<leader>h", "<cmd>nohl<cr>")

-- I hide click this key
vim.keymap.set("n", "H", "^")
vim.keymap.set("n", "L", "$")
vim.keymap.set("x", "H", "^")
vim.keymap.set("x", "L", "$")
vim.keymap.set("o", "H", "^")
vim.keymap.set("o", "L", "$")

-- 适配 ahk 改键
vim.keymap.set("n", "<home>", "<C-a>")
vim.keymap.set("v", "g<home>", "g<C-a>")
vim.keymap.set("n", "<right>", "<C-f>")
vim.keymap.set("n", "<left>", "<C-b>")

-- alpha(dashboard)
vim.keymap.set("n", "<leader>;", "<cmd>Alpha<cr>")

-- telesope
vim.keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<cr>")
vim.keymap.set("n", "<leader>fd", "<cmd>lua require('config.fancy_telescope').find_dotfile()<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope<cr>")
vim.keymap.set("n", "<leader>fc", "<cmd>Telescope commands<cr>")
vim.keymap.set("n", "<leader>ff", "<cmd>lua require('config.fancy_telescope').find_files()<cr>")
vim.keymap.set("n", "<C-p>", "<cmd>Telescope find_files<cr>")
vim.keymap.set("n", "<leader>ft", "<cmd>Telescope live_grep<cr>")
vim.keymap.set("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>")
vim.keymap.set("n", "<leader>fk", "<cmd>Telescope keymaps<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>Telescope highlights<cr>")
vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>")
vim.keymap.set("n", "<leader>gf", "<cmd>Telescope git_files<cr>")
vim.keymap.set("n", "<leader>gs", "<cmd>lua require('config.fancy_telescope').git_status()<cr>")
vim.keymap.set("n", "<leader>sh", "<cmd>Telescope help_tags<cr>")
vim.keymap.set("n", "<leader>sc", "<cmd>Telescope colorscheme<cr>")
vim.keymap.set("v", "<leader>f", "<cmd>lua require('config.fancy_telescope').grep_string_visual()<cr>")

-- fugitive
vim.keymap.set("n", "<leader>ga", "<cmd>Git stage " .. vim.fn.expand("%:p") .. "<cr>")
vim.keymap.set("n", "<leader>gg", "<cmd>G<cr>")

-- neotree
vim.keymap.set("n", "<leader>ob", "<cmd>NeoTreeFocusToggle buffers<cr>")
vim.keymap.set("n", "<leader>og", "<cmd>NeoTreeFocusToggle git_status<cr>")

-- lazy
vim.keymap.set("n", "<leader>lz", "<cmd>Lazy<cr>")

-- gitsign
vim.keymap.set("n", "[g", "<cmd>lua require 'gitsigns'.prev_hunk()<cr>")
vim.keymap.set("n", "]g", "<cmd>lua require 'gitsigns'.next_hunk()<cr>")
vim.keymap.set("n", "gp", "<cmd>lua require 'gitsigns'.preview_hunk()<cr>")
vim.keymap.set("n", "<leader>rh", "<cmd>lua require 'gitsigns'.reset_hunk()<cr>")
vim.keymap.set("n", "<leader>rb", "<cmd>lua require 'gitsigns'.reset_buffer()<cr>")

-- toggleterm
vim.keymap.set("n", "<M-h>", "<cmd>ToggleTerm size=10 direction=horizontal<cr>")

-- lazygit
vim.keymap.set("n", "<leader>lg", "<cmd>lua require('config.fancy_toggleterm').lazygit_toggle()<cr>")
vim.keymap.set("n", "<leader>gl", "<cmd>lua require('config.fancy_toggleterm').lazygit_log_toggle()<cr>")

-- coc
vim.keymap.set("n", "<leader>oo", "<cmd>CocOutline<cr>")
vim.keymap.set("n", "<leader>ls", "<cmd>Telescope coc document_symbols<cr>")
vim.keymap.set("n", "<leader>lw", "<cmd>Telescope coc workspace_symbols<cr>")

-- wsl2 copy
vim.keymap.set("n", "<leader>y", '"+y"')
vim.keymap.set("n", "<leader>p", '"+p"')
vim.keymap.set("v", "<leader>y", '"+y"')
vim.keymap.set("v", "<leader>p", '"+p"')
