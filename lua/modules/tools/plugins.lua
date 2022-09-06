-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local plugin = require('core.pack').register_plugin
local conf = require('modules.tools.config')

plugin({
  'nvim-telescope/telescope.nvim',
  config = conf.telescope,
  requires = {
    { 'nvim-lua/popup.nvim' },
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    { 'nvim-telescope/telescope-project.nvim' },
    { 'nvim-telescope/telescope-ui-select.nvim' },
  },
})

plugin({
  'h-hg/fcitx.nvim',
  event = 'InsertEnter',
})

plugin({
  'Leiyi548/harpoon',
  requires = 'nvim-lua/plenary.nvim',
  config = conf.harpoon,
})

plugin({
  'nvim-colortils/colortils.nvim',
  cmd = 'Colortils',
  config = conf.colortils,
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
})

plugin({
  'xiyaowong/link-visitor.nvim',
  event = 'BufWinEnter',
  config = conf.visitor,
})

plugin({
  'TimUntersberger/neogit',
  requires = {
    { 'nvim-lua/plenary.nvim' },
    {
      'sindrets/diffview.nvim',
      config = conf.diffview,
    },
  },
  config = conf.neogit,
})

plugin({
  'X3eRo0/dired.nvim',
  requires = 'MunifTanjim/nui.nvim',
  config = conf.dired,
  disable = true,
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
  config = conf.toggleterm,
})

plugin({
  'numToStr/Comment.nvim',
  event = 'BufRead',
  config = conf.Comment,
})

plugin({
  -- wait for folke back
  -- 'folke/todo-comments.nvim',
  'B4mbus/todo-comments.nvim',
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
