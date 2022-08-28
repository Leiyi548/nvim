local ls = require('luasnip')
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local postfix = require('luasnip.extras.postfix').postfix

-- console.log($POSTFIX_MATCH)
ls.add_snippets('javascript',{
  postfix('.log', {
    f(function(_, parent)
      return 'console.log(' .. parent.snippet.env.POSTFIX_MATCH .. ')'
    end, {}),
  })
})

