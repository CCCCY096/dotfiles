return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local fzf = require 'fzf-lua'

    fzf.setup {
      'defaults',
      winopts = {
        preview = {
          delay = 10,
        },
      },
      fzf_opts = {
        ['--layout'] = false,
      },
    }

    -- Files
    vim.keymap.set('n', '<leader>ff', fzf.files, { desc = '[f]ind [f]iles' })
    vim.keymap.set('n', '<leader>fo', fzf.oldfiles, { desc = '[f]ind recently [o]pened files' })
    vim.keymap.set('n', '<leader>fb', fzf.buffers, { desc = '[f]ind existing [b]uffers' })
    vim.keymap.set('n', '<leader>fg', fzf.git_files, { desc = '[f]ind [g]it [f]iles' })

    -- Grep
    vim.keymap.set('n', '<leader>/', fzf.lgrep_curbuf, { desc = '[/] search in current buffer' })
    vim.keymap.set('n', '<leader>fw', fzf.files, { desc = '[f]ind current [w]ord' })
    vim.keymap.set('n', '<leader>fa', fzf.files, { desc = '[f]ind [a]ll by live grep' })

    -- Misc.
    vim.keymap.set('n', '<leader>fh', fzf.files, { desc = '[f]ind [h]elp' })
    vim.keymap.set('n', '<leader>fr', fzf.files, { desc = '[f]ind [r]esume' })
  end,
}
