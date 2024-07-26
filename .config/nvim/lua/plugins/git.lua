return {
  {
    'sindrets/diffview.nvim',
    config = function()
      vim.keymap.set('n', '<leader>G', ':DiffviewOpen<CR>', { desc = '[G]it diff' })
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
          map('n', ']g', function()
            gs.nav_hunk('next', nil)
          end, { desc = { 'next [g]it hunk' } })

          map('n', '[g', function()
            gs.nav_hunk('prev', nil)
          end, { desc = { 'prev [g]it hunk' } })

          map('n', '<leader>ob', gs.toggle_current_line_blame, { desc = '[b]lame' })
          map('n', '<leader>od', gs.toggle_deleted, { desc = '[d]eleted' })

          map('n', '<leader>gr', gs.reset_hunk, { desc = '[g]it [r]eset hunk' })
          map('v', '<leader>gr', function()
            gs.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
          end, { desc = '[g]it [r]eset hunk' })
        end,
      }
    end,
  },
}
