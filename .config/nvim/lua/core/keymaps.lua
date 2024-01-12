--  [[ Leader ]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- [[ Quality of life ]]
-- Stay in the middle!
vim.keymap.set('n', '<C-]>', '<C-]>zz')
vim.keymap.set('n', '<C-o>', '<C-o>zz')
vim.keymap.set('n', '<C-i>', '<C-i>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, { desc = 'Open diagnostic list' })

-- Save and quit
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = '[w]rite current buffer' })
vim.keymap.set('n', '<leader>q', ':qa<CR>', { desc = '[q]uit all' })

vim.keymap.set('n', 'q', '<Nop>')
vim.keymap.set('n', 'Q', 'q')

-- move lines up or down
vim.keymap.set('v', 'J', ":'<,'>m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":'<,'>m '<-2<CR>gv=gv")
