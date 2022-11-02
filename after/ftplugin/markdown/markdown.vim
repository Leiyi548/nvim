setlocal wrap
setlocal shiftwidth=2
setlocal tabstop=2
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

"===
"=== markdown-vim
"===
let s:headersRegexp = '\v^(#|.+\n(\=+|-+)$)'
let s:levelRegexpDict = {
    \ 1: '\v^(#[^#]@=|.+\n\=+$)',
    \ 2: '\v^(##[^#]@=|.+\n-+$)',
    \ 3: '\v^###[^#]@=',
    \ 4: '\v^####[^#]@=',
    \ 5: '\v^#####[^#]@=',
    \ 6: '\v^######[^#]@='
\ }

" 返回最近匹配到标题的行数
function! s:GetHeaderLineNum(...)
    if a:0 == 0
        " 获得当前行的行数
        let l:l = line('.')
    else
        let l:l = a:1
    endif
    while(l:l > 0)
        " 如果匹配到markdown的标题就返回当前行号
        if join(getline(l:l, l:l + 1), "\n") =~ s:headersRegexp
            return l:l
        endif
        " 就让行数减一往上查找
        let l:l -= 1
    endwhile
    return 0
endfunction
  
function! s:MoveToCurHeader()
    let l:lineNum = s:GetHeaderLineNum()
    if l:lineNum !=# 0
        call cursor(l:lineNum, 1)
    else
        lua vim.notify('outside any header', vim.log.levels.WARN, { title = 'markdown_jump' })
        "normal! gg
    endif
    return l:lineNum
endfunction

function! s:MoveToPreviousHeader()
    let l:curHeaderLineNumber = s:GetHeaderLineNum()
    let l:noPreviousHeader = 0
    if l:curHeaderLineNumber <= 1
        let l:noPreviousHeader = 1
    else
        let l:previousHeaderLineNumber = s:GetHeaderLineNum(l:curHeaderLineNumber - 1)
        if l:previousHeaderLineNumber == 0
            let l:noPreviousHeader = 1
        else
            call cursor(l:previousHeaderLineNumber, 1)
        endif
    endif
    if l:noPreviousHeader
        lua vim.notify('no previous header', vim.log.levels.WARN, { title = 'markdown_jump' })
    endif
endfunction

function! s:MoveToNextHeader()
    let s:headersRegexp = '\v^(#|.+\n(\=+|-+)$)'
    if search(s:headersRegexp, 'W') == 0
        lua vim.notify('no next header', vim.log.levels.WARN, { title = 'markdown_jump' })
    endif
endfunction

function! s:GetLevelOfHeaderAtLine(linenum)
    let l:lines = join(getline(a:linenum, a:linenum + 1), "\n")
    for l:key in keys(s:levelRegexpDict)
        if l:lines =~ get(s:levelRegexpDict, l:key)
            return l:key
        endif
    endfor
    return 0
endfunction

function! s:GetHeaderLevel(...)
    if a:0 == 0
        let l:line = line('.')
    else
        let l:line = a:1
    endif
    let l:linenum = s:GetHeaderLineNum(l:line)
    if l:linenum !=# 0
        return s:GetLevelOfHeaderAtLine(l:linenum)
    else
        return 0
    endif
endfunction

function! s:GetPreviousHeaderLineNumberAtLevel(level, ...)
    if a:0 == 0
        let l:line = line('.')
    else
        let l:line = a:1
    endif
    let l:l = l:line
    while(l:l > 0)
        if join(getline(l:l, l:l + 1), "\n") =~ get(s:levelRegexpDict, a:level)
            return l:l
        endif
        let l:l -= 1
    endwhile
    return 0
endfunction

function! s:GetParentHeaderLineNumber(...)
    if a:0 == 0
        let l:line = line('.')
    else
        let l:line = a:1
    endif
    let l:level = s:GetHeaderLevel(l:line)
    if l:level > 1
        let l:linenum = s:GetPreviousHeaderLineNumberAtLevel(l:level - 1, l:line)
        return l:linenum
    endif
    return 0
endfunction

function! s:GetNextHeaderLineNumberAtLevel(level, ...)
    if a:0 < 1
        let l:line = line('.')
    else
        let l:line = a:1
    endif
    let l:l = l:line
    while(l:l <= line('$'))
        if join(getline(l:l, l:l + 1), "\n") =~ get(s:levelRegexpDict, a:level)
            return l:l
        endif
        let l:l += 1
    endwhile
    return 0
endfunction


function! s:MoveToParentHeader()
    let l:linenum = s:GetParentHeaderLineNumber()
    if l:linenum != 0
        call setpos("''", getpos('.'))
        call cursor(l:linenum, 1)
    else
        lua vim.notify('no parent header', vim.log.levels.WARN, { title = 'markdown_jump' })
    endif
endfunction

function! s:MoveToNextSiblingHeader()
    let l:curHeaderLineNumber = s:GetHeaderLineNum()
    let l:curHeaderLevel = s:GetLevelOfHeaderAtLine(l:curHeaderLineNumber)
    let l:curHeaderParentLineNumber = s:GetParentHeaderLineNumber()
    let l:nextHeaderSameLevelLineNumber = s:GetNextHeaderLineNumberAtLevel(l:curHeaderLevel, l:curHeaderLineNumber + 1)
    let l:noNextSibling = 0
    if l:nextHeaderSameLevelLineNumber == 0
        let l:noNextSibling = 1
    else
        let l:nextHeaderSameLevelParentLineNumber = s:GetParentHeaderLineNumber(l:nextHeaderSameLevelLineNumber)
        if l:curHeaderParentLineNumber == l:nextHeaderSameLevelParentLineNumber
            call cursor(l:nextHeaderSameLevelLineNumber, 1)
        else
            let l:noNextSibling = 1
        endif
    endif
    if l:noNextSibling
        lua vim.notify('no next sibling header', vim.log.levels.WARN, { title = 'markdown_jump' })
    endif
endfunction

function! s:MoveToPreviousSiblingHeader()
    let l:curHeaderLineNumber = s:GetHeaderLineNum()
    let l:curHeaderLevel = s:GetLevelOfHeaderAtLine(l:curHeaderLineNumber)
    let l:curHeaderParentLineNumber = s:GetParentHeaderLineNumber()
    let l:previousHeaderSameLevelLineNumber = s:GetPreviousHeaderLineNumberAtLevel(l:curHeaderLevel, l:curHeaderLineNumber - 1)
    let l:noPreviousSibling = 0
    if l:previousHeaderSameLevelLineNumber == 0
        let l:noPreviousSibling = 1
    else
        let l:previousHeaderSameLevelParentLineNumber = s:GetParentHeaderLineNumber(l:previousHeaderSameLevelLineNumber)
        if l:curHeaderParentLineNumber == l:previousHeaderSameLevelParentLineNumber
            call cursor(l:previousHeaderSameLevelLineNumber, 1)
        else
            let l:noPreviousSibling = 1
        endif
    endif
    if l:noPreviousSibling
        echo 'no previous sibling header'
    endif
endfunction

function! s:ChangeInnerCurHeader() 
  " 移动到当前的标题
  let l:lineNum = s:GetHeaderLineNum()
  if l:lineNum !=# 0
      call cursor(l:lineNum, 1)
  else
      lua vim.notify('outside any header', vim.log.levels.WARN, { title = 'markdown_jump' })
      "normal! gg
  endif
  " 确认现在是几级标题
  let l:curHeaderLevel = s:GetLevelOfHeaderAtLine(line('.'))
  " 移动到标题后面的空格，然后删除后面的文字。
  call cursor(line('.'),l:curHeaderLevel+2)
  " 这个模式并不会切换成 insertmode
  normal! D
  startinsert!
endfunction

function! s:ChangeAroundCurHeader() 
  " 移动到当前的标题
  let l:lineNum = s:GetHeaderLineNum()
  if l:lineNum !=# 0
      call cursor(l:lineNum, 1)
  else
      lua vim.notify('outside any header', vim.log.levels.WARN, { title = 'markdown_jump' })
      "normal! gg
  endif
  " 确认现在是几级标题
  let l:curHeaderLevel = s:GetLevelOfHeaderAtLine(line('.'))
  " 移动到标题后面的空格，然后删除后面的文字。
  call cursor(line('.'),l:curHeaderLevel+2)
  " 这个模式并不会切换成 insertmode
  normal! cc
  startinsert!
endfunction

nnoremap <silent><buffer>;j <cmd>call <sid>MoveToNextHeader()<cr>
nnoremap <silent><buffer>;k <cmd>call <sid>MoveToPreviousHeader()<cr>
nnoremap <silent><buffer>;J <cmd>call <sid>MoveToNextSiblingHeader()<cr>
nnoremap <silent><buffer>;K <cmd>call <sid>MoveToPreviousSiblingHeader()<cr>
nnoremap <silent><buffer>;h <cmd>call <sid>MoveToCurHeader()<cr>
nnoremap <silent><buffer>;p <cmd>call <sid>MoveToParentHeader()<cr>
nnoremap <silent><buffer>cih <cmd>call <sid>ChangeInnerCurHeader()<cr>
nnoremap <silent><buffer>cah <cmd>call <sid>ChangeAroundCurHeader()<cr>
