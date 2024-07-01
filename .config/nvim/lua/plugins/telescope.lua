return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    lazy = true,
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',

      {
        'nvim-telescope/telescope-fzf-native.nvim',
        build = 'make',
      },

      'nvim-telescope/telescope-ui-select.nvim',

      'nvim-tree/nvim-web-devicons',

      'folke/trouble.nvim',
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      local common_mappings = {
        ['<C-t>'] = require('trouble.sources.telescope').open,
        ['<C-u>'] = require('telescope.actions').results_scrolling_up,
        ['<C-d>'] = require('telescope.actions').results_scrolling_down,
        ['<C-c>'] = require('telescope.actions').close,
        ['<C-g>'] = require('telescope.actions.layout').toggle_preview,
      }

      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require('telescope').setup {
        defaults = {
          mappings = {
            i = common_mappings,
            n = common_mappings,
          },
          scroll_strategy = 'limit',
          layout_strategy = 'flex',
          wrap_results = true,
        },
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      }

      -- Enable telescope extensions, if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')

      -- Files
      local builtin = require 'telescope.builtin'
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[f]ind [f]iles' })
      vim.keymap.set('n', '<leader>fo', builtin.oldfiles, { desc = '[f]ind recently [o]pened files' })
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = '[f]ind existing [b]uffers' })
      vim.keymap.set('n', '<leader>fg', builtin.git_files, { desc = '[f]ind [g]it files' })

      -- Grep
      vim.keymap.set('n', '<leader>/', builtin.current_buffer_fuzzy_find, { desc = '[/] fuzzily search in current buffer' })
      vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[f]ind current [w]ord' })
      vim.keymap.set('n', '<leader>fa', builtin.live_grep, { desc = '[f]ind [a]ll by live grep' })

      -- Mics.
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[f]ind [h]elp' })
      vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[f]ind [r]esume' })
      vim.keymap.set('n', '<leader>fm', builtin.builtin, { desc = '[f]ind [m]or...' })
      -- Shortcut for searching your neovim configuration files
      vim.keymap.set('n', '<leader>fn', function()
        builtin.find_files { cwd = vim.fn.stdpath 'config' }
      end, { desc = '[f]ind [n]eovim files' })
    end,
  },
}
