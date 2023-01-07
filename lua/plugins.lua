return {
  { 'olimorris/onedarkpro.nvim', lazy = false, priority = 100, config = function() require('config.colorscheme') end },
  {
    'goolord/alpha-nvim',
    event = 'BufWinEnter',
    config = function() require('config.alpha') end
  },
  {
    'nvim-treesitter/nvim-treesitter',
    event = 'BufRead',
    build = ':Tsupdate',
    dependencies = {
      -- 'nvim-treesitter/nvim-treesitter-textobjects',
      'p00f/nvim-ts-rainbow',
    },
    config = function() require('config.treesitter') end
  },
  {
    'ethanholz/nvim-lastplace',
    lazy = false,
    priority = 100,
    config = function() require('config.lastplace') end
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    config = function() require('config.lualine') end
  },
  {
    'NvChad/nvim-colorizer.lua',
    event = 'BufRead',
    config = function() require('config.nvim_colorizer') end
  },
  {
    'lewis6991/gitsigns.nvim',
    event = { 'BufRead' },
    config = function() require('config.gitsigns') end
  },
  {
    'kevinhwang91/nvim-hlslens',
    keys = {
      { "n", mode = "n" },
      { "n", mode = "x" },
      { "N", mode = "n" },
      { "N", mode = "x" },
      { "/", mode = "n" },
      { "?", mode = "n" },
      { "*", mode = "n" },
      { "#", mode = "n" },
      { "#", mode = "x" },
      { "g*", mode = "n" },
      { "g*", mode = "x" },
      { "g#", mode = "n" },
      { "g#", mode = "x" },
    },
    config = function() require('config.nvim_hlsens') end
  },
  {
    'chentoast/marks.nvim',
    event = { 'BufRead' },
    config = function() require('config.marks') end
  },
  {
    'tpope/vim-fugitive',
    cmd = { 'G', 'Git', 'Gedit', 'Gread', 'Gwrite', 'Gdiffsplit', 'Gvdiffsplit' }
  },
  {
    'neoclide/coc.nvim',
    branch = 'release',
    lazy = false,
    dependencies = {
      { 'Leiyi548/friendly-snippets' }
    },
    config = function() require('config.coc') end
  },
  {
    'numToStr/Comment.nvim',
    keys = {
      { "gc", mode = "n" },
      { "gcc", mode = "n" },
      { "gcb", mode = "n" },
      { "gc", mode = "x" },
      { "gb", mode = "x" },
    },
    config = function() require('config.comment') end
  },
  {
    'jiangmiao/auto-pairs',
    event = "InsertEnter",
  },
  {
    'yaocccc/nvim-hlchunk',
    event = "BufRead",
    config = function() require('config.nvim_hlchunk') end
  },
  {
    'Leiyi548/vim-surround',
    keys = {
      { "ds", mode = "n" },
      { "cs", mode = "n" },
      { "cS", mode = "n" },
      { "yss", mode = "n" },
      { "ysiw", mode = "n" },
      { "ysaw", mode = "n" },
      { "S", mode = "x" }
    },
  },
  {
    'wellle/targets.vim',
    keys = {
      { "dia", mode = "n" },
      { "dIa", mode = "n" },
      { "daa", mode = "n" },
      { "cia", mode = "n" },
      { "cIa", mode = "n" },
      { "caa", mode = "n" },
      { "ciq", mode = "n" },
    }
  },
  {
    'akinsho/toggleterm.nvim',
    cmd = "ToggleTerm",
    keys = {
      { "<C-\\>", mode = "n" },
      { "<C-\\>", mode = "x" },
    },
    config = function() require('config.toggleterm') end
  },
  {
    'ggandor/leap.nvim',
    keys = {
      { "s", mode = "n" },
      { "gs", mode = "n" },
      { "S", mode = "n" },
      { "s", mode = "x" },
      { "S", mode = "x" }
    },
    config = function() require('config.leap') end
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
      { "<leader>e", "<cmd>NeoTreeFocusToggle<cr>", desc = "NeotreeFocusToggle" },
      { "<F6>", "<cmd>NeoTreeFloatToggle<cr>", desc = "NeotreeFloat" },
    },
    config = function() require('config.neo_tree') end
  },
  {
    'nvim-telescope/telescope.nvim',
    cmd = "Telescope",
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({
            cwd = require("lazy.core.config").options.root,
          })
        end,
        desc = "Find Plugin File",
      },
    },
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
      { 'ahmedkhalf/project.nvim', config = function() require('config.project') end },
      { 'fannheyward/telescope-coc.nvim' }
    },
    config = function()
      require('config.telescope')
    end
  }
}
