" more information please see https://github.com/abzcoding/lvim/blob/main/after/syntax/markdown.vim
" list
syn match mdItem "^ *[\*-]\( X \| \[[x ]\]\)\@! " contains=mdBullet
syn match mdBullet "[\*-]" contained containedin=mdItem conceal cchar=
" checkbox
syn match mdTask "^ *- \[ \].*$" contains=mdCheckbox
syn match mdCheckbox "- \[ \]" contained containedin=mdTask conceal cchar=☐

syn match mdCompleteTask "^ *- \[x\].*$" contains=mdCompleteMark
syn match mdCompleteTask "\(^ *[\*-] \)\@!.*@done.*$"
syn match mdCompleteMark "- \[x\]" contained containedin=mdCompleteTask conceal cchar=

setlocal conceallevel=2
highlight Conceal guibg=NONE
