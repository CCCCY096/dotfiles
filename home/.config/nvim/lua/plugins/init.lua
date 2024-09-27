return {
  {
    'folke/which-key.nvim',
    config = function()
      local wk = require 'which-key'
      wk.setup {
        preset = 'helix',
        delay = 0,
        icons = {
          rules = false,
        },
      }
      wk.add {
        { '<leader>p', group = '[p]ick' },
        { '<leader>o', group = '[o]ption' },
        { '<leader>i', group = '[i]nvoke' },
        { '<leader>l', group = '[l]sp' },
      }
    end,
  },

  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  {
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      require('mini.pairs').setup()

      local toggleAutoPair = function()
        vim.g.minipairs_disable = not vim.g.minipairs_disable
      end

      vim.keymap.set('n', '<leader>op', toggleAutoPair, { desc = 'auto [p]air' })
    end,
  },

  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[u]ndo tree' })
    end,
  },
}
