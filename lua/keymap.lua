local keymap = vim.keymap.set

-- navigate window
keymap('n', '<BS>', '<C-w>h')
keymap('n', '<C-j>', '<C-w>j')
keymap('n', '<C-k>', '<C-w>k')
keymap('n', '<C-l>', '<C-w>l')

-- fast quit: vim cmd alias
vim.cmd([[cnoreabbrev <expr> qq getcmdtype() == ':' && getcmdline() ==# 'qq' ? 'q!' : 'qq']])
vim.cmd([[cnoreabbrev <expr> qqa getcmdtype() == ':' && getcmdline() ==# 'qqa' ? 'qa!' : 'qqa']])
vim.cmd([[cnoreabbrev <expr> z getcmdtype() == ':' && getcmdline() ==# 'z' ? 'q!' : 'z']])
vim.cmd([[cnoreabbrev <expr> za getcmdtype() == ':' && getcmdline() ==# 'za' ? 'qa!' : 'za']])
vim.cmd([[cnoreabbrev <expr> ee getcmdtype() == ':' && getcmdline() ==# 'ee' ? 'e!' : 'ee']])

-- add empty lines before and after cursor line
keymap('n', 'gO', "<Cmd>call append(line('.') - 1, repeat([''], v:count1))<CR>", { desc = 'Put empty line above' })
keymap('n', 'go', "<Cmd>call append(line('.'),     repeat([''], v:count1))<CR>", { desc = 'Put empty line below' })

-- reselect latest changed, put, or yanked text
keymap('n', 'gV', '"`[" . strpart(getregtype(), 0, 1) . "`]"', { expr = true, desc = 'Visually select changed text' })

-- Search inside visually highlighted text. Use `silent = false` for it to
-- make effect immediately.
keymap('x', 'g/', '<esc>/\\%V', { silent = false, desc = 'Search inside visual selection' })

-- correct latest misspelled word by taking first suggestion.
-- Use `<C-g>u` in Insert mode to mark this as separate undoable action.
-- Source: https://stackoverflow.com/a/16481737
-- NOTE: this remaps `<C-z>` in Normal mode (completely stops Neovim), but
-- it seems to be too harmful anyway.
keymap('n', '<C-z>', '[s1z=', { desc = 'Correct latest misspelled word' })
keymap('i', '<C-z>', '<C-g>u<Esc>[s1z=`]a<C-g>u', { desc = 'Correct latest misspelled word' })

-- toggle neovim option
keymap(
  'n',
  '\\b',
  '<Cmd>lua vim.o.bg = vim.o.bg == "dark" and "light" or "dark"; print(vim.o.bg)<CR>',
  { desc = "Toggle 'background'" }
)
keymap('n', '\\c', '<Cmd>setlocal cursorline! cursorline?<CR>', { desc = "Toggle 'cursorline'" })
keymap('n', '\\C', '<Cmd>setlocal cursorcolumn! cursorcolumn?<CR>', { desc = "Toggle 'cursorcolumn'" })
keymap('n', '\\d', '<Cmd>lua print(require("utils").toggle_diagnostic())<CR>', { desc = 'Toggle diagnostic' })
keymap(
  'n',
  '\\h',
  '<Cmd>let v:hlsearch = 1 - v:hlsearch | echo (v:hlsearch ? "  " : "no") . "hlsearch"<CR>',
  { desc = 'Toggle search highlight' }
)
keymap(
  'n',
  '<leader>h',
  '<Cmd>let v:hlsearch = 1 - v:hlsearch | echo (v:hlsearch ? "  " : "no") . "hlsearch"<CR>',
  { desc = 'Toggle search highlight' }
)
keymap('n', '\\i', '<Cmd>setlocal ignorecase! ignorecase?<CR>', { desc = "Toggle 'ignorecase'" })
keymap('n', '\\l', '<Cmd>setlocal list! list?<CR>', { desc = "Toggle 'list'" })
keymap('n', '\\n', '<Cmd>setlocal number! number?<CR>', { desc = "Toggle 'number'" })
keymap('n', '\\r', '<Cmd>setlocal relativenumber! relativenumber?<CR>', { desc = "Toggle 'relativenumber'" })
keymap('n', '\\s', '<Cmd>setlocal spell! spell?<CR>', { desc = "Toggle 'spell'" })
keymap('n', '\\w', '<Cmd>setlocal wrap! wrap?<CR>', { desc = "Toggle 'wrap'" })

-- emacs keybinding
keymap('i', '<M-f>', '<C-right>')
keymap('i', '<M-b>', '<C-left>')

-- confirm quit neovim
-- keymap('n', '<leader>q', ':confirm quit<cr>')

-- quickly input command && I don't use c-f
keymap({ 'n', 'v' }, '<Right>', ':')
-- make the ring finger comfortable
keymap('c', '<C-l>', '<cr>')

-- better n N J <C-d> <C-u>
keymap('n', 'J', 'mzJ`z')
keymap('n', 'n', 'nzzzv')
keymap('n', 'N', 'Nzzzv')
keymap('n', '<C-d>', '<C-d>zz')
keymap('n', '<C-u>', '<C-u>zz')

-- all content
keymap('n', 'vae', 'ggVG')
keymap('n', 'yae', 'ggVGy')
keymap('n', 'dae', 'ggVGd')
keymap('n', 'cae', 'ggVGc')

-- resize window
keymap('n', '<A-[>', '<cmd>vertical resize-5<cr>')
keymap('n', '<A-]>', '<cmd>vertical resize+5<cr>')
keymap('n', '<A-,>', '<cmd>resize-5<cr>')
keymap('n', '<A-.>', '<cmd>resize+5<cr>')

-- buffer
keymap('n', '<leader>bs', '<cmd>buffers<cr>')
keymap('n', '<leader>bk', '<cmd>bdelete<cr>')
keymap('n', '<leader><Tab>', '<cmd>e #<cr>')
keymap({ 'n', 'i', 'v' }, '<F19>', '<cmd>e #<cr>')

-- quicklist
keymap('n', '<leader>oq', '<cmd>copen<cr>')

-- move Lines
keymap('n', '<A-j>', ':m .+1<CR>==', { silent = true })
keymap('v', '<A-j>', ":m '>+1<CR>gv=gv", { silent = true })
keymap('i', '<A-j>', '<esc>:m .+1<CR>==gi', { silent = true })
keymap('n', '<A-k>', ':m .-2<CR>==', { silent = true })
keymap('v', '<A-k>', ":m '<-2<CR>gv=gv", { silent = true })
keymap('i', '<A-k>', '<esc>:m .-2<CR>==gi', { silent = true })

-- enhance jk
keymap({ 'n', 'v' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
keymap({ 'n', 'v' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- prevents the clipboard from being replaced by copied content
keymap('x', 'p', '"_dP')

-- add undo break-points
keymap('i', ',', ',<c-g>u')
keymap('i', '.', '.<c-g>u')
keymap('i', ';', ';<c-g>u')

-- fast save
keymap({ 'n', 'i', 'v' }, '<C-s>', '<cmd>write<cr>')

-- better indenting
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

-- remove highlight
-- keymap('n', '<leader>h', '<cmd>nohl<cr>')

-- I hide click this key
keymap('n', 'H', '^')
keymap('n', 'L', '$')
keymap('x', 'H', '^')
keymap('x', 'L', '$')
keymap('o', 'H', '^')
keymap('o', 'L', '$')

-- adapts the autohotkey key change
keymap('n', '<Home>', '<C-a>')
keymap('n', '<end>', '<C-e>')
keymap('x', 'g<Home>', 'g<C-a>')

-- alpha
keymap('n', '<leader>;', '<cmd>Alpha<cr>')

-- telescope
keymap('n', '<leader>bb', '<cmd>Telescope buffers<cr>')
keymap({ 'n', 'i', 'v' }, '<C-p>', "<cmd>lua require('config.fancy_telescope').find_project_files()<cr>")
keymap('n', '<Left>', '<cmd>Telescope buffers<cr>')
keymap('n', '<leader>fd', "<cmd>lua require('config.fancy_telescope').find_dotfile()<cr>")
keymap('n', '<leader>fb', '<cmd>Telescope<cr>')
keymap('n', '<leader>fc', '<cmd>Telescope commands<cr>')
keymap('n', '<leader>fg', '<cmd>Telescope resume<cr>')
keymap('n', '<leader>ff', "<cmd>lua require('config.fancy_telescope').find_files()<cr>")
keymap('n', '<leader>sp', '<cmd>Telescope projects<cr>')
keymap('n', '<leader>ft', '<cmd>Telescope live_grep<cr>')
keymap('n', '<leader>st', "<cmd>lua require('config.fancy_telescope').grep_string_by_filetype()<cr>")
keymap('n', '<leader>fo', "<cmd>lua require('config.fancy_telescope').grep_string_open_files()<cr>")
keymap('n', '<leader>/', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
keymap('n', '<leader>fk', '<cmd>Telescope keymaps<cr>')
keymap('n', '<leader>fh', '<cmd>Telescope highlights<cr>')
keymap('n', '<leader>fr', '<cmd>Telescope oldfiles<cr>')
keymap('n', '<leader>gf', '<cmd>Telescope git_files<cr>')
keymap('n', '<leader>gs', "<cmd>lua require('config.fancy_telescope').git_status()<cr>")
keymap('n', '<leader>sh', '<cmd>Telescope help_tags<cr>')
keymap('n', '<leader>sc', '<cmd>Telescope colorscheme<cr>')
keymap('n', '<leader>sr', '<cmd>Telescope registers<cr>')
keymap('n', '<leader>sm', '<cmd>Telescope marks<cr>')
keymap('n', '<leader>s/', '<cmd>Telescope search_history<cr>')
keymap('n', '<leader>sq', '<cmd>Telescope quickfix<cr>')
keymap('n', '<leader>sj', '<cmd>Telescope jumplist<cr>')
keymap('v', '<leader>f', "<cmd>lua require('config.fancy_telescope').grep_string_visual()<cr>")
keymap('v', '<leader>t', "<cmd>lua require('config.fancy_telescope').grep_string_visual_by_filetype()<cr>")

-- fugitive
keymap('n', '<leader>gi', '<cmd>G init<cr>')
keymap('n', '<leader>ga', '<cmd>Gwrite<cr>')
keymap('n', '<leader>gd', '<cmd>Gvdiffsplit<cr>')
keymap('n', '<leader>gg', '<cmd>G<cr>')
-- vim commandmode git alias
vim.cmd([[cnoreabbrev <expr> git getcmdtype() == ':' && getcmdline() ==# 'git' ? 'Git' : 'git']])
vim.cmd([[cnoreabbrev <expr> gb getcmdtype() == ':' && getcmdline() ==# 'gb' ? 'Git branch' : 'gb']])
vim.cmd([[cnoreabbrev <expr> gba getcmdtype() == ':' && getcmdline() ==# 'gba' ? 'Git branch -a' : 'gba']])
vim.cmd([[cnoreabbrev <expr> gco getcmdtype() == ':' && getcmdline() ==# 'gco' ? 'Git checkout' : 'gco']])
vim.cmd([[cnoreabbrev <expr> ge getcmdtype() == ':' && getcmdline() ==# 'ge' ? 'Gedit' : 'ge']])
vim.cmd([[cnoreabbrev <expr> gr getcmdtype() == ':' && getcmdline() ==# 'gr' ? 'Gread' : 'gr']])

-- neo-tree
keymap('n', '<leader>ob', '<cmd>NeoTreeFocusToggle buffers<cr>')
keymap('n', '<leader>og', '<cmd>NeoTreeFocusToggle git_status<cr>')

-- lazy
keymap('n', '<leader>lz', '<cmd>Lazy<cr>')

-- gitsign
keymap('n', '[g', "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", { silent = true })
keymap('n', ']g', "<cmd>lua require 'gitsigns'.next_hunk()<cr>", { silent = true })
keymap({ 'n', 'v' }, '<leader>sH', ':Gitsigns stage_hunk<cr>', { silent = true })
keymap('n', '<leader>gk', "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", { silent = true })
keymap('n', '<leader>gj', "<cmd>lua require 'gitsigns'.next_hunk()<cr>", { silent = true })
keymap('n', '<leader>gp', "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", { silent = true })
keymap('n', '<leader>rh', "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", { silent = true })
keymap('n', '<leader>rb', "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", { silent = true })
-- Text object
keymap({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>', { silent = true })

-- toggleterm
keymap('n', '<A-h>', '<cmd>ToggleTerm size=10 direction=horizontal<cr>')
keymap('n', '<A-v>', '<cmd>ToggleTerm size=10 direction=vertical<cr>')
keymap('n', '<A-i>', '<cmd>ToggleTerm direction=float<cr>')

-- lazygit
keymap('n', '<leader>lg', "<cmd>lua require('config.fancy_toggleterm').lazygit_toggle()<cr>")
keymap('n', '<leader>gl', '<cmd>G log<cr>')
keymap('n', '<leader>gL', "<cmd>lua require('config.fancy_toggleterm').lazygit_log_toggle()<cr>")

-- lsp
keymap('n', 'gd', '<cmd>Telescope lsp_definitions<cr>')
keymap('n', 'gr', '<cmd>Telescope lsp_references<cr>')
keymap('n', '<leader>ls', '<cmd>Telescope lsp_document_symbols<cr>')
keymap('n', '<leader>lw', '<cmd>Telescope lsp_workspace_symbols<cr>')
keymap({ 'n', 'i', 'v' }, '<F20>', '<cmd>Telescope lsp_document_symbols<cr>')

-- harpoon
keymap('n', '<C-t>', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")
keymap('n', '<leader><leader>', "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>")
keymap('n', '<leader>a', "<cmd>lua require('harpoon.mark').add_file()<cr>")
keymap('n', '<leader>1', "<cmd>lua require('harpoon.ui').nav_file(1)<cr>")
keymap('n', '<leader>2', "<cmd>lua require('harpoon.ui').nav_file(2)<cr>")
keymap('n', '<leader>3', "<cmd>lua require('harpoon.ui').nav_file(3)<cr>")
keymap('n', '<leader>4', "<cmd>lua require('harpoon.ui').nav_file(4)<cr>")

-- treesitter
keymap('n', '<leader>ot', function()
  vim.treesitter.show_tree({ command = 'botright 60vnew' })
end, { desc = 'Open treesitter tree for current buffer' })

-- luasnip
keymap('s', '<BS>', '<C-o>s')

-- system operation
-- rename current file
keymap(
  'n',
  '<leader>rn',
  '<cmd>lua print(require("utils").rename_current_file())<CR>',
  { desc = 'Rename current file' }
)
-- chmod
vim.cmd([[cnoreabbrev <expr> chmod getcmdtype() == ':' && getcmdline() ==# 'chmod' ? 'Chmod' : 'chmod']])

-- wsl2 copy
if vim.fn.has('wsl') == 1 then
  keymap({ 'n', 'v' }, '<leader>y', '"+y"')
  keymap({ 'n', 'v' }, '<leader>p', '"+p"')
end
