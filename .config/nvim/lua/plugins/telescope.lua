return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
      },
      'folke/trouble.nvim',
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      local trouble = require 'trouble.providers.telescope'

      local common_mappings = {
        ['<CR>'] = require('telescope.actions').select_default + require('telescope.actions').center,
        ['<C-x>'] = require('telescope.actions').select_horizontal + require('telescope.actions').center,
        ['<C-v>'] = require('telescope.actions').select_vertical + require('telescope.actions').center,
        ['<C-t>'] = trouble.open_with_trouble,
        ['<C-u>'] = require('telescope.actions').results_scrolling_up,
        ['<C-d>'] = require('telescope.actions').results_scrolling_down,
        ['Down'] = require('telescope.actions').cycle_history_next,
        ['Up'] = require('telescope.actions').cycle_history_prev,
        ['<C-c>'] = require('telescope.actions').close,
      }

      require('telescope').setup {
        defaults = {
          mappings = {
            i = common_mappings,
            n = common_mappings,
          },
          dynamic_preview_tile = true,
          scroll_strategy = 'limit',
        },
      }

      -- Enable telescope fzf native, if installed
      require('telescope').load_extension 'fzf'

      -- Really useful
      vim.keymap.set('n', '<leader>fo', require('telescope.builtin').oldfiles, { desc = '[f]ind recently [o]pened files' })
      vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[f]ind existing [b]uffers' })
      vim.keymap.set('n', '<leader>/', function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
          winblend = 10,
          previewer = false,
        })
      end, { desc = '[/] find in current buffer' })
      vim.keymap.set('n', '<leader>fa', require('telescope.builtin').live_grep, { desc = '[f]ind [a]ll by live grep' })
      vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[f]ind [f]iles' })
      vim.keymap.set('n', '<leader>fr', require('telescope.builtin').resume, { desc = '[f]ind [r]esume' })

      -- less frequent
      vim.keymap.set('n', '<leader>fg', require('telescope.builtin').git_files, { desc = '[f]ind [g]it files' })
      vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[f]ind [h]elp' })
      vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[f]ind current [w]ord' })
    end,
  },
}
