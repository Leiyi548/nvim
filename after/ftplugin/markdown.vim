" author: Leiyi548 https://github.com/Leiyi548
" date: 2023-02-01
" License: MIT

setlocal wrap
nmap j gj
nmap k gk

" textobj for markdown
" reference: https://github.com/coachshea/vim-textobj-markdown/blob/master/after/ftplugin/markdown/textobj-markdown.vim

" MarkdownCodeBlock
function! s:MarkdowCodeBlock(outside)
    call search('```', 'cb')
    if a:outside
        normal! 0Vo
    else
        normal! j0Vo
    endif
    call search('```')
    if ! a:outside
        normal! k
    endif
endfunction

onoremap <silent>am <cmd>call <sid>MarkdowCodeBlock(1)<cr>
xnoremap <silent>am <cmd>call <sid>MarkdowCodeBlock(1)<cr>

onoremap <silent>im <cmd>call <sid>MarkdowCodeBlock(0)<cr>
xnoremap <silent>im <cmd>call <sid>MarkdowCodeBlock(0)<cr>

function! s:toggle_checkbox()
    let [cur_line,cur_column] = getpos('.')[1:2]
    let line = getline('.')
    if line =~ glob2regpat('*- \[ \]*')
        call setline('.', substitute(line, '\[ \]', '[x]', ''))
    elseif line =~ glob2regpat('*- \[x\]*')
        call setline('.', substitute(line, '\[x\]', '[ ]', ''))
    endif
    call cursor(cur_line,cur_column)
endf

function! s:toggle_checkbox_range()
  let [lnum1,col1] = getpos("'<")[1:2]
  let [lnum2,col2] = getpos("'>")[1:2]
  let lines = getline(lnum1,lnum2)
  for line in lines
    if line =~ glob2regpat('*- \[ \]*')
        call setline(lnum1, substitute(line, '\[ \]', '[x]', ''))
    elseif line =~ glob2regpat('*- \[x\]*')
        call setline(lnum1, substitute(line, '\[x\]', '[ ]', ''))
    endif
    let lnum1 = lnum1 + 1
  endfor
endfunction

nnoremap <silent><buffer> <cr> :call <sid>toggle_checkbox()<cr>
vnoremap <silent><buffer> <cr> :call <sid>toggle_checkbox_range()<cr>
