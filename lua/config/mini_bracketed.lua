require('mini.bracketed').setup(
  -- No need to copy this inside `setup()`. Will be used automatically.
  {
    -- First-level elements are tables describing behavior of a target:
    --
    -- - <suffix> - single character suffix. Used after `[` / `]` in mappings.
    --   For example, with `b` creates `[B`, `[b`, `]b`, `]B` mappings.
    --   Supply empty string `''` to not create mappings.
    --
    -- - <options> - table overriding target options.
    --
    -- See `:h MiniBracketed.config` for more info.

    -- remove this keybinding
    buffer = { suffix = '', options = {} },
    comment = { suffix = 'a', options = {} },
    conflict = { suffix = 'x', options = {} },
    -- remove this keybinding
    diagnostic = { suffix = '', options = {} },
    file = { suffix = 'f', options = {} },
    indent = { suffix = 'i', options = {} },
    jump = { suffix = 'j', options = {} },
    location = { suffix = 'l', options = {} },
    oldfile = { suffix = 'o', options = {} },
    quickfix = { suffix = 'q', options = {} },
    treesitter = { suffix = 't', options = {} },
    undo = { suffix = 'u', options = {} },
    window = { suffix = 'w', options = {} },
    yank = { suffix = 'y', options = {} },
  }
)
