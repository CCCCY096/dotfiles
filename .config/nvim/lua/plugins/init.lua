return {
  -- NOTE: Plugins can be added with a link (or for a github repo: 'owner/repo' link).
  'tpope/vim-sleuth', -- Detect tabstop and shiftwidth automatically

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', config = true },

  {
    'folke/which-key.nvim',
    config = true,
  },

  {
    'echasnovski/mini.pairs',
    version = false,
    config = true,
  },

  {
    'echasnovski/mini.nvim',
    config = function ()
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

      require('mini.map').setup()
      vim.keymap.set('n', '<leader>mo', MiniMap.toggle, { desc = '[m]ap toggle' })
      vim.keymap.set('n', '<leader>mf', MiniMap.toggle_focus, { desc = '[m]ap [f]ocus' })
      vim.keymap.set('n', '<leader>mr', MiniMap.toggle, { desc = '[m]ap [r]efresh' })
      vim.keymap.set('n', '<leader>ms', MiniMap.toggle, { desc = '[m]ap [s]ide' })
    end
  },

  {
    'mbbill/undotree',
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[u]ndo tree' })
    end,
  },
}
