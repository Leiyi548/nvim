require('nvim-treesitter.configs').setup({
  ensure_installed = 'all',
  -- ignore_install = { 'phpdoc', 'markdown', 'markdown_inline' },
  ignore_install = { 'phpdoc' },
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = { 'python', 'css', 'rust' },
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  autotag = {
    enable = true,
    filetype = { 'html', 'javascript', 'typescript', 'vue' },
    disable = { 'xml', 'markdown' },
  },
  rainbow = {
    enable = true,
    colors = {
      '#68a0b0',
      '#946EaD',
      '#c7aA6D',
    },
    disable = { 'html' },
  },
  textobjects = {
    -- BUG: keybinding not useful
    swap = {
      enable = true,
      swap_next = {
        ['[w'] = '@parameter.inner',
      },
      swap_previous = {
        [']w'] = '@parameter.inner',
      },
    },
    select = {
      enable = true,
      keymaps = {
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']c'] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[c'] = '@class.outer',
      },
    },
    lsp_interop = {
      enable = true,
      border = 'rounded',
      peek_definition_code = {
        ['df'] = '@function.outer',
        ['dc'] = '@class.outer',
      },
    },
  },
  playground = {
    enable = true,
  },
})
