-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local cache_dir = os.getenv('HOME') .. '/.cache/nvim/'

vim.opt.termguicolors = true
-- vim.opt.mouse = 'nv'
vim.opt.cursorline = true
vim.opt.mouse = 'a'
vim.opt.errorbells = true
vim.opt.visualbell = true
vim.opt.hidden = true
vim.opt.fileformats = 'unix,mac,dos'
vim.opt.magic = true
vim.opt.virtualedit = 'block'
vim.opt.encoding = 'utf-8'
vim.opt.viewoptions = 'folds,cursor,curdir,slash,unix'
vim.opt.sessionoptions = 'curdir,help,tabpages,winsize'
vim.opt.clipboard = 'unnamedplus'
vim.opt.wildignorecase = true
vim.opt.wildignore =
  '.git,.hg,.svn,*.pyc,*.o,*.out,*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store,**/node_modules/**,**/bower_modules/**'
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.directory = cache_dir .. 'swag/'
vim.opt.undodir = cache_dir .. 'undo/'
vim.opt.backupdir = cache_dir .. 'backup/'
vim.opt.viewdir = cache_dir .. 'view/'
vim.opt.spellfile = cache_dir .. 'spell/en.uft-8.add'
vim.opt.history = 2000
vim.opt.shada = "!,'300,<50,@100,s10,h"
vim.opt.backupskip = '/tmp/*,$TMPDIR/*,$TMP/*,$TEMP/*,*/shm/*,/private/var/*,.vault.vim'
vim.opt.smarttab = true
vim.opt.shiftround = true
vim.opt.timeout = true
vim.opt.ttimeout = true
vim.opt.timeoutlen = 288
vim.opt.ttimeoutlen = 10
vim.opt.updatetime = 100
vim.opt.redrawtime = 100
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.infercase = true
vim.opt.incsearch = true
vim.opt.wrapscan = true
vim.opt.complete = '.,w,b,k'
vim.opt.inccommand = 'split'
vim.opt.grepformat = '%f:%l:%c:%m'
vim.opt.grepprg = 'rg --hidden --vimgrep --smart-case --'
vim.opt.breakat = [[\ \	;:,!?]]
vim.opt.startofline = false
vim.opt.whichwrap = 'h,l,<,>,[,],~'
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.switchbuf = 'useopen'
vim.opt.backspace = 'indent,eol,start'
vim.opt.diffopt = 'filler,iwhite,internal,algorithm:patience'
vim.opt.completeopt = 'menu,menuone,noselect'
vim.opt.jumpoptions = 'stack'
vim.opt.showmode = false
vim.opt.shortmess = 'aoOTIcF'
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 5
vim.opt.foldlevelstart = 99
vim.opt.ruler = false
vim.opt.list = true
vim.opt.showtabline = 0
vim.opt.winwidth = 30
vim.opt.winminwidth = 10
vim.opt.pumheight = 15
vim.opt.helpheight = 12
vim.opt.previewheight = 12
vim.opt.showcmd = false
-- just for nightly
vim.opt.cmdheight = 1
-- vim.opt.cmdwinheight = 1
vim.opt.equalalways = false
vim.opt.laststatus = 3
vim.opt.display = 'lastline'
-- vim.opt.showbreak = '↳'
vim.opt.showbreak = ''
vim.opt.listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←'
vim.opt.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.opt.pumblend = 10
vim.opt.winblend = 0

vim.opt.undofile = true
vim.opt.synmaxcol = 2500
-- auto-wap comments,don't auto insert comment on o/O and enter
vim.opt.formatoptions = '1jcroql'
vim.opt.textwidth = 80
vim.opt.expandtab = true
vim.opt.autoindent = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = -1
vim.opt.breakindentopt = 'shift:2,min:20'
vim.opt.wrap = false
vim.opt.linebreak = true
vim.opt.number = true
vim.opt.relativenumber = true
-- vim.opt.colorcolumn = '80'
vim.opt.foldenable = true
vim.opt.signcolumn = 'yes'
vim.opt.background = 'dark'
-- vim.opt.conceallevel = 2
-- vim.opt.concealcursor = 'niv'

-- wsl yanking to windows clipboard from nvim
if vim.fn.has('wsl') == 1 then
  vim.opt.clipboard = ''
  vim.g.clipboard = {
    name = 'win32yank-wsl',
    copy = {
      ['+'] = 'win32yank.exe -i --crlf',
      ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
      ['+'] = 'win32yank.exe -o --lf',
      ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enable = 0,
  }
end
