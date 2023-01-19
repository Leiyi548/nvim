local cmd = vim.cmd
local fn = vim.fn
local api = vim.api

vim.g.coc_global_extensions = {
  'coc-sumneko-lua',
  'coc-json',
  'coc-go',
  'coc-rust-analyzer',
  'coc-html',
  'coc-css',
  'coc-emmet',
  'coc-snippets',
  'coc-translator',
  'coc-tsserver',
}

-- vim.g.coc_snippet_next = '<C-j>'
-- vim.g.coc_snippet_prev = '<C-k>'
vim.cmd([[
  inoremap <silent><expr> <TAB>
        \ coc#pum#visible() ? coc#_select_confirm() :
        \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
        \ CheckBackSpace() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <silent><expr> <S-TAB>
        \ pumvisible() ? "\<C-p>" :
        \ coc#jumpable() ? "\<C-r>=coc#rpc#request('snippetPrev',[])\<CR>" :
        \ "\<C-h>"
  inoremap <silent><expr> <C-j>
        \ coc#jumpable() ? "\<C-r>=coc#rpc#request('snippetNext',[])\<CR>" :
        \ "<C-o>o"
  inoremap <silent><expr> <C-k>
        \ coc#jumpable() ? "\<C-r>=coc#rpc#request('snippetPrev',[])\<CR>" :
        \ "<C-o>D"
  " To make <cr> select the first completion item and confirm the completion when no item has been selected:
  inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"
  function! CheckBackSpace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction
  let g:coc_snippet_next = '<tab>'
  inoremap <expr> <C-l> coc#pum#visible() ? coc#pum#confirm() : coc#refresh()

  " Map function and class text objects
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server
  xmap if <Plug>(coc-funcobj-i)
  omap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap af <Plug>(coc-funcobj-a)
  xmap ic <Plug>(coc-classobj-i)
  omap ic <Plug>(coc-classobj-i)
  xmap ac <Plug>(coc-classobj-a)
  omap ac <Plug>(coc-classobj-a)

  nmap <silent> <leader>lr <Plug>(coc-rename)
  nmap <silent> [d <Plug>(coc-diagnostic-prev)
  nmap <silent> ]d <Plug>(coc-diagnostic-next)
  nmap <silent> = <Plug>(coc-format-selected)
  xmap <silent> = <Plug>(coc-format-selected)
  nmap <silent> gl <Plug>(coc-diagnostic-next)
  nmap <silent> gd :Telescope coc definitions<cr>
  nmap <silent> gy :Telescope coc type_definations<cr>
  nmap <silent> gI :Telescope coc implementations<cr>
  nmap <silent> gr :Telescope coc references<cr>
  nnoremap <silent> K :call ShowDocumentation()<cr>
  function! ShowDocumentation()
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction
  " Highlight the symbol and its references when holding the cursor.
  autocmd CursorHold * silent call CocActionAsync('highlight')
  augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end
  xmap <silent> ga  <Plug>(coc-codeaction-selected)
  nmap <silent> ga  <Plug>(coc-codeaction-selected)
  " Remap keys for applying codeAction to the current buffer.
  nmap ga  <Plug>(coc-codeaction)
  " Run the Code Lens action on the current line.
  nmap <Space>cl  <Plug>(coc-codelens-action)
  " coc translator
  nmap \\ <Plug>(coc-translator-p)
  xmap \\ <Plug>(coc-translator-pv)
]])
vim.g.coc_enable_locationlist = 0
