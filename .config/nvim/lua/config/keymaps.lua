-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Highlight on all occurrences of the current word]]
-- See `:help vim.highlight.on_yank()`
local highlight_occurrences_group = vim.api.nvim_create_augroup('HighlightOccurrences', { clear = true })
vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
  callback = function()
    vim.lsp.buf.document_highlight()
  end,
  group = highlight_occurrences_group,
  pattern = '*',
})

vim.api.nvim_create_autocmd({ 'CursorMoved' }, {
  callback = function()
    vim.lsp.buf.clear_references()
  end,
  group = highlight_occurrences_group,
  pattern = '*',
})
