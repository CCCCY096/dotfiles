return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',

      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
      },

      'nvim-telescope/telescope-ui-select.nvim',

      'nvim-tree/nvim-web-devicons',

      'folke/trouble.nvim',
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      local trouble = require 'trouble.providers.telescope'

      local common_mappings = {
        ['<C-t>'] = trouble.open_with_trouble,
        ['<C-u>'] = require('telescope.actions').results_scrolling_up,
        ['<C-d>'] = require('telescope.actions').results_scrolling_down,
        ['<C-c>'] = require('telescope.actions').close,
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
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] Fuzzily search in current buffer' })
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
