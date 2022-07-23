-- author: glepnr https://github.com/glepnir
-- date: 2022-07-02
-- License: MIT

local config = {}

-- config server in this function
function config.nvim_lsp() end

function config.nvim_cmp()
  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
  end

  local cmp_ok, cmp = pcall(require, 'cmp')
  if not cmp_ok then
    return
  end
  local lusnip_ok, luasnip = pcall(require, 'luasnip')
  if not lusnip_ok then
    vim.notify('luasnip not found')
    return
  end

  local icons = require('modules.ui.icons')
  local kind_icons = icons.kind

  vim.api.nvim_set_hl(0, 'CmpItemKindCopilot', { fg = '#6CC644' })
  vim.api.nvim_set_hl(0, 'CmpItemKindTabnine', { fg = '#CA42F0' })
  vim.api.nvim_set_hl(0, 'CmpItemKindEmoji', { fg = '#FDE030' })
  vim.api.nvim_set_hl(0, 'CmpItemKindCrate', { fg = '#F64D00' })

  cmp.setup({
    snippet = {
      expand = function(args)
        luasnip.lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<Up>'] = cmp.mapping.select_prev_item(),
      ['<Down>'] = cmp.mapping.select_next_item(),
      ['<C-u>'] = cmp.mapping.scroll_docs(-4),
      ['<C-d>'] = cmp.mapping.scroll_docs(4),
      ['<PageUp>'] = cmp.mapping.scroll_docs(4),
      ['<PageDown>'] = cmp.mapping.scroll_docs(-4),
      ['<C-y>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-]>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      -- Accept currently selected item. If none selected, `select` first item.
      -- Set `select` to `false` to only confirm explicitly selected items.
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Insert,
        select = true,
      }),
      -- like vscode tab behavior
      ['<Tab>'] = cmp.mapping(function(fallback)
        -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
        if cmp.visible() then
          local entry = cmp.get_selected_entry()
          if not entry then
            cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
            cmp.confirm()
          else
            cmp.confirm()
          end
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { 'i', 's', 'c' }),
      ['<S-Tab>'] = cmp.mapping(function(fallback)
        -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
        if cmp.visible() then
        elseif luasnip.expand_or_jumpable() then
          luasnip.jump(-1)
        elseif has_words_before() then
          cmp.complete()
        else
          fallback()
        end
      end, { 'i', 's', 'c' }),
    }),
    formatting = {
      fields = { 'kind', 'abbr', 'menu' },
      format = function(entry, vim_item)
        -- Kind icons
        vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
        vim_item.menu = ({
          -- nvim_lsp = "(LSP)",
          -- luasnip = "(Snippet)",
          -- buffer = "(Buffer)",
          -- path = "(Path)",
          nvim_lsp = '',
          luasnip = '',
          buffer = '',
          path = '',
        })[entry.source.name]
        return vim_item
      end,
    },
    sources = {
      { name = 'luasnip' },
      { name = 'nvim_lsp' },
      { name = 'buffer' },
      { name = 'path' },
      { name = 'emoji' },
      { name = 'flypy' },
      -- { name = "luasnip", priority = 999, max_item_count = 3 },
    },
    confirm_opts = {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    window = {
      documentation = {
        -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
        border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
        winhighlight = 'NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None',
      },
      completion = {
        border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
        winhighlight = 'NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None',
      },
    },
    experimental = {
      ghost_text = true,
      native_menu = false,
    },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' },
    }, {
      { name = 'cmdline' },
    }),
  })
end

function config.lua_snip()
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
    },
  })
  require('luasnip.loaders.from_lua').lazy_load({ paths = vim.fn.stdpath('config') .. '/snippets' })
  require('luasnip.loaders.from_vscode').lazy_load()
  require('luasnip.loaders.from_vscode').lazy_load({
    paths = { './snippets/' },
  })
end

function config.auto_pairs()
  -- Setup nvim-cmp.
  local auto_pairs_ok, npairs = pcall(require, 'nvim-autopairs')
  if not auto_pairs_ok then
    return
  end

  npairs.setup({
    check_ts = true,
    ts_config = {
      lua = { 'string', 'source' },
      javascript = { 'string', 'template_string' },
      java = false,
    },
    disable_filetype = { 'TelescopePrompt', 'spectre_panel' },
    fast_wrap = {
      map = '<M-e>',
      chars = { '{', '[', '(', '"', "'" },
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], '%s+', ''),
      offset = 0, -- Offset from pattern match
      end_key = '$',
      keys = 'qwertyuiopzxcvbnmasdfghjkl',
      check_comma = true,
      highlight = 'PmenuSel',
      highlight_grey = 'LineNr',
    },
  })

  local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp_status_ok, cmp = pcall(require, 'cmp')
  if not cmp_status_ok then
    return
  end
  cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done({ map_char = { tex = '' } }))
end

function config.flypy()
  require('flypy').setup({
    dict_name = 'flypy', -- 选择码表：flypy为小鹤音形，wubi98为98五笔
    comment = true, -- 在所有文件类型的注释下开启
    filetype = { 'markdown' }, -- 在指定文件类型下开启

    num_filter = true, -- 数字筛选
    source_code = false, -- 显示原码
  })
end

return config
