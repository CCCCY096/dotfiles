local lazyFile = require('utils').lazy_file_events

return {
  {
    'tpope/vim-sleuth',
    event = { lazyFile },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    event = { lazyFile },
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    config = true,
  },
}

