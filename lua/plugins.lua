return {
  {
    'olimorris/onedarkpro.nvim',
    lazy = false,
    priority = 100,
    config = function()
      require('config.colorscheme')
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
    'nvim-treesitter/nvim-treesitter',
    event = 'BufRead',
    build = ':TSUpdate',
    dependencies = {
      -- 'nvim-treesitter/nvim-treesitter-textobjects',
      'p00f/nvim-ts-rainbow',
    },
    config = function()
      require('config.treesitter')
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
    'chentoast/marks.nvim',
    event = { 'BufRead' },
    config = function()
      require('config.marks')
    end,
    enabled = false,
  },
  {
    'tpope/vim-fugitive',
    cmd = { 'G', 'Git', 'Gedit', 'Gread', 'Gwrite', 'Gdiffsplit', 'Gvdiffsplit' },
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
    'rhysd/clever-f.vim',
    event = 'BufReadPre',
    config = function()
      require('config.clever_f')
    end,
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v2.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'kyazdani42/nvim-web-devicons',
      'MunifTanjim/nui.nvim',
    },
    keys = {
      { '<leader>e', '<cmd>NeoTreeFocusToggle<cr>', desc = 'NeotreeFocusToggle' },
      { '<F18>', '<cmd>NeoTreeFloatToggle<cr>', desc = 'NeotreeFloat' },
    },
    config = function()
      require('config.neo_tree')
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
    },
    config = function()
      require('config.telescope')
    end,
  },
}
