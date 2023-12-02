local lazyFile = require('utils').lazy_file_events

return {
  'RRethy/vim-illuminate',
  event = {lazyFile},
  config = function ()
    vim.api.nvim_set_hl(0, "IlluminateWordText", {link = "LspReferenceText"})
    vim.api.nvim_set_hl(0, "IlluminateWordRead", {link = "LspReferenceRead"})
    vim.api.nvim_set_hl(0, "IlluminateWordWrite", {link = "LspReferenceWrite"})
  end
}
