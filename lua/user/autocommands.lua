vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
    autocmd FileType startuptime nnoremap <silent> <buffer> q :q<cr>" },
    autocmd FileType null-ls-info nnoremap <silent> <buffer> q :q<cr>" },
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _run
    autocmd!
		autocmd TermOpen term://* nnoremap <silent> <buffer> q :bdelete!<cr> 
    autocmd FileType floaterm nnoremap <silent> <buffer> q :q<cr>" },

  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown nnoremap j gj
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd = 
  augroup end

 augroup _alpha
   autocmd!
   autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
 augroup end
]])

-- autocmd FileType markdown setlocal spell (markdown)

-- Use relative & absolute line numbers in 'n' & 'i' modes respectively
if builtin.smartNumber.active then
	vim.cmd([[ au InsertEnter * set norelativenumber ]])
	vim.cmd([[ au InsertLeave * set relativenumber ]])
end

-- set header comment
vim.cmd([[
" Add header comment for python file automatically.
autocmd BufNewFile *.sh,*.py exec ":call SetTitle()"
func SetTitle()
if expand("%:e") == 'py'
   call setline(1,'"""')
   call setline(2,"# Author:         Leiyi548                        ")
   call setline(3,"# Date:           ".strftime("%Y/%m/%d %H:%M ")."                      ")
   call setline(4,'"""')
   normal G
   normal o
   normal o
endif
endfunc
]])

-- indent for different filetype
vim.cmd([[
  autocmd FileType php,ruby,yaml setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
  autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 
  autocmd FileType php setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
  autocmd FileType coffee,javascript setlocal tabstop=2 shiftwidth=2 softtabstop=2 textwidth=120
  autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 textwidth=120
  autocmd FileType org setlocal nofoldenable
  autocmd FileType TelescopePrompt set nonumber
  autocmd FileType TelescopePrompt set norelativenumber
]])
-- autocmd FileType html,htmldjango,xhtml,haml setlocal tabstop=2 shiftwidth=2 softtabst
