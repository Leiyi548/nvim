function! s:gitModified()
    let files = systemlist('git ls-files -m 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
    let files = systemlist('git ls-files -o --exclude-standard 2>/dev/null')
    return map(files, "{'line': v:val, 'path': v:val}")
endfunction

"If you want numbers to start at 1 instead of 0, you could use this:
let g:startify_custom_indices = map(range(1,100), 'string(v:val)')
let g:startify_files_number = 5
let g:startify_lists = [
        \ { 'type': 'files',     'header': ['   MRU']            },
        \ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
        \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
        \ { 'type': 'sessions',  'header': ['   Sessions']       },
        \ { 'type': function('s:gitModified'),  'header': ['   git modified']},
        \ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
        \ { 'type': 'commands',  'header': ['   Commands']       },
        \ ]
let g:startify_session_autoload = 0
let g:startify_skiplist = [
      \ '\.vimgolf',
      \ '^/tmp',
      \ '/project/.*/documentation',
      \ ]
let g:startify_bookmarks            = [
        \ '~/.config/nvim/init.lua',
        \ '~/.zshrc',
        \]
" custom footer
let g:startify_custom_footer =
     \ ['', "Vim is charityware. Please read ':help uganda'.", '']
" custom header
" let g:startify_custom_header =
"       \ 'startify#center(startify#fortune#cowsay())'
let g:startify_custom_header_quotes = [
      \["答案很长，我准备用一生的时间来回答，你准备要听了吗？"],
      \["夜我就是你的圣诞礼物，非～非礼啊。"],
      \["有一种水果全世界最甜，叫黑凤梨。"],
      \["因为睡觉，才有了下一代，才有了你。"],
      \["你在我身边时，药是甜的，雪是暖的，连风暴都是可爱的。"],
      \["我的房子租期到了诶，我能住你心里去么，收多少房租我都愿意。"],
      \["愿有岁月可回首，且以深情共白头。"],
      \["我可能盐吃多了，闲的老是想你。"],
      \["我喜欢你，在所有时候，也喜欢有些人，在他们偶尔像你的时候。"],
      \["我不想做你生命的插曲，只想做你生命最完美的结局。"],
      \["人间真的太大了，我探头看了一下，最后还是乖乖缩回你心间里了！"],
      \["染最艳的头发，留最深的疤，只为寻找最爱的她。"],
      \["我说，在看不到你的时候，就是我最寂寞的时候。"],
      \["睡眠质量的好坏，不在于时间长短，而在于有没有梦到你。"],
      \["我马上就好了，五分钟左右。"],
      \["周末民政局搞特价，我请你，走起。"],
      \["哥你受惊了，连我你都亲你都喝啥样了？"],
      \["你知道我最大的缺点是什么吗？是缺点你。"],
      \["好累啊，我需要你的抱抱了。"],
      \["如果我想和你约会，你的回答会和这问题的回答一样吗？"],
      \["我给你做牛做马，你给我草好不好呀。"],
      \["宝贝你在哪迷路了，我去找你！"],
      \["看手机看得我眼睛疼。那你还看。因为我想透过手机看到你。"],
      \["我是个实际的人，我相信日久生情。"],
      \["再累，再苦，再疼，也只是为了你能喜欢我而已。"],
      \["拽你入怀，予你一世相伴，拥你入怀，护你一世平安。"],
      \["也许你并不完美，但最起码我认为，你是最好的。"],
      \["可爱不是长久之计，可爱我是长久之计。"],
      \["下辈子我们还在一起，你不来，我不老。"],
      \["你不要太调皮，我跟你讲，你这是在找啪。"],
      \["很晚才爱你，余生只啪你。"],
      \["我能陪你熬夜，也会劝你早睡。"],
      \["每个人都喜欢自己吧？那么你还真是我的情敌。"],
      \["我想你应该很忙吧，那就只看前三个字就好了。"],
      \["我的世界不允许你的消失，不管结局是否完美。"],
      \["初见是惊鸿一瞥，南柯一梦是你。"],
      \["前半生到处浪荡，后半生为你煲汤。"],
      \["一天就是一日，一日就是一天。"],
      \["我不想说爱你这种大话，可你在我身边我就很安心。"],
      \["永远不要改变，因为我爱的就是现在的你。"],
      \["陌上花开，青山碧水，春风和煦，不染红尘。"],
      \["当我看到你时，我爱上了你，而你却因为你知道而微笑。"],
      \["一想到昨天的我也喜欢你，今天我就很吃醋。"],
      \["你一哭，全世界都像在下雨，你一笑，全世界都像是晴天。"],
      \["既然你把我的心已经弄乱了，那你打算什么时候来弄乱我的床？"],
      \["哎，我昨天晚上梦到你了呢！你说我是想你了呢还是想你了呢？"],
      \["我跟你在一起喝黑咖啡都不用加奶和糖的，因为你奶甜奶甜的！"],
      \["绝口不提爱你，不是不爱，而是很爱，却不能再爱。"],
      \["等待是山重水复，怦然心动是你。"],
      \["你是哪里人？是我的心上人。"],
      \["挺好的小伙留个长头发，抓只本地的狐狸，装毛聊斋呢？"],
      \["我想要的很简单，时光还在，你还在。"],
      \["我不懂赔率，只懂陪你。"],
      \["喜欢你呀，像一颗奶糖从眉间甜到脚尖。"],
      \["你不爱我没事，让我心疼你。"],
      \ ]
