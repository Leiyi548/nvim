-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local plugin = require('core.pack').register_plugin
local conf = require('modules.tools.config')

plugin({
  'nvim-telescope/telescope.nvim',
  config = conf.telescope,
  -- cmd = 'Telescope',
  requires = {
    { 'nvim-lua/popup.nvim' },
    { 'nvim-lua/plenary.nvim', opt = true },
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', opt = true },
    { 'nvim-telescope/telescope-ui-select.nvim', opt = true },
    { 'nvim-telescope/telescope-file-browser.nvim', opt = true, disable = true },
    { 'ahmedkhalf/project.nvim', config = conf.project, opt = true },
  },
})

plugin({
  'glepnir/mcc.nvim',
  ft = { 'c', 'cpp', 'go', 'rust', 'markdown' },
  config = conf.mcc,
  disable = true,
})

plugin({
  'Leiyi548/harpoon',
  requires = { 'nvim-lua/plenary.nvim', opt = true },
  config = conf.harpoon,
})

plugin({
  'h-hg/fcitx.nvim',
  event = 'InsertEnter',
  disable = vim.fn.has('wsl') == 1,
})

plugin({
  'nvim-colortils/colortils.nvim',
  cmd = 'Colortils',
  config = conf.colortils,
  disable = true,
})

plugin({
  'bkad/CamelCaseMotion',
  config = conf.CamelCaseMotion,
})

plugin({
  'lambdalisue/suda.vim',
  cmd = { 'SudaRead', 'SudaWrite' },
})

plugin({
  'rcarriga/nvim-notify',
  config = conf.notify,
  disable = false,
})

plugin({
  'xiyaowong/link-visitor.nvim',
  cmd = { 'VisitLinkInBuffer', 'VisitLinkUnderCursor' },
  config = conf.visitor,
})

plugin({
  'TimUntersberger/neogit',
  requires = {
    { 'nvim-lua/plenary.nvim', opt = true },
    {
      'sindrets/diffview.nvim',
      config = conf.diffview,
      cmd = 'DiffViewFileHistory',
    },
  },
  config = conf.neogit,
})

plugin({
  'folke/which-key.nvim',
  event = 'BufWinEnter',
  config = conf.whichkey,
})

plugin({
  'phaazon/hop.nvim',
  branch = 'v2', -- optional but strongly recommended
  event = 'BufRead',
  config = function()
    -- you can configure Hop the way you like here; see :h hop-config
    require('hop').setup({ keys = 'etovxqpdygfblzhckisuran' })
  end,
})

plugin({
  'akinsho/toggleterm.nvim',
  event = 'BufWinEnter',
  config = conf.toggleterm,
})

plugin({
  'numToStr/Comment.nvim',
  event = 'BufRead',
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
  event = { 'BufRead', 'BufNewFile' },
  config = conf.gitsigns,
})

plugin({
  'tpope/vim-surround',
  requires = {
    { 'tpope/vim-repeat' },
  },
  disable = false,
})

plugin({
  'kylechui/nvim-surround',
  config = conf.nvim_surround,
  disable = true,
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
  'Asheq/close-buffers.vim',
  event = 'BufEnter',
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
