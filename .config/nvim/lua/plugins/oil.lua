return {
  'stevearc/oil.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local oil = require 'oil'
    oil.setup {
      keymaps = {
        ['<C-v>'] = 'actions.select_vsplit',
        ['<C-s>'] = 'actions.select_split',
        ['q'] = 'actions.close',
      },
      view_options = {
        -- Show files and directories that start with "."
        show_hidden = false,
      },
      float = {
        win_options = {
          winblend = 10,
        },
        -- This is the config that will be passed to nvim_open_win.
        -- Change values here to customize the layout
        override = function(conf)
          local total_rows = vim.api.nvim_get_option 'lines'
          local total_columns = vim.api.nvim_get_option 'columns'

          local height = 20
          local width = 80

          local row = (total_rows - height) / 2
          local col = (total_columns - width) / 2

          conf.width = width
          conf.height = height
          conf.row = row
          conf.col = col

          return conf
        end,
      },
    }

    vim.keymap.set('n', '<leader>e', oil.toggle_float, { desc = 'open file [e]xplorer' })
  end,
}
