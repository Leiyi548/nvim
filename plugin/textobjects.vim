xnoremap <silent> il :<c-u>normal! g_v^<cr>
onoremap <silent> il :<c-u>normal! g_v^<cr>

" "around line" (entire line sans trailing newline; cursor at beginning--ie, 0)
xnoremap <silent> al :<c-u>normal! $v0<cr>
onoremap <silent> al :<c-u>normal! $v0<cr>

" code
" call textobj#user#plugin('single quotes', {
" \   'angle': {
" \     'pattern': ['`', '`'],
" \     'select-a': 'aA',
" \     'select-i': 'iA',
" \   },
" \ })
