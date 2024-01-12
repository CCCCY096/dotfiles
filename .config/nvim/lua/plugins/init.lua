local lazyFile = require('utils').lazy_events

return {
  {
    'tpope/vim-sleuth',
    event = { lazyFile },
  },

  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    event = { lazyFile },
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    config = true,
  },

  -- "gc" to comment visual regions/lines
  {
    'numToStr/Comment.nvim',
    event = { lazyFile },
    config = true,
  },

  {
    'echasnovski/mini.pairs',
    event = { 'InsertEnter', 'CmdlineEnter' },
    version = false,
    config = true,
  },

  {
    'RRethy/vim-illuminate',
    event = { lazyFile },
    config = function()
      vim.keymap.set('n', '<leader>ti', require('illuminate').toggle, { desc = '[t]oggle [i]lluminate' })
    end,
  },

  {
    'mbbill/undotree',
    event = { lazyFile },
    config = function()
      vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[u]ndo tree' })
    end,
  },

  {
    'echasnovski/mini.map',
    version = false,
    event = { lazyFile },
    config = function()
      require('mini.map').setup()
      vim.keymap.set('n', '<leader>mo', MiniMap.toggle, { desc = '[m]ap toggle' })
      vim.keymap.set('n', '<leader>mf', MiniMap.toggle_focus, { desc = '[m]ap [f]ocus' })
      vim.keymap.set('n', '<leader>mr', MiniMap.toggle, { desc = '[m]ap [r]efresh' })
      vim.keymap.set('n', '<leader>ms', MiniMap.toggle, { desc = '[m]ap [s]ide' })
    end,
  },

  {
    'folke/which-key.nvim',
    config = true,
  },

  {
    'echasnovski/mini.sessions',
    version = false,
    config = function()
      require('mini.sessions').setup()

      local set_session = function()
        MiniSessions.write 'Session.vim'
      end

      vim.keymap.set('n', '<leader>S', set_session, { desc = 'save [S]ession' })

      -- local local_session = next(MiniSessions.detected)
      -- if local_session then
      --   MiniSessions.read(local_session.name)
      --   print 'found and load a local session!'
      -- end
    end,
  },
}
