return {
  {
    'sindrets/diffview.nvim',
    config = function()
      vim.keymap.set('n', '<leader>D', ':DiffviewOpen<CR>', { desc = '[D]iffview Open' })
    end,
  },

  {
    -- Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    config = function()
      require('gitsigns').setup {
        current_line_blame = true,

        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map('n', ']c', function()
            if vim.wo.diff then
              return ']c'
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '[c', function()
            if vim.wo.diff then
              return '[c'
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return '<Ignore>'
          end, { expr = true })

          map('n', '<leader>tb', gs.toggle_current_line_blame, { desc = '[t]oggle [b]lame' })
          map('n', '<leader>td', gs.toggle_deleted, { desc = '[t]oggle [d]eleted' })

          map('n', '<leader>gp', gs.preview_hunk, { desc = '[g]it [p]review hunk' })
          map('n', '<leader>gr', gs.reset_hunk, { desc = '[g]it [r]eset hunk' })
          map('v', '<leader>gr', function()
            gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { desc = '[g]it [r]eset hunk' })
          map('n', '<leader>gs', gs.stage_hunk, { desc = '[g]it [s]tage hunk' })
          map('n', '<leader>gu', gs.undo_stage_hunk, { desc = '[g]it [u]ndo hunk' })

          -- Less frequent actions
          map('v', '<leader>gs', function()
            gs.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { desc = '[g]it [s]tage hunk' })
          map('n', '<leader>gS', gs.stage_buffer, { desc = '[g]it [S]tage buffer' })
          map('n', '<leader>gR', gs.reset_buffer, { desc = '[g]it [R]eset buffer' })

          map('n', '<leader>gd', gs.diffthis, { desc = '[g]it [d]iff working tree' })
          map('n', '<leader>gD', function()
            gs.diffthis '~'
          end, { desc = '[g]it [D]iff HEAD' })

          -- Text object
          map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
        end,
      }
    end,
  },
}
