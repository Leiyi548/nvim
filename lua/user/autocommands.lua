vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
    autocmd BufWinEnter * :set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _run
    autocmd!
    autocmd TermOpen terminal nnoremap <silent> <buffer> q :bdelete!<cr>
    autocmd FileType floaterm nnoremap <silent> <buffer> q :q<cr>" },

  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
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

-- Use relative & absolute line numbers in 'n' & 'i' modes respectively
if builtin.smartNumber.active then
	vim.cmd([[ au InsertEnter * set norelativenumber ]])
	vim.cmd([[ au InsertLeave * set relativenumber ]])
end

-- Autoformat
if builtin.format_on_save.active then
	vim.cmd([[
augroup _lsp
  autocmd!
  autocmd BufWritePre * lua vim.lsp.buf.formatting()
augroup end
]])
end
