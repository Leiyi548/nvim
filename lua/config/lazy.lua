local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    '--single-branch',
    -- "https://github.com/folke/lazy.nvim.git",
    'git@github.com:folke/lazy.nvim.git',
    lazypath,
  })
end
vim.opt.runtimepath:prepend(lazypath)

vim.g.mapleader = ' ' -- make sure to set `mapleader` before lazy so your mappings are correct
-- load lazy
require('lazy').setup('plugins', {
  defaults = { lazy = true },
  checker = { enabled = false },
  git = {
    -- defaults for the `Lazy log` command
    log = { '-10' }, -- show the last 10 commits
    -- log = { "--since=3 days ago" }, -- show commits from the last 3 days
    timeout = 120, -- kill processes that take more than 2 minutes
    -- github url download
    -- url_format = "https://github.com/%s.git",
    -- github ssh download
    url_format = 'git@github.com:%s.git',
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
  install = {
    -- install missing plugins on startup. This doesn't increase startup time.
    missing = true,
    -- try to load one of these colorschemes when starting an installation during startup
    colorscheme = { 'onedark_vivid' },
  },
  debug = false,
})
