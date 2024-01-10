return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local oil = require 'oil'
    oil.setup {
      keymaps = {
        ['<C-v>'] = 'actions.select_vsplit',
        ['<C-s>'] = 'actions.select_split',
      },
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = true,
      },
    }

    vim.keymap.set('n', '<leader>e', oil.toggle_float, { desc = 'open file [e]xplorer' })
  end,
}
