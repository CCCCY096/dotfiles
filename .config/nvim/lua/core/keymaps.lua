-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Save and quit
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = '[w]rite current buffer' })
vim.keymap.set('n', '<leader>q', ':qa<CR>', { desc = '[q]uit all' })

vim.keymap.set('n', 'q', '<Nop>')
vim.keymap.set('n', 'Q', 'q')

-- Clear search highlights
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Lazy.nvim!
vim.keymap.set('n', '<leader>L', '<cmd>Lazy<CR>')

-- Quickly change conceal level
local toggleConcealLevel = function()
  vim.g.high_conceallevel = not vim.g.high_conceallevel
  local lvl = 0
  if vim.g.high_conceallevel then
    lvl = 3
  end
  vim.cmd(string.format('set conceallevel=%d', lvl))
end
vim.keymap.set('n', '<leader>oc', toggleConcealLevel, { desc = 'conceallevel' })

-- Better terminal opening
vim.keymap.set('n', '<leader>t', '<cmd>vert te<CR>', { desc = 'open terminal on right' })
