local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') == nil
end

local cmp_ok, cmp = pcall(require, 'cmp')
if not cmp_ok then
  return
end
local luasnip_ok, luasnip = pcall(require, 'luasnip')
if not luasnip_ok then
  return
end

local icons = require('config.icons')
local kind_icons = icons.kind

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body) -- For `luasnip` users.
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Up>'] = cmp.mapping.select_prev_item(),
    ['<Down>'] = cmp.mapping.select_next_item(),
    ['<C-u>'] = cmp.mapping.scroll_docs(4),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<PageUp>'] = cmp.mapping.scroll_docs(4),
    ['<PageDown>'] = cmp.mapping.scroll_docs(-4),
    -- ['<C-o>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    -- ['<C-]>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
    -- ['<C-e>'] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close(), }), -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
    -- 预选中时空格上屏配置（nvim-cmp)
    [';'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        local selected_entry = cmp.core.view:get_selected_entry()
        if selected_entry and selected_entry.source.name == 'flypy' and not cmp.confirm({ select = true }) then
          return fallback()
        end
      end
      fallback()
    end, { 'i', 's' }),
    -- like vscode tab behavior
    ['<Tab>'] = cmp.mapping(function(fallback)
      -- This little snippet will confirm with tab, and if no entry is selected, will confirm the first item
      if cmp.visible() then
        local entry = cmp.get_selected_entry()
        if not entry then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          cmp.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          })
        else
          cmp.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          })
        end
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        return '<Tab>'
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
        return '<S-Tab>'
      else
        fallback()
      end
    end, { 'i', 's', 'c' }),
  }),
  formatting = {
    fields = { 'kind', 'abbr', 'menu' },
    format = function(entry, vim_item)
      -- vim_item.menu = string.format('[' .. '%s' .. ']', vim_item.kind)
      vim_item.menu = string.format('%s', vim_item.kind)
      -- Kind icons
      vim_item.kind = string.format('%s', kind_icons[vim_item.kind])
      -- add icon
      if entry.source.name == 'emoji' then
        vim_item.kind = icons.misc.Smiley
      end
      if entry.source.name == 'flypy' then
        vim_item.kind = icons.misc.flypy
      end
      -- vim_item.menu = ({
      --   nvim_lsp = '[LSP]',
      --   luasnip = '[SNIP]',
      --   buffer = '[BUF]',
      --   path = '[PATH]',
      --   -- nvim_lsp = '',
      --   -- luasnip = '',
      --   -- buffer = '',
      --   -- path = '',
      -- })[entry.source.name]
      return vim_item
    end,
  },
  sources = {
    { name = 'luasnip' },
    { name = 'nvim_lsp' },
    {
      name = 'buffer',
      option = {
        -- All buffers
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end,
      },
    },
    { name = 'path' },
    { name = 'emoji' },
    { name = 'flypy' },
    { name = 'nvim_lsp_signature_help' },
    -- { name = "luasnip", priority = 999, max_item_count = 3 },
  },
  confirm_opts = {
    behavior = cmp.ConfirmBehavior.Replace,
    select = false,
  },
  window = {
    documentation = {
      -- border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
      -- border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
      -- winhighlight = 'NormalFloat:Pmenu,NormalFloat:Pmenu,CursorLine:PmenuSel,Search:None',
      -- winhighlight = 'Normal:CmpPmenu,FloatBorder:CmpPmenuBorder,Search:None',
    },
    completion = {
      -- border = { '┌', '─', '┐', '│', '┘', '─', '└', '│' },
      -- winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None',
    },
  },
  experimental = {
    ghost_text = true,
    native_menu = false,
  },
})

-- `:` cmdline setup.
cmp.setup.cmdline({ ':', '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' },
    { name = 'buffer' },
  }, {
    {
      name = 'cmdline',
      option = {
        ignore_cmds = { 'Man', '!' },
      },
    },
  }),
})

-- autopair
-- If you want insert `(` after select function or method item
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
