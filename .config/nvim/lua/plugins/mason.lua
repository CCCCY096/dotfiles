local lazyFile = require('utils').lazy_events

return {
  {
    'williamboman/mason.nvim',
    event = { lazyFile },
    config = true,
  },
}
