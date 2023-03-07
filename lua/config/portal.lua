require('portal').setup({
  ---@type "debug" | "info" | "warn" | "error"
  log_level = 'warn',
  ---The base filter applied to every search.
  ---@type Portal.SearchPredicate | nil
  filter = nil,
  ---The maximum number of results for any search.
  ---@type integer | nil
  max_results = nil,
  ---The maximum number of items that can be searched.
  ---@type integer
  lookback = 100,
  ---An ordered list of keys for labelling portals.
  ---Labels will be applied in order, or to match slotted results.
  ---@type string[]
  labels = { 'j', 'k', 'l', ';' },
  ---Keys used for exiting portal selection. Disable with [{key}] = false
  ---to `false`.
  ---@type table<string, boolean>
  escape = {
    ['<esc>'] = true,
    ['q'] = true,
  },
  ---The raw window options used for the portal window
  window_options = {
    relative = 'cursor',
    width = 80,
    height = 3,
    col = 2,
    focusable = false,
    border = 'single',
    noautocmd = true,
  },
})
