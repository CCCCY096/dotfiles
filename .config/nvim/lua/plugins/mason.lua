local lazyFile = require('utils').lazy_file_events

return {
  {
    'williamboman/mason.nvim',
    event = { lazyFile },
    config = true,
  },
}
