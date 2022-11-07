" clear syntax highlight
hi MDTask ctermfg=1
hi MDDoneText gui=strikethrough guifg=#5f5f87
hi MDTodoText gui=NONE
hi MDDoneDate gui=strikethrough ctermfg=71
hi MDTodoDate ctermfg=71
au FileType markdown syn match markdownError "\w\@<=\w\@="
au FileType markdown syn match MDDoneDate /[SD]:\d\{4\}\([\/-]\d\d\)\{2\}/ contained
au FileType markdown syn match MDTodoDate /[SD]:\d\{4\}\([\/-]\d\d\)\{2\}/ contained
au FileType markdown syn match MDDoneText /- \[x\] \zs.*/ contains=MDDoneDate contained
au FileType markdown syn match MDTodoText /- \[ \] \zs.*/ contains=MDTodoDate contained
au FileType markdown syn match MDTask     /- \[\(x\| \)\] .*/ contains=MDDoneText,MDTodoText
au FileType markdown syntax clear markdownListMarker
au FileType markdown call matchadd('Todo', 'D:'.strftime("%Y-%m-%d"))

" surround
xnoremap <silent><buffer> B      :<c-u>call SurroundVaddPairs("**", "**")<cr>
xnoremap <silent><buffer> I      :<c-u>call SurroundVaddPairs("*", "*")<cr>
xnoremap <silent><buffer> T      :<c-u>call SurroundVaddPairs("- [ ] ", "")<cr>
xnoremap <silent><buffer> `      :<c-u>call SurroundVaddPairs("`", "`")<cr>
xnoremap <silent><buffer> C      :<c-u>call SurroundVaddPairs("```plaintext", "```")<cr>
