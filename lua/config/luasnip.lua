local ls = require('luasnip')
local types = require('luasnip.util.types')
ls.config.set_config({
  history = true,
  enable_autosnippets = true,
  updateevents = 'TextChanged,TextChangedI',
  ext_opts = {
    [types.choiceNode] = {
      active = {
        virt_text = { { '<- choiceNode', 'Comment' } },
      },
    },
    [types.insertNode] = {
      active = {
        virt_text = { { '<- insertNode', 'Comment' } },
      },
    },
  },
})
