-- author: Leiyi548 https://github.com/Leiyi548
-- date: 2022-09-13
-- License: MIT

local config = {}

function config.coc()
  vim.g.coc_global_extensions = {
    'coc-sumneko-lua',
    'coc-json',
    '@yaegassy/coc-marksman',
    'coc-html',
    'coc-css',
    'coc-emmet',
    'coc-snippets',
    'coc-translator',
  }
  vim.cmd([[
    inoremap <silent><expr> <TAB>
          \ coc#pum#visible() ? coc#_select_confirm() :
          \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
          \ CheckBackSpace() ? "\<TAB>" :
          \ coc#refresh()

    function! CheckBackSpace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    let g:coc_snippet_next = '<tab>'
    inoremap <expr> <C-n> coc#pum#visible() ? coc#pum#next(1) : "\<Down>"
    inoremap <expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<Up>"
    " Make <CR> to accept selected completion item or notify coc.nvim to format
    " <C-g>u breaks current undo, please make your own choice.
    inoremap <expr> <C-l> coc#pum#visible() ? coc#pum#confirm() : "\<Right>"
    " inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#confirm()
    inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                                  \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
    inoremap <silent><expr> <c-y> coc#refresh()
    " Use `[e` and `]e` to navigate diagnostics
    " Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
    nmap <silent> [e <Plug>(coc-diagnostic-prev)
    nmap <silent> ]e <Plug>(coc-diagnostic-next)
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

    " Symbol renaming.
    nmap <Space>rn <Plug>(coc-rename)

    " Applying codeAction to the selected region.
    " Example: `ga` for current paragraph
    xmap ga  <Plug>(coc-codeaction-selected)
    nmap ga  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current buffer.
    nmap ga  <Plug>(coc-codeaction)

    " Run the Code Lens action on the current line.
    nmap <Space>cl  <Plug>(coc-codelens-action)

    
    " Use <C-j> for select text for visual placeholder of snippet.
    vmap <C-j> <Plug>(coc-snippets-select)
    " Use <C-j> for jump to next placeholder, it's default of coc.nvim
    let g:coc_snippet_next = '<c-j>'
    " Use <C-k> for jump to previous placeholder, it's default of coc.nvim
    let g:coc_snippet_prev = '<c-k>'

    " Use <C-j> for both expand and jump (make expand higher priority.)
    imap <C-j> <Plug>(coc-snippets-expand-jump)

    " Use <leader>x for convert visual selected code to snippet
    xmap <Space>x  <Plug>(coc-convert-snippet)

    " coc translator
    nmap <C-e> <Plug>(coc-translator-p)
    vmap <C-e> <Plug>(coc-translator-pv)
  ]])
end

function config.neoformat()
  local g = vim.g

  g.neoformat_only_msg_on_error = 1
  g.neoformat_basic_format_align = 1
  g.neoformat_basic_format_retab = 1
  g.neoformat_basic_format_trim = 1
  -- lua
  g.neoformat_enable_lua = { 'stylua' }
  -- markdown
  g.neoformat_enable_markdown = { 'prettier' }
  vim.cmd([[
    augroup fmt
      autocmd!
      autocmd BufWritePre * undojoin | Neoformat
    augroup END
    ]])
end

return config
