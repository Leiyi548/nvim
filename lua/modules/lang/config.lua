local config = {}

function config.nvim_treesitter()
  -- vim.api.nvim_command('set foldmethod=expr')
  -- vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
  require('nvim-treesitter.configs').setup({
    ensure_installed = 'all',
    -- ignore_install = { 'phpdoc', 'markdown', 'markdown_inline' },
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
          ['<space>mj'] = '@function.outer',
          [']c'] = '@class.outer',
        },
        goto_previous_start = {
          ['[m'] = '@function.outer',
          ['<space>mk'] = '@function.outer',
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
end

function config.nvim_treesitter_content()
  require('treesitter-context').setup({
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
      -- For all filetypes
      -- Note that setting an entry here replaces all other patterns for this entry.
      -- By setting the 'default' entry below, you can control which nodes you want to
      -- appear in the context window.
      default = {
        'class',
        'function',
        'method',
        'for', -- These won't appear in the context
        'while',
        'if',
        'switch',
        'case',
      },
      -- Example for a specific filetype.
      -- If a pattern is missing, *open a PR* so everyone can benefit.
      --   rust = {
      --       'impl_item',
      --   },
    },
    exact_patterns = {
      -- Example for a specific filetype with Lua patterns
      -- Treat patterns.rust as a Lua pattern (i.e "^impl_item$" will
      -- exactly match "impl_item" only)
      -- rust = true,
    },

    -- [!] The options below are exposed but shouldn't require your attention,
    --     you can safely ignore them.

    zindex = 20, -- The Z-index of the context window
    mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
    separator = nil, -- Separator between context and content. Should be a single character string, like '-'.
  })
end

function config.neorg()
  require('neorg').setup({
    load = {
      ['core.defaults'] = {},
      ['core.keybinds'] = {
        config = {
          default_keybinds = true,
          neorg_leader = ',o',
        },
      },
      ['core.norg.concealer'] = {},
      ['core.norg.qol.toc'] = {},
      ['core.norg.dirman'] = {
        config = {
          workspaces = {
            main = '~/neorg',
            gtd = '~/neorg/gtd',
            -- doom_docs = string.format("%s/doc", doom_root),
          },
          autodetect = true,
          autochdir = true,
        },
      },
      ['core.norg.esupports.metagen'] = {
        config = { type = 'auto' },
      },
      ['core.export'] = {},
      ['core.export.markdown'] = {
        config = { extensions = 'all' },
      },
      ['core.gtd.base'] = {
        config = {
          workspace = 'gtd',
        },
      },
    },
  })
end

function config.markdown_preview()
  -- set to 1,nvim will open the preview window after entering the markdown buffer
  vim.g.mkdp_auto_start = 0
  -- set to 1, the nvim will auto close current preview window when change
  -- from markdown buffer to another buffer
  vim.g.mkdp_auto_close = 0
  -- Change the theme according to time
  local _time = os.date('*t')
  if _time.hour > 18 or _time.hour < 6 then
    vim.g.mkdp_theme = 'dark'
  else
    vim.g.mkdp_theme = 'light'
  end
end

function config.vim_markdown()
  vim.g.vim_markdown_conceal_code_blocks = 0
  vim.g.vim_markdown_math = 1
  vim.g.vim_markdown_new_list_item_indent = 2
  vim.g.vim_markdown_autowrite = 1
  vim.g.vim_markdown_auto_insert_bullets = 0
end

return config
