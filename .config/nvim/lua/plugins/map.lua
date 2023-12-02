local lazyFile = require('utils').lazy_file_events

return {
  'echasnovski/mini.map',
  version = false,
  event = { lazyFile },
  config = function ()
    require('mini.map').setup()
    vim.keymap.set('n', '<leader>mo', MiniMap.toggle, {desc = '[m]ap toggle'})
    vim.keymap.set('n', '<leader>mf', MiniMap.toggle_focus, {desc = '[m]ap [f]ocus'})
    vim.keymap.set('n', '<leader>mr', MiniMap.toggle, {desc = '[m]ap [r]efresh'})
    vim.keymap.set('n', '<leader>ms', MiniMap.toggle, {desc = '[m]ap [s]ide'})
  end
}
