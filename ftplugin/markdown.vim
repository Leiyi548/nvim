hi MDTask ctermfg=1
hi MDDoneText gui=italic,strikethrough
hi MDTodoText gui=NONE
hi MDDoneDate gui=italic,strikethrough ctermfg=71
hi MDTodoDate ctermfg=71
au FileType markdown syn match markdownError "\w\@<=\w\@="
au FileType markdown syn match MDDoneDate /[SD]:\d\{4\}\([\/-]\d\d\)\{2\}/ contained
au FileType markdown syn match MDTodoDate /[SD]:\d\{4\}\([\/-]\d\d\)\{2\}/ contained
au FileType markdown syn match MDDoneText /- \[x\] \zs.*/ contains=MDDoneDate contained
au FileType markdown syn match MDTodoText /- \[ \] \zs.*/ contains=MDTodoDate contained
au FileType markdown syn match MDTask     /- \[\(x\| \)\] .*/ contains=MDDoneText,MDTodoText
au FileType markdown call matchadd('Todo', 'D:'.strftime("%Y-%m-%d"))

