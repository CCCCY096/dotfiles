local lazyFile = require('utils').lazy_file_events

return {
  'RRethy/vim-illuminate',
  event = {lazyFile},
  config = function ()
    vim.api.nvim_set_hl(0, "IlluminatedWordText", {link = "LspReferenceText"})
    vim.api.nvim_set_hl(0, "IlluminatedWordRead", {link = "LspReferenceRead"})
    vim.api.nvim_set_hl(0, "IlluminatedWordWrite", {link = "LspReferenceWrite"})
  end
}
