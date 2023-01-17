-- vim api
local keymap = vim.keymap.set

-- navigate window
keymap("n", "<BS>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- vim cmd alias
vim.cmd([[cnoreabbrev qq q!]])
vim.cmd([[cnoreabbrev qqa qa!]])

-- confirm quit neovim
keymap("n", "<leader>q", ":confirm quit<cr>")

-- quickly input command && I don't use c-f
keymap({ "n", "v" }, "<Right>", ":")
-- make the ring finger comfortable
keymap("c", "<C-l>", "<cr>")

-- better n N J
keymap("n", "J", "mzJ`z")

-- all content
keymap("n", "vae", "ggVG")
keymap("n", "yae", "ggVGy")
keymap("n", "dae", "ggVGd")
keymap("n", "cae", "ggVGc")

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
keymap({ "n", "i", "v" }, "<F19>", "<cmd>e #<cr>")

-- move Lines
keymap("n", "<A-j>", ":m .+1<CR>==")
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv")
keymap("i", "<A-j>", "<esc>:m .+1<CR>==gi")
keymap("n", "<A-k>", ":m .-2<CR>==")
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv")
keymap("i", "<A-k>", "<esc>:m .-2<CR>==gi")

-- enhance jk
keymap({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- prevents the clipboard from being replaced by copied content
keymap("x", "p", "\"_dP")

-- add undo break-points
keymap("i", ",", ",<c-g>u")
keymap("i", ".", ".<c-g>u")
keymap("i", ";", ";<c-g>u")

-- fast save
keymap({ "n", "i", "v" }, "<C-s>", "<cmd>write<cr>")

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

-- adapts the autohotkey key change
keymap("n", "<Home>", "<C-a>")
keymap("n", "<end>", "<C-e>")
keymap("x", "g<Home>", "g<C-a>")

-- alpha
keymap("n", "<leader>;", "<cmd>Alpha<cr>")

-- telescope
keymap("n", "<leader>bb", "<cmd>Telescope buffers<cr>")
-- I don't use c-b
keymap("n", "<Left>", "<cmd>Telescope buffers<cr>")
keymap("n", "<leader>fd", "<cmd>lua require('config.fancy_telescope').find_dotfile()<cr>")
keymap("n", "<leader>fb", "<cmd>Telescope<cr>")
keymap("n", "<leader>fc", "<cmd>Telescope commands<cr>")
keymap("n", "<leader>fg", "<cmd>Telescope resume<cr>")
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
keymap("n", "<leader>sr", "<cmd>Telescope registers<cr>")
keymap("v", "<leader>f", "<cmd>lua require('config.fancy_telescope').grep_string_visual()<cr>")

-- fugitive
keymap("n", "<leader>gi", "<cmd>G init<cr>")
keymap("n", "<leader>ga", "<cmd>Gwrite<cr>")
keymap("n", "<leader>gd", "<cmd>Gvdiffsplit<cr>")
keymap("n", "<leader>gg", "<cmd>G<cr>")
keymap("n", "<leader>gp", "<cmd>G push<cr>")
vim.cmd([[cnoreabbrev git Git]])

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
keymap("n", "<A-h>", "<cmd>ToggleTerm size=10 direction=horizontal<cr>")
keymap("n", "<A-v>", "<cmd>ToggleTerm size=10 direction=vertical<cr>")
keymap("n", "<A-i>", "<cmd>ToggleTerm direction=float<cr>")

-- lazygit
keymap("n", "<leader>lg", "<cmd>lua require('config.fancy_toggleterm').lazygit_toggle()<cr>")
keymap("n", "<leader>gl", "<cmd>G log<cr>")
keymap("n", "<leader>gL", "<cmd>lua require('config.fancy_toggleterm').lazygit_log_toggle()<cr>")

-- coc
keymap("n", "<leader>oo", "<cmd>CocOutline<cr>")
keymap("n", "<leader>ls", "<cmd>Telescope coc document_symbols<cr>")
keymap({ "n", "i", "v" }, "<F20>", "<cmd>Telescope coc document_symbols<cr>")
keymap("n", "<leader>lw", "<cmd>Telescope coc workspace_symbols<cr>")

-- marks.nvim
keymap("n", "<leader>tm", "<cmd>MarksToggleSigns<cr>")

-- harpoon
keymap("n", "<leader><leader>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")
keymap("n", "<leader>a", "<cmd>lua require('harpoon.mark').add_file()<cr>")
keymap("n", "<leader>1", "<cmd>lua require('harpoon.ui').nav_file(1)<cr>")
keymap("n", "<leader>2", "<cmd>lua require('harpoon.ui').nav_file(2)<cr>")
keymap("n", "<leader>3", "<cmd>lua require('harpoon.ui').nav_file(3)<cr>")
keymap("n", "<leader>4", "<cmd>lua require('harpoon.ui').nav_file(4)<cr>")

-- wsl2 copy
if vim.fn.has('wsl') == 1 then
  keymap({ "n", "v" }, "<leader>y", '"+y"')
  keymap({ "n", "v" }, "<leader>p", '"+p"')
end
