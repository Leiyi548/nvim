local config = {}

function config.nvim_treesitter()
  -- vim.api.nvim_command('set foldmethod=expr')
  -- vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
  require('nvim-treesitter.configs').setup({
    ensure_installed = { 'lua', 'python'},
    ignore_install = { 'phpdoc' },
    highlight = {
      enable = true,
      disable = { 'markdown' },
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
          [']]'] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['[['] = '@class.outer',
        },
      },
      lsp_interop = {
        enable = true,
        border = 'rounded',
        peek_definition_code = {
          ['df'] = '@function.outer',
          ['gp'] = '@function.outer',
          ['dF'] = '@class.outer',
        },
      },
    },
    playground = {
      enable = true,
    },
  })
end

return config
