return {
  {
    'stevearc/conform.nvim',
    dependencies = { 'williamboman/mason.nvim' },
    config = function()
      local conform = require 'conform'
      conform.setup {
        formatters_by_ft = {
          lua = { 'stylua' },
          yaml = { 'prettier' },
          json = { 'prettier' },
          markdown = { 'prettier' },
          ['_'] = { 'trim_whitespace' },
        },
      }
      vim.keymap.set('n', '<leader>F', conform.format, { desc = '[F]ormat with formatter' })
    end,
  },
}
