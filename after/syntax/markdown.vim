" more information please see https://github.com/abzcoding/lvim/blob/main/after/syntax/markdown.vim

" list
syn match mdItem "^ *[\*-]\( X \| \[[x ]\]\)\@! " contains=mdBullet
syn match mdBullet "[\*-]" contained containedin=mdItem conceal cchar=
" checkbox
syntax match todoCheckbox "\v.*\[\ \]"hs=e-2 conceal cchar=
syntax match todoCheckbox "\v.*\[x\]"hs=e-2 conceal cchar=

setlocal conceallevel=2

highlight Conceal guibg=NONE

"https://vi.stackexchange.com/a/4003/16249
syntax match NoSpellAcronym '\<\(\u\|\d\)\{3,}s\?\>' contains=@NoSpell
