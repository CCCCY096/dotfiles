local lazyFile = require('utils').lazy_file_events

return {
  'windwp/nvim-autopairs',
  event = { lazyFile },
  -- Optional dependency
  dependencies = { 'hrsh7th/nvim-cmp' },
  config = function()
    require('nvim-autopairs').setup {}
  end,
}
