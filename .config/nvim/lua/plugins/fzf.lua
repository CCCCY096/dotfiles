return {
  'ibhagwan/fzf-lua',
  enabled = false,
  -- optional for icon support
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'nvim-treesitter/nvim-treesitter',
  },
  config = function()
    -- calling `setup` is optional for customization
    local fzf = require 'fzf-lua'
    fzf.setup({'telescope'})
    vim.keymap.set('n', '<leader>fr', fzf.resume, { desc = '[f]ind [r]esume' })

    vim.keymap.set('n', '<leader>ff', fzf.files, { desc = '[f]ind [f]iles' })
    vim.keymap.set('n', '<leader>fo', fzf.oldfiles, { desc = '[f]ind recently [o]pened files' })
    vim.keymap.set('n', '<leader>fb', fzf.buffers, { desc = '[f]ind existing [b]uffers' })

    vim.keymap.set('n', '<leader>fw', fzf.grep_cword, { desc = '[f]ind current [w]ord' })
    vim.keymap.set('n', '<leader>/', fzf.grep_curbuf, { desc = '[/] find in current buffer' })
    vim.keymap.set('n', '<leader>fa', fzf.live_grep_native, { desc = '[f]ind [a]ll by live grep' })

    vim.keymap.set('n', '<leader>fg', fzf.git_files, { desc = '[f]ind [g]it files' })
    vim.keymap.set('n', '<leader>fh', fzf.help_tags, { desc = '[f]ind [h]elp' })
  end,
}
