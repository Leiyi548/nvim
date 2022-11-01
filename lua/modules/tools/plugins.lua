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
    { 'nvim-telescope/telescope-ui-select.nvim', disable = true },
    { 'nvim-telescope/telescope-file-browser.nvim', opt = true, disable = true },
    { 'ahmedkhalf/project.nvim', config = conf.project },
    { 'LukasPietzschmann/telescope-tabs', config = conf.tabs },
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
  requires = { 'nvim-lua/plenary.nvim' },
  config = conf.harpoon,
})

plugin({
  'h-hg/fcitx.nvim',
  event = 'InsertEnter',
  disable = not vim.fn.has('wsl'),
})

plugin({
  'Leiyi548/vim-im-select',
  event = 'InsertEnter',
  disable = vim.fn.has('wsl'),
})

plugin({
  'mg979/vim-visual-multi',
  config = conf.vim_visual_multi,
  disable = true,
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
  cmd = { 'Neogit' },
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
  'ggandor/leap.nvim',
  config = conf.leap,
})

plugin({
  'ggandor/leap-spooky.nvim',
  config = conf.leap_spooky,
})

plugin({
  'ggandor/flit.nvim',
  config = conf.flit,
})

plugin({
  'phaazon/hop.nvim',
  branch = 'v2', -- optional but strongly recommended
  cmd = {
    'HopWord',
    'HopWordMW',
    'HopWordAC',
    'HopWordBC',
    'HopLine',
    'HopChar1',
    'HopChar1MW',
    'HopChar1AC',
    'HopChar1BC',
    'HopChar2',
    'HopChar2MW',
    'HopChar2AC',
    'HopChar2BC',
    'HopPattern',
    'HopPatternAC',
    'HopPatternBC',
    'HopChar1CurrentLineAC',
    'HopChar1CurrentLineBC',
    'HopChar1CurrentLine',
  },
  config = function()
    -- you can configure Hop the way you like here; see :h hop-config
    require('hop').setup({ keys = 'etovxqpdygfblzhckisuran' })
  end,
  disable = true,
})

plugin({
  'akinsho/toggleterm.nvim',
  cmd = { 'ToggleTerm', 'TermExec' },
  event = { 'CmdwinEnter', 'CmdlineEnter' },
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
  event = { 'BufRead' },
  config = conf.gitsigns,
})

plugin({
  'tpope/vim-surround',
  keys = {
    { 'n', 'ds' },
    { 'n', 'cs' },
    { 'n', 'cS' },
    { 'n', 'yss' },
    { 'n', 'ygs' },
    { 'x', 'S' },
    { 'x', 'gS' },
  },
  requires = {
    { 'tpope/vim-repeat', after = 'vim-surround' },
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
  'tibabit/vim-templates',
  config = conf.vim_templates,
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
