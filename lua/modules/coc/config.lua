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
    'coc-tsserver',
  }
  -- Use <C-j> for jump to next placeholder, it's default of coc.nvim
  vim.g.coc_snippet_next = '<C-j>'
  -- Use <C-k> for jump to previous placeholder, it's default of coc.nvim
  vim.g.coc_snippet_prev = '<C-k>'
  vim.cmd([[
    inoremap <silent><expr> <TAB>
          \ coc#pum#visible() ? coc#_select_confirm() :
          \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
          \ CheckBackSpace() ? "\<TAB>" :
          \ coc#refresh()

    " To make <cr> select the first completion item and confirm the completion when no item has been selected:
    inoremap <silent><expr> <cr> coc#pum#visible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

    function! CheckBackSpace() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~# '\s'
    endfunction

    let g:coc_snippet_next = '<tab>'
    inoremap <expr> <C-n> coc#pum#visible() ? coc#pum#next(1) : "\<Down>"
    inoremap <expr> <C-p> coc#pum#visible() ? coc#pum#prev(1) : "\<Up>"
    inoremap <expr> <C-l> coc#pum#visible() ? coc#pum#confirm() : coc#refresh()

    


    nmap <silent> [e <Plug>(coc-diagnostic-prev)
    nmap <silent> ]e <Plug>(coc-diagnostic-next)
    nmap <silent> gl <Plug>(coc-diagnostic-next)
    nmap <silent> gd :Telescope coc definitions<cr>
    nmap <silent> gy :Telescope coc type_definations<cr>
    nmap <silent> gI :Telescope coc implementations<cr>
    nmap <silent> gr :Telescope coc references<cr>
    " nnoremap <silent> K :call ShowDocumentation()<cr>
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

    " Use <C-j> for both expand and jump (make expand higher priority.)
    imap <C-j> <Plug>(coc-snippets-expand-jump)

    " Use <leader>x for convert visual selected code to snippet
    xmap <Space>x  <Plug>(coc-convert-snippet)

    " coc translator
    nmap <C-e> <Plug>(coc-translator-p)
    xmap <C-e> <Plug>(coc-translator-pv)
  ]])
end

function config.neoformat()
  local g = vim.g

  g.neoformat_only_msg_on_error = 1
  g.neoformat_basic_format_align = 1
  g.neoformat_basic_format_retab = 1
  g.neoformat_basic_format_trim = 1
  -- filetype
  g.neoformat_enable_lua = { 'stylua' }
  g.neoformat_enable_markdown = { 'prettier' }
  g.neoformat_enable_vue = { 'prettier' }
  vim.cmd([[
    augroup fmt
      autocmd!
      autocmd BufWritePre * Neoformat
    augroup END
    ]])
end

function config.autopairs()
  local auto_pairs_ok, npairs = pcall(require, 'nvim-autopairs')
  if not auto_pairs_ok then
    return
  end

  npairs.setup({
    check_ts = true,
    enable_check_bracket_line = true,
    ts_config = {
      lua = { 'string', 'source' },
      javascript = { 'string', 'template_string' },
      java = false,
    },
    disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
    fast_wrap = {
      map = '<M-e>',
      chars = { '{', '[', '(', '"', "'" },
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
      offset = 0, -- Offset from pattern match
      end_key = '$',
      keys = 'qwertyuiopzxcvbnmasdfghjkl',
      check_comma = false,
      highlight = 'PmenuSel',
      highlight_grey = 'LineNr',
    },
  })
end

function config.ufo()
  vim.o.foldcolumn = '1'
  vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
  vim.o.foldlevelstart = 99
  vim.o.foldenable = true
  local ftMap = {
    vim = 'indent',
    python = { 'indent' },
    git = '',
  }
  local handler = function(virtText, lnum, endLnum, width, truncate)
    local newVirtText = {}
    local suffix = ('  %d '):format(endLnum - lnum)
    local sufWidth = vim.fn.strdisplaywidth(suffix)
    local targetWidth = width - sufWidth
    local curWidth = 0
    for _, chunk in ipairs(virtText) do
      local chunkText = chunk[1]
      local chunkWidth = vim.fn.strdisplaywidth(chunkText)
      if targetWidth > curWidth + chunkWidth then
        table.insert(newVirtText, chunk)
      else
        chunkText = truncate(chunkText, targetWidth - curWidth)
        local hlGroup = chunk[2]
        table.insert(newVirtText, { chunkText, hlGroup })
        chunkWidth = vim.fn.strdisplaywidth(chunkText)
        -- str width returned from truncate() may less than 2nd argument, need padding
        if curWidth + chunkWidth < targetWidth then
          suffix = suffix .. (' '):rep(targetWidth - curWidth - chunkWidth)
        end
        break
      end
      curWidth = curWidth + chunkWidth
    end
    table.insert(newVirtText, { suffix, 'MoreMsg' })
    return newVirtText
  end
  require('ufo').setup({
    fold_virt_text_handler = handler,
    close_fold_kinds = { 'imports', 'comment' },
    preview = {
      win_config = {
        border = { '', '─', '', '', '', '─', '', '' },
        winhighlight = 'Normal:Folded',
        winblend = 0,
      },
      mappings = {
        scrollU = '<C-u>',
        scrollD = '<C-d>',
      },
    },
    provider_selector = function(bufnr, filetype, buftype)
      -- if you prefer treesitter provider rather than lsp,
      -- return ftMap[filetype] or {'treesitter', 'indent'}
      return ftMap[filetype]

      -- refer to ./doc/example.lua for detail
    end,
  })
  vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
  vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
  vim.keymap.set('n', 'zr', require('ufo').openFoldsExceptKinds)
  vim.keymap.set('n', 'zm', require('ufo').closeFoldsWith) -- closeAllFolds == closeFoldsWith(0)
  vim.keymap.set('n', 'K', function()
    local winid = require('ufo').peekFoldedLinesUnderCursor()
    if not winid then
      -- choose one of them
      -- coc.nvim
      vim.fn.CocActionAsync('definitionHover')
    end
  end)
  -- buffer scope handler
  -- will override global handler if it is existed
  local bufnr = vim.api.nvim_get_current_buf()
  require('ufo').setFoldVirtTextHandler(bufnr, handler)
end

return config
