-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local plugin = require('core.pack').register_plugin
local conf = require('modules.tools.config')

plugin({
  'nvim-telescope/telescope.nvim',
  config = conf.telescope,
  requires = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    { 'ahmedkhalf/project.nvim', config = conf.project },
    { 'nvim-telescope/telescope-ui-select.nvim' },
  },
})

plugin({
  'jghauser/mkdir.nvim',
})

plugin({
  'gelguy/wilder.nvim',
  config = conf.wilder,
  event = 'CmdlineEnter',
})

plugin({
  'chentoast/marks.nvim',
  config = conf.marks,
  event = 'BufRead',
})

plugin({
  'kevinhwang91/nvim-hlslens',
  config = conf.hlslens,
  keys = {
    { 'n', 'n' },
    { 'x', 'n' },
    { 'o', 'n' },
    { 'n', 'N' },
    { 'x', 'N' },
    { 'o', 'N' },
    { 'n', '/' },
    { 'n', '?' },
    { 'n', '*' },
    { 'x', '*' },
    { 'n', '#' },
    { 'x', '#' },
    { 'n', 'g*' },
    { 'x', 'g*' },
    { 'n', 'g#' },
    { 'x', 'g#' },
  },
})

plugin({
  'kevinhwang91/nvim-bqf',
  config = conf.bqf,
  ft = 'qf',
  requires = {
    'junegunn/fzf',
    run = function()
      vim.fn['fzf#install']()
    end,
  },
})

plugin({
  'Leiyi548/harpoon',
  requires = 'nvim-lua/plenary.nvim',
  config = conf.harpoon,
})

plugin({
  'h-hg/fcitx.nvim',
  event = 'InsertEnter',
  disable = vim.fn.has('wsl'),
})

plugin({
  'Leiyi548/vim-im-select',
  event = 'InsertEnter',
  disable = not vim.fn.has('wsl'),
})

plugin({
  'bkad/CamelCaseMotion',
  config = conf.CamelCaseMotion,
})

plugin({
  'lambdalisue/suda.vim',
})

plugin({
  'rcarriga/nvim-notify',
  config = conf.notify,
  disable = true,
})

plugin({
  'xiyaowong/link-visitor.nvim',
  cmd = { 'VisitLinkInBuffer', 'VisitLinkUnderCursor' },
  config = conf.visitor,
})

plugin({
  'TimUntersberger/neogit',
  cmd = { 'Neogit' },
  requires = {
    { 'nvim-lua/plenary.nvim' },
    {
      'sindrets/diffview.nvim',
      config = conf.diffview,
      cmd = { 'DiffviewFileHistory', 'DiffviewLog', 'DiffviewOpen', 'DiffviewFocusFiles', 'DiffviewToggleFiles' },
    },
  },
  config = conf.neogit,
  disable = true,
})

plugin({
  'tpope/vim-fugitive',
})

plugin({
  'folke/which-key.nvim',
  event = 'BufWinEnter',
  config = conf.whichkey,
})

plugin({
  'easymotion/vim-easymotion',
  requires = 'zzhirong/vim-easymotion-zh',
  config = function()
    vim.cmd([[
      " Disable default mappings
      let g:EasyMotion_do_mapping = 0
      " Turn on case-insensitive feature
      let g:EasyMotion_smartcase = 1
      nnoremap s <Plug>(easymotion-bd-f2)
      nnoremap f <Plug>(easymotion-fl)
      nnoremap F <Plug>(easymotion-Fl)
      nnoremap t <Plug>(easymotion-tl)
      nnoremap T <Plug>(easymotion-Tl)
    ]])
  end,
  disable = true,
})

plugin({
  'akinsho/toggleterm.nvim',
  config = conf.toggleterm,
})

plugin({
  'numToStr/Comment.nvim',
  keys = {
    { 'n', 'gc' },
    { 'n', 'gcc' },
    { 'n', 'gcb' },
    { 'x', 'gc' },
    { 'x', 'gb' },
  },
  config = conf.Comment,
})

plugin({
  'LudoPinelli/comment-box.nvim',
  config = conf.comment_box,
  ft = 'markdown',
})

plugin({
  'folke/todo-comments.nvim',
  event = 'BufRead',
  config = conf.todo_comments,
})

plugin({
  'numToStr/Navigator.nvim',
  event = 'BufRead',
  config = function()
    require('Navigator').setup()
  end,
  disable = true,
})

plugin({
  'lewis6991/gitsigns.nvim',
  event = { 'BufRead' },
  config = conf.gitsigns,
})

plugin({
  'Leiyi548/vim-surround',
  requires = {
    { 'tpope/vim-repeat', keys = { '.' } },
  },
  keys = {
    { 'n', 'ds' },
    { 'n', 'cs' },
    { 'n', 'cS' },
    { 'n', 'yss' },
    { 'n', 'ysiw' },
    { 'n', 'ysaw' },
    { 'x', '(' },
    { 'x', ')' },
    { 'x', '{' },
    { 'x', '}' },
    { 'x', '"' },
    { 'x', "'" },
  },
})

plugin({
  'wellle/targets.vim',
})

plugin({
  'kana/vim-textobj-entire',
  requires = {
    { 'kana/vim-textobj-user' },
  },
})

plugin({
  'nvim-pack/nvim-spectre',
  config = conf.spectre,
})

plugin({
  'ethanholz/nvim-lastplace',
  config = conf.lastplace,
})

plugin({
  'Asheq/close-buffers.vim',
  cmd = { 'Bdelete hideen', 'Bdelete other' },
})

plugin({
  'skywind3000/asynctasks.vim',
  cmd = { 'AsyncTask' },
  requires = {
    { 'skywind3000/asyncrun.vim', cmd = { 'AsyncRun' } },
    {
      'voldikss/vim-floaterm',
      cmd = { 'FloatermNew' },
      config = function()
        vim.cmd([[hi FloatermNC guibg=gray]])
        vim.g.floaterm_width = 0.9
        vim.g.floaterm_wintype = 'float'
        vim.g.floaterm_height = 0.9
        vim.g.floaterm_title = ''
        vim.g.floaterm_borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' }
      end,
    },
  },
  config = function()
    vim.g.asynctasks_term_pos = 'bottom'
    vim.g.asynctasks_term_cols = 60
    vim.g.asynctasks_term_rows = 12
    vim.g.asyncrun_open = 6
    vim.cmd([[
        let g:asynctasks_extra_config = [
    \ '~/.config/nvim/static/tasks.ini',
    \ ]
        ]])
  end,
})
