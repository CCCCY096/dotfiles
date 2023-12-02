local lazyFile = require('utils').lazy_file_events

return {
  'mbbill/undotree',
  event = { lazyFile },
  config = function()
    vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[u]ndo tree' })
  end,
}
