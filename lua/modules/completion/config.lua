-- author: Leiyi548 https://github.com/Leiyi548
-- date: 2022-09-13
-- License: MIT

local config = {}

function config.coc()
  vim.cmd([[
    let g:coc_global_extensions = [ 'coc-sumneko-lua', 'coc-json', '@yaegassy/coc-marksman', 'coc-html', 'coc-css','coc-emmet','coc-snippets']
    " use <tab> for trigger completion and navigate to the next complete item
    function! CheckBackspace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

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
    " nmap <Space>rn <Plug>(coc-rename)

    " Formatting selected code.
    xmap <Space>F  <Plug>(coc-format-selected)
    nmap <Space>F  <Plug>(coc-format-selected)
    augroup mygroup
      autocmd!
      " Setup formatexpr specified filetype(s).
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      " Update signature help on jump placeholder.
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
    augroup end

    " Applying codeAction to the selected region.
    " Example: `ga` for current paragraph
    xmap ga  <Plug>(coc-codeaction-selected)
    nmap ga  <Plug>(coc-codeaction-selected)

    " Remap keys for applying codeAction to the current buffer.
    nmap ga  <Plug>(coc-codeaction)

    " Run the Code Lens action on the current line.
    nmap <leader>cl  <Plug>(coc-codelens-action)
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
