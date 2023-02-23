return {
  {
    'olimorris/onedarkpro.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      require('config.colorscheme').onedarkpro()
    end,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    lazy = false,
    priority = 1000,
    config = function()
      require('config.colorscheme').rose_pine()
    end,
  },
  {
    'projekt0n/github-nvim-theme',
    lazy = false,
    priority = 1000,
    config = function()
      require('config.colorscheme').github_nvim_theme()
    end,
  },
  {
    'Leiyi548/alpha-nvim',
    branch = 'startify_center',
    event = 'BufWinEnter',
    config = function()
      require('config.alpha').startify()
    end,
  },
  {
    'Leiyi548/vim-im-select',
    event = 'InsertEnter',
    enabled = vim.fn.has('wsl'),
  },
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufRead',
    build = ':TSUpdate',
    dependencies = {
      -- 'nvim-treesitter/nvim-treesitter-textobjects',
      'mrjones2014/nvim-ts-rainbow',
      'nvim-treesitter-context',
    },
    config = function()
      require('config.treesitter')
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    config = function()
      require('config.treesitter_context')
    end,
  },
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    config = function()
      require('config.noice')
    end,
    enabled = false,
  },
  {
    'ethanholz/nvim-lastplace',
    lazy = false,
    priority = 100,
    config = function()
      require('config.lastplace')
    end,
  },
  {
    'akinsho/nvim-bufferline.lua',
    event = 'BufReadPre',
    config = function()
      require('config.bufferline')
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    config = function()
      require('config.lualine')
    end,
  },
  {
    'NvChad/nvim-colorizer.lua',
    event = 'BufRead',
    config = function()
      require('config.nvim_colorizer')
    end,
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufRead' },
    config = function()
      require('config.gitsigns')
    end,
  },
  {
    'hotoo/pangu.vim',
    event = { 'BufReadPre' },
  },
  {
    'kevinhwang91/nvim-hlslens',
    keys = {
      { 'n', mode = 'n' },
      { 'n', mode = 'x' },
      { 'N', mode = 'n' },
      { 'N', mode = 'x' },
      { '/', mode = 'n' },
      { '?', mode = 'n' },
      { '*', mode = 'n' },
      { '#', mode = 'n' },
      { '#', mode = 'x' },
      { 'g*', mode = 'n' },
      { 'g*', mode = 'x' },
      { 'g#', mode = 'n' },
      { 'g#', mode = 'x' },
    },
    config = function()
      require('config.nvim_hlsens')
    end,
  },
  {
    'chentoast/marks.nvim',
    event = { 'BufRead' },
    config = function()
      require('config.marks')
    end,
    enabled = false,
  },
  {
    'sindrets/diffview.nvim',
    dependencies = 'nvim-lua/plenary.nvim',
    cmd = { 'DiffviewOpen', 'DiffviewClose', 'DiffviewFocusFile', 'DiffviewRefresh', 'DiffviewFileHistory' },
    config = function()
      require('config.diffview')
    end,
  },
  {
    'tpope/vim-fugitive',
    cmd = { 'G', 'Git', 'Gedit', 'Gread', 'Gwrite', 'Gdiffsplit', 'Gvdiffsplit' },
  },
  {
    'tpope/vim-eunuch',
    cmd = {
      'Remove',
      'Delete',
      'Move',
      'Rename',
      'Chmod',
      'Mkdir',
      'Cfind',
      'Clocate',
      'Lfind',
      'Wall',
      'SudoWrite',
      'SudoEdit',
    },
  },
  -- nvim lsp
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    keys = { { '<leader>li', '<cmd>Mason<cr>', desc = 'Mason [lsp install]' } },
    config = function()
      require('config.mason')
    end,
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('config.mason_lspconfig')
    end,
  },
  {
    'neovim/nvim-lspconfig',
    event = 'BufReadPre',
    dependencies = {
      {
        'folke/neodev.nvim',
        config = function()
          require('config.neodev')
        end,
      },
      'mason.nvim',
      'mason-lspconfig.nvim',
      'hrsh7th/cmp-nvim-lsp',
      {
        'glepnir/lspsaga.nvim',
        config = function()
          require('config.lspsaga')
        end,
      },
      {
        'j-hui/fidget.nvim',
        config = function()
          require('config.fidget')
        end,
      },
    },
    config = function()
      require('config.lspconfig')
    end,
  },
  {
    'hrsh7th/nvim-cmp',
    event = { 'InsertEnter', 'CmdlineEnter' },
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lsp-signature-help',
      'saadparwaiz1/cmp_luasnip',
      {
        'windwp/nvim-autopairs',
        config = function()
          require('config.nvim_autopairs')
        end,
      },
      'windwp/nvim-ts-autotag',
    },
    config = function()
      require('config.cmp')
    end,
  },
  {
    'L3MON4D3/LuaSnip',
    config = function()
      require('config.luasnip')
    end,
    keys = {
      {
        '<S-tab>',
        function()
          return require('luasnip').jumpable(-1) and '<Plug>luasnip-jump-prev' or '<S-tab>'
        end,
        expr = true,
        silent = true,
        mode = { 'i', 's' },
      },
      {
        '<C-j>',
        function()
          return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<esc>o'
        end,
        expr = true,
        silent = true,
        mode = { 'i', 's' },
      },
      {
        '<C-k>',
        function()
          return require('luasnip').jumpable(-1) and '<Plug>luasnip-jump-prev' or '<esc>lDa'
        end,
        expr = true,
        silent = true,
        mode = { 'i', 's' },
      },
      {
        '<C-l>',
        function()
          return require('luasnip').choice_active() and '<Plug>luasnip-next-choice' or '<tab>'
        end,
        expr = true,
        silent = true,
        mode = { 'i', 's' },
      },
    },
    dependencies = {
      'Leiyi548/friendly-snippets',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end,
    },
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    event = 'BufReadPre',
    dependencies = { 'mason.nvim' },
    config = function()
      require('config.null_ls')
    end,
  },
  {
    'numToStr/Comment.nvim',
    keys = {
      { 'gc', mode = { 'n', 'x' } },
      { 'gcc', mode = 'n' },
      { 'gcb', mode = 'n' },
      { 'gb', mode = 'x' },
    },
    config = function()
      require('config.comment')
    end,
  },
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufRead',
    config = function()
      require('config.indent_blankline')
    end,
  },
  {
    'Leiyi548/harpoon',
  },
  {
    'Leiyi548/vim-surround',
    keys = {
      { 'ds', mode = 'n' },
      { 'cs', mode = 'n' },
      { 'cS', mode = 'n' },
      { 'yss', mode = 'n' },
      { 'ysiw', mode = 'n' },
      { 'ysaw', mode = 'n' },
      { 'S', mode = 'x' },
    },
    dependencies = { 'tpope/vim-repeat' },
  },
  {
    'wellle/targets.vim',
    keys = {
      { 'dia', mode = 'n' },
      { 'dIa', mode = 'n' },
      { 'daa', mode = 'n' },
      { 'cia', mode = 'n' },
      { 'cIa', mode = 'n' },
      { 'caa', mode = 'n' },
      { 'viq', mode = 'n' },
      { 'diq', mode = 'n' },
      { 'ciq', mode = 'n' },
      { 'yiq', mode = 'n' },
    },
  },
  {
    'akinsho/toggleterm.nvim',
    cmd = 'ToggleTerm',
    keys = {
      { '<C-\\>', mode = { 'n', 'x' } },
    },
    config = function()
      require('config.toggleterm')
    end,
  },
  {
    'ggandor/leap.nvim',
    keys = {
      { 's', mode = 'n' },
      { 'gs', mode = 'n' },
      { 'S', mode = 'n' },
      { 's', mode = 'x' },
      { 'S', mode = 'x' },
    },
    config = function()
      require('config.leap')
    end,
  },
  {
    'chomosuke/term-edit.nvim',
    lazy = false,
    config = function()
      require('config.term_edit')
    end,
  },
  {
    'tommcdo/vim-exchange',
    lazy = false,
    keys = {
      { 'cx', mode = 'n' },
      { 'cxx', mode = 'n' },
      { 'X', mode = 'x' },
      { 'cxc', mode = 'n' },
    },
    enabled = false,
  },
  {
    'kevinhwang91/nvim-bqf',
    config = function()
      require('config.nvim_bqf')
    end,
    ft = 'qf',
    dependencies = {
      'junegunn/fzf',
      cmd = { 'FZF' },
      build = function()
        vim.fn['fzf#install']()
      end,
    },
  },
  {
    'ggandor/flit.nvim',
    keys = {
      { 'f', mode = 'n' },
      { 'F', mode = 'n' },
      { 't', mode = 'n' },
      { 'T', mode = 'n' },
      { 'f', mode = 'x' },
      { 'F', mode = 'x' },
      { 't', mode = 'x' },
      { 'T', mode = 'x' },
    },
    dependencies = { 'ggandor/leap.nvim' },
    config = function()
      require('config.flit')
    end,
    enabled = false,
  },
  {
    'anuvyklack/windows.nvim',
    dependencies = 'anuvyklack/middleclass',
    cmd = { 'WindowsMaximize', 'WindowsMaximizeVertically', 'WindowsMaximizeHorizontally', 'WindowsEqualize' },
    config = function()
      require('config.windows')
    end,
  },
  {
    'rhysd/clever-f.vim',
    event = 'BufReadPre',
    config = function()
      require('config.clever_f')
    end,
  },
  {
    'Shatur/neovim-session-manager',
    lazy = false,
    config = function()
      require('config.nvim_session_manager')
    end,
  },
  {
    'echasnovski/mini.bracketed',
    version = false,
    keys = {
      { '[b', mode = { 'n', 'x' } },
      { ']b', mode = { 'n', 'x' } },
      { '[c', mode = { 'n', 'x' } },
      { ']c', mode = { 'n', 'x' } },
      { '[d', mode = { 'n', 'x' } },
      { ']d', mode = { 'n', 'x' } },
      { '[o', mode = { 'n', 'x' } },
      { ']o', mode = { 'n', 'x' } },
      { '[i', mode = { 'n', 'x' } },
      { ']i', mode = { 'n', 'x' } },
      { '[j', mode = { 'n', 'x' } },
      { ']j', mode = { 'n', 'x' } },
      { '[l', mode = { 'n', 'x' } },
      { ']l', mode = { 'n', 'x' } },
      { '[q', mode = { 'n', 'x' } },
      { ']q', mode = { 'n', 'x' } },
      { '[t', mode = { 'n', 'x' } },
      { ']t', mode = { 'n', 'x' } },
      { '[u', mode = { 'n', 'x' } },
      { ']u', mode = { 'n', 'x' } },
      { '[w', mode = { 'n', 'x' } },
      { ']w', mode = { 'n', 'x' } },
      { '[y', mode = { 'n', 'x' } },
      { ']y', mode = { 'n', 'x' } },
    },
    config = function()
      require('config.mini_bracketed')
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    cmd = { 'NeoTreeFocusToggle', 'NeoTreeFloatToggle' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      -- { '<leader>e', '<cmd>NeoTreeFocusToggle<cr>', desc = 'NeotreeFocusToggle' },
      { '<leader>e', '<cmd>NeoTreeFloatToggle<cr>', desc = 'NeotreeFocusToggle' },
      { '<F18>', '<cmd>NeoTreeFloatToggle<cr>', desc = 'NeotreeFloat' },
    },
    config = function()
      require('config.neo_tree')
    end,
  },
  {
    'skywind3000/asynctasks.vim',
    cmd = { 'AsyncTask' },
    dependencies = {
      { 'skywind3000/asyncrun.vim', cmd = { 'AsyncRun' } },
      {
        'voldikss/vim-floaterm',
        cmd = {
          'FloatermNew',
          'FloatermPrev',
          'FloatermNext',
          'FloatermFirst',
          'FloatermLast',
          'FloatermLast',
          'FloatermToggle',
          'FloatermHidden',
          'FloatermKill',
          'FloatermSend',
        },
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
    \ '~/.config/nvim/tasks.ini',
    \ ]
        ]])
    end,
  },
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    keys = {
      {
        '<leader>fp',
        function()
          require('telescope.builtin').find_files({
            cwd = require('lazy.core.config').options.root,
          })
        end,
        desc = 'Find Plugin File',
      },
    },
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      {
        'ahmedkhalf/project.nvim',
        config = function()
          require('config.project')
        end,
      },
      { 'debugloop/telescope-undo.nvim' },
    },
    config = function()
      require('config.telescope')
    end,
  },
}
